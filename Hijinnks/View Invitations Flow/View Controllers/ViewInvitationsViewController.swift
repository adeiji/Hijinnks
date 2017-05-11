//
//  ViewInvitationsViewController.swift
//  Hijinnks
//
//  Created by adeiji on 2/23/17.
//  Copyright © 2017 adeiji. All rights reserved.
//

import Foundation
import UIKit
import Parse

// This is basically the home screen.  When the user opens the app they will be able to view all invitations from this page
class ViewInvitationsViewController : UITableViewController, PassDataBetweenViewControllersProtocol {
    
    let parseQueue = DispatchQueue(label: "com.parse.handler")
    var invitations:[InvitationParseObject] = [InvitationParseObject]()
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
    
    override func viewDidLoad() {
        
        self.view.backgroundColor = UIColor(hexString: "#ebebeb")
        self.tableView.backgroundColor = .white
        
        startActivitySpinner()
        self.tableView.separatorStyle = .none
        
        parseQueue.async {
            let invitationParseObjects = ParseManager.getAllInvitationsNearLocation()
            for invitationParseObject in invitationParseObjects! {
                do {
                    try invitationParseObject.fromUser.fetchIfNeeded()
                }
                catch {
                    print(error.localizedDescription)
                    // Display to user that there was an error getting the data
                }
                
                self.invitations.append(invitationParseObject)
            }
            DispatchQueue.main.async(execute: { 
                self.tableView.reloadData()
                self.tabBarController?.tabBar.isUserInteractionEnabled = true
                self.activitySpinner.removeFromSuperview()
            });
        }
        
        // Remove the activity spinner
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // This can happen if there are no invitations for the user or any in the area
        return invitations.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return calculateHeightForCell(invitation: invitations[indexPath.row])
    }
    
    func calculateHeightForCell (invitation: InvitationParseObject) -> CGFloat {
        let viewInvitationCell = ViewInvitationsCell(invitation: invitation, delegate: self)
        viewInvitationCell.contentView.layoutIfNeeded()
        let size = viewInvitationCell.contentView.systemLayoutSizeFitting(UILayoutFittingCompressedSize)
        return size.height
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewInvitationsCell = ViewInvitationsCell(invitation: invitations[indexPath.row], delegate: self)
        return viewInvitationsCell
    }
    
    func addInvitation(invitation: InvitationParseObject) {
        // Add the new invitation and update the display
        // Get the invitation with the TempId that was just created for this object from the server and add to the top of the tableview
        var downloadedInvitations:[InvitationParseObject]!
        parseQueue.async {
            let query = InvitationParseObject.query()
            query?.whereKey(ParseObjectColumns.TempId.rawValue, equalTo: invitation.value(forKey: ParseObjectColumns.TempId.rawValue)!)
            
            do
            {
                downloadedInvitations = try query?.findObjects() as? [InvitationParseObject]
                if downloadedInvitations != nil {
                    try downloadedInvitations?.first?.fromUser.fetchIfNeeded()
                }
            }
            catch
            {
                print(error.localizedDescription)
                // FIXME: Display to user that there was an error getting the data
            }
            DispatchQueue.main.async(execute: {
                if downloadedInvitations != nil {
                    self.invitations.insert(downloadedInvitations.first!, at: 0)
                    let indexPath:IndexPath = IndexPath(row: 0, section: 0)
                    self.tableView.insertRows(at: [indexPath], with: .top)
                }
            });
        }
        self.tableView.reloadData()
    }
}

// PassDataBetweenViewControllersProtocol Methods
extension ViewInvitationsViewController {
    /**
     * - Description Delegate method that is called when a user presses the Comment button on the ViewInvitationCell object
     * - Parameter invitation <Invitation> The invitation which the comment button was pressed for
     * - Code delegate.showInvitationCommentScreen(invitation: invitation)
     */
    func showInvitationCommentScreen(invitation: InvitationParseObject) {
        let commentViewController = CommentViewController(invitation: invitation)
        self.navigationController?.pushViewController(commentViewController, animated: true)
    }
    
    func commentButtonPressed (invitation: InvitationParseObject) {
        let commentViewController = CommentViewController(invitation: invitation)
        self.navigationController?.pushViewController(commentViewController, animated: true)
    }
    
    func rsvpButtonPressed(invitation: InvitationParseObject, invitationCell: ViewInvitationsCell) {
        let rsvpCount = invitation.fromUser.value(forKey: ParseObjectColumns.RSVPCount.rawValue) as? Int
        if rsvpCount == nil {
            invitation.fromUser.setValue(0, forKey: ParseObjectColumns.RSVPCount.rawValue)
        }
        
        // If the user who pressed the rsvp button is not the owner of this invitation
        if UtilityFunctions.isCurrent(user: invitation.fromUser) == false {
            // If the user has already rsvp'd to this shindig
            if (invitation.rsvpUsers.contains((PFUser.current()?.objectId)!)) {
                invitation.rsvpUsers = invitation.rsvpUsers.filter {
                    $0 != PFUser.current()?.objectId
                }
                invitation.rsvpCount = invitation.rsvpCount - 1
                invitation.fromUser.incrementKey(ParseObjectColumns.RSVPCount.rawValue, byAmount: -1)
            }
            else {
                invitation.fromUser.incrementKey(ParseObjectColumns.RSVPCount.rawValue)
                invitation.incrementKey(ParseObjectColumns.RSVPCount.rawValue, byAmount: 1)
                invitation.rsvpUsers.append((PFUser.current()?.objectId)!)
                let confirmationViewColor = UIColor(red: 36/255, green: 66/255, blue: 156/255, alpha: 1.0)
                Animations.showConfirmationView(type: AnimationConfirmation.Circle, message: "You RSVP'd", backgroundColor: confirmationViewColor, superView: self.view.superview!, textColor: .white)
            }
            // Apparently I can't save a user who has not been logged in.  Which I guess makes sense, but we need to possibly figure a way aroun d this            
            invitation.saveInBackground()
            if PFUser.current() == invitation.fromUser {
                PFUser.current()?.setValue(invitation.fromUser.value(forKey: ParseObjectColumns.RSVPCount.rawValue), forKey: ParseObjectColumns.RSVPCount.rawValue)
            }
            
            // Update the view of the invitation cell
            invitationCell.resetRsvpView()
        }
        else {  // I the user who pressed the RSVP button is the owner of this invitation
            let viewUsersViewController = ViewUsersViewController(setting: .ViewUsersAll, willPresentViewController: false)
            viewUsersViewController.showSpecificUsers(userObjectIds: invitation.rsvpUsers)
            self.navigationController?.pushViewController(viewUsersViewController, animated: true)
        }
    }
    
    func profileImagePressed(user: PFUser) {
        let profileViewController = ProfileViewController(user: user)
        self.navigationController?.pushViewController(profileViewController, animated: true)
    }
}
    
