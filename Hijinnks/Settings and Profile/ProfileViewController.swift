//
//  ProfileViewController.swift
//  Hijinnks
//
//  Created by adeiji on 3/10/17.
//  Copyright © 2017 adeiji. All rights reserved.
//

import Foundation
import UIKit
import Parse
import SendBirdSDK

class ProfileViewController : UIViewController, UITableViewDelegate, UITableViewDataSource, PassDataBetweenViewControllersProtocol, UIGestureRecognizerDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
 
    var profileView:ProfileView!
    var user:PFUser!
    var invitations:[InvitationParseObject]! = [InvitationParseObject]()
    var activitySpinner:UIActivityIndicatorView!
    
    func startActivitySpinner () {
        // Add the activity spinner
        self.activitySpinner = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        self.activitySpinner.startAnimating()
        self.activitySpinner.hidesWhenStopped = true
        self.view.addSubview(self.activitySpinner)
        self.activitySpinner.snp.makeConstraints { (make) in
            make.center.equalTo(self.view)
        }
    }
    
    init(user: PFUser) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.profileView = ProfileView(myUser: self.user, myTableViewDataSourceAndDelegate: self)
        self.view.addSubview(self.profileView)
        self.profileView.setupUI()  // Setup the UI after we've added to the subview to make sure that the profile view can be set up with autolayout to it's superview
        self.getAllInvitationsFromUser()
        if self.profileView.addFriendButton != nil {
            // If the user is not a friend
            if self.profileView.isFriend == false {
                self.profileView.addFriendButton.addTarget(self, action: #selector(addFriendButtonPressed), for: .touchUpInside)
            } // If the user is a friend
            else {
                self.profileView.addFriendButton.addTarget(self, action: #selector(removeFriendButtonPressed), for: .touchUpInside)
            }
        }
        // Only allow the user to edit the profile image if the user is looking at his own profile page
        if UtilityFunctions.isCurrent(user: self.user) == true {
            self.profileView.imageViewTapRecognizer.addTarget(self, action: #selector(profileImageTapped))
            self.profileView.imageViewTapRecognizer.delegate = self
            let optionsButton = HijinnksButton(customButtonType: .SettingsButton)
            optionsButton.layoutIfNeeded()
            optionsButton.addTarget(self, action: #selector(displayProfileOptions), for: .touchUpInside)
            optionsButton.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
            let optionsBarItem = UIBarButtonItem(customView: optionsButton)
            self.navigationItem.setRightBarButton(optionsBarItem, animated: true)
        }
        else {
            let messageButton = HijinnksButton(customButtonType: .CommentButton)
            messageButton.addTarget(self, action: #selector(messageButtonPressed), for: .touchUpInside)
            messageButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
            let messageBarItem = UIBarButtonItem(customView: messageButton)
            self.navigationItem.setRightBarButton(messageBarItem, animated: true)
        }
    }
    
    func messageButtonPressed () {
        let userIds:[String] = [self.user.objectId!, (PFUser.current()?.objectId)!]
        self.createConversationChannel(userIds: userIds)
    }
    
    func profileImageTapped () {
        let photoHandler = PhotoHandler(viewController: self)
        _ = photoHandler.promptForPicture()
    }
    
    // Display the interests page to allow the user to affiliate their friend with specific interests
    func addFriendButtonPressed () {
        let viewInterestsViewController = ViewInterestsViewController(setting: Settings.ViewInterestsAddFriend, willPresentViewController: false)
        viewInterestsViewController.delegate = self
        self.navigationController?.pushViewController(viewInterestsViewController, animated: true)
        self.profileView.addFriendButton.removeTarget(self, action: #selector(addFriendButtonPressed), for: .touchUpInside)
        self.profileView.addFriendButton.addTarget(self, action: #selector(removeFriendButtonPressed), for: .touchUpInside)
        self.profileView.addFriendButton.setTitle("Unfriend", for: .normal)
    }
    
    func removeFriendButtonPressed () {
        PFUser.current()?.remove(user.objectId!, forKey: ParseObjectColumns.Friends.rawValue)
        self.user.remove(PFUser.current()!.objectId!, forKey: ParseObjectColumns.Followers.rawValue)
        PFUser.current()?.saveInBackground()
        self.user.saveInBackground()
        self.profileView.addFriendButton.setTitle("Add Friend", for: .normal)
    }
    
    // When the user sets the interests for the friend that they're adding than we add the friend and attribute the friend to specific interests
    func setSelectedInterests(mySelectedInterest: Array<String>) {
        // The name of the interests_group will be set to whatever the name of the interests is that was selected
        // So we go through each interests and add this new friend to the interests selected
        for interest in mySelectedInterest {
            let myInterestGroup = InterestsGroupParseObject()
            myInterestGroup.name = interest
            myInterestGroup.friend = user
            myInterestGroup.owner = PFUser.current()!
            myInterestGroup.saveEventually()
        }
        
        // Add the friend and save to the server.  Update the users followers
        PFUser.current()?.add(user.objectId!, forKey: ParseObjectColumns.Friends.rawValue)
        self.user.add(PFUser.current()!.objectId!, forKey: ParseObjectColumns.Followers.rawValue)
        PFUser.current()?.saveInBackground()
        self.user.saveInBackground()
    }
    
    func displayProfileOptions () {
        let optionsViewController = OptionsViewController()
        self.navigationController?.pushViewController(optionsViewController, animated: true)
    }
    
    // Get all the invitations that have been sent by the user of this profile view
    func getAllInvitationsFromUser () {
        
        self.startActivitySpinner()
        let query = InvitationParseObject.query()
        query?.whereKey(ParseObjectColumns.FromUser.rawValue, equalTo: self.user)
        query?.findObjectsInBackground(block: { (invitationParseObjects, error) in
            if error != nil {
                // Display that there was an error retrieving the invitations
                print(error!.localizedDescription)
            }
            else {
                self.displayInvitationsForUser(invitationParseObjects: invitationParseObjects as! [InvitationParseObject]!)
                self.activitySpinner.stopAnimating()
                self.activitySpinner.removeFromSuperview()
                self.tabBarController?.tabBar.isUserInteractionEnabled = true
            }
        })
    }
    
    // Display the invitations that this user has done in the table view for this view controller
    func displayInvitationsForUser (invitationParseObjects : [InvitationParseObject]!) {
        self.invitations = [InvitationParseObject]()
        for invitationParseObject in invitationParseObjects! {
            // Set the user to the user that is already set for this View Controller, otherwise we'll have to fetch the user from every single invitation parse object that is received from the user which would be pointless because we already have that fetched object (user) as a property for this class
            invitationParseObject.fromUser = user
            self.invitations?.append(invitationParseObject)
        }
        
        self.profileView.viewInvitationsTableView.dataSource = self
        self.profileView.viewInvitationsTableView.delegate = self
        self.profileView.viewInvitationsTableView.reloadData()
        self.profileView.viewInvitationsTableView.snp.remakeConstraints { (make) in
            make.left.equalTo(self.profileView)
            make.right.equalTo(self.profileView)            
            make.top.equalTo(self.profileView.interestsView.snp.bottom).offset(UIConstants.ProfileViewVerticalSpacing.rawValue)
            make.height.equalTo(self.profileView.viewInvitationsTableView.contentSize.height + 150)
            make.bottom.equalTo(self.profileView.wrapperView)
        }
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // This can happen if there are no invitations for the user or any in the area
        return invitations.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return calculateHeightForCell(invitation: invitations[indexPath.row])
    }
    
    func calculateHeightForCell (invitation: InvitationParseObject) -> CGFloat {
        let viewInvitationCell = ViewInvitationsCell(invitation: invitation, delegate: self)
        viewInvitationCell.contentView.layoutIfNeeded()
        let size = viewInvitationCell.contentView.systemLayoutSizeFitting(UILayoutFittingCompressedSize)
        return size.height
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewInvitationsCell = ViewInvitationsCell(invitation: invitations[indexPath.row], delegate: self)
        return viewInvitationsCell
    }
}

// Image Picker Delegate
extension ProfileViewController {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        // Show the Navigation Bar
        UtilityFunctions.showNavBar()
        picker.dismiss(animated: true, completion: nil)
        var image:UIImage!
        
        if info[UIImagePickerControllerEditedImage] != nil {
            image = info[UIImagePickerControllerEditedImage] as! UIImage
        }
        else {
            image = info[UIImagePickerControllerOriginalImage] as! UIImage
        }
        let imageData = UIImageJPEGRepresentation(image, 0.2)
        self.profileView.profileImageView.image = image
        DEUserManager.sharedManager.addProfileImage(imageData!)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Show the Navigation Bar
        UtilityFunctions.showNavBar()
    }
}

// Send Bird API Extension
extension ProfileViewController {
    /**
     * - Description Creates a channel conversation using the Send Bird API
     * - Parameter userIds - String array which contains the user ids of the two people who will be in this channel.  The max should be 2, because this is direct, 1 to 1 messaging
     * - Returns nil
     * - Code createConversationChannel([Ids of two users who are in this channel])
     */
    func createConversationChannel (userIds : [String]) {
        SBDGroupChannel.createChannel(withUserIds: userIds, isDistinct: true) { (channel, error) in
            if error != nil {
                print("Error creating channel for users with ids \(userIds) - \(error)")
                return
            }
            DispatchQueue.main.sync {
                let conversationViewController = ConversationViewController(toUser: self.user)
                conversationViewController.channel = channel                
                self.navigationController?.pushViewController(conversationViewController, animated: true)
            }            
        }
    }
}
