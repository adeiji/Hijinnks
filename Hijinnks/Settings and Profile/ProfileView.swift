//
//  ProfileView.swift
//  Hijinnks
//
//  Created by adeiji on 3/10/17.
//  Copyright © 2017 adeiji. All rights reserved.
//

import Foundation
import UIKit
import Parse

// FIXME: Need to comment this code
class ProfileView : UIScrollView {
    
    weak var usernameLabel:UILabel!
    weak var editProfileButton:UIButton!
    weak var optionsButton:UIButton!
    weak var bioTextView:UITextView!
    weak var interestsView:InterestsView!
    weak var followersLabel:UILabel!
    weak var followingLabel:UILabel!
    weak var inviteesLabel:UILabel!
    weak var rsvpLabel:UILabel!
    var interestsContainerView:UIView!
    weak var viewInvitationsTableView:UITableView!
    weak var profileImageView:UIImageView!
    weak var addFriendButton:UIButton!
    var imageViewTapRecognizer:UITapGestureRecognizer!
    var tableViewDataSourceAndDelegate:UIViewController!
    weak var user:PFUser!
    weak var wrapperView:UIView!
    
    init(myUser: PFUser, myTableViewDataSourceAndDelegate: UIViewController) {
        super.init(frame: .zero)
        self.user = myUser
        self.tableViewDataSourceAndDelegate = myTableViewDataSourceAndDelegate
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI () {
        self.backgroundColor = .white
        self.snp.makeConstraints { (make) in
            make.edges.equalTo(self.superview!)
        }
        self.wrapperView = self.setWrapperView()
        setProfileImageView()
    }
    
    func setWrapperView () -> UIView {
        let view = UIView()
        self.addSubview(view)
        view.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        return view
    }
    
    func showInterests () {
        if self.user.value(forKey: ParseObjectColumns.Interests.rawValue) != nil {
            let interests = self.user.value(forKey: ParseObjectColumns.Interests.rawValue) as! [String]
            let label = UILabel(text: interests[0])
            label.textAlignment = .center
            label.textColor = .white
            self.interestsContainerView = UIView()
            self.wrapperView.addSubview(self.interestsContainerView)
            let messageLabelView = label.withPadding(padding: UIEdgeInsetsMake(5, 5, 5, 5))
            
            self.interestsContainerView.snp.makeConstraints({ (make) in
                make.left.equalTo(self.wrapperView).offset(10)
                make.right.equalTo(self.wrapperView).offset(-10)
                make.top.equalTo(self.bioTextView.snp.bottom).offset(5)
            })
            addInterest(containerView: interestsContainerView, viewInRelationTo: interestsContainerView, interests: interests, counter: 0, lineNumber: 0, messageLabelView: messageLabelView)
        }
    }
    
    
    // FIXME: This must be refactored.  Right now it's jarbled nonsense!!
    func addInterest (containerView: UIView, viewInRelationTo: UIView, interests: [String], counter: Int, lineNumber: Int, messageLabelView: UIView) {
        containerView.addSubview(messageLabelView)
        messageLabelView.backgroundColor = Colors.blue.value
        messageLabelView.layer.cornerRadius = 5
        messageLabelView.snp.makeConstraints { (make) in
            make.left.equalTo(viewInRelationTo).offset(10)
            make.top.equalTo(containerView).offset(10 + (lineNumber * 35))
        }
        
        messageLabelView.layoutIfNeeded()
        var newLineNumber:Int!
        var newViewInRelationTo:UIView!
        
        if viewInRelationTo.frame.origin.x + viewInRelationTo.frame.size.width + 10 + messageLabelView.frame.size.width > viewInRelationTo.frame.size.width - 10 {
            newLineNumber = lineNumber + 1
            newViewInRelationTo = containerView
            messageLabelView.snp.remakeConstraints { (make) in
                make.left.equalTo(viewInRelationTo).offset(10)
                make.top.equalTo(containerView).offset(10 + (lineNumber * 35))
            }
        }
        else {
            newLineNumber = lineNumber
            newViewInRelationTo = messageLabelView
        }
        
        if counter < interests.count - 1 {
            let label = UILabel(text: interests[counter + 1])
            label.textAlignment = .center
            label.textColor = .white
            let myMessageLabelView = label.withPadding(padding: UIEdgeInsetsMake(5, 5, 5, 5))
            addInterest(containerView: containerView, viewInRelationTo: newViewInRelationTo, interests: interests, counter: counter + 1, lineNumber: newLineNumber, messageLabelView: myMessageLabelView)
        }
        else {
            messageLabelView.snp.makeConstraints({ (make) in
                make.bottom.equalTo(containerView)
            })
        }
    }
    
    func setProfileImageView () {
        let profileImageView = UIImageView()
        profileImageView.image = nil
        profileImageView.backgroundColor = Colors.invitationTextGrayColor.value
        profileImageView.layer.cornerRadius = 50
        self.wrapperView.addSubview(profileImageView)
        profileImageView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.wrapperView)
            make.top.equalTo(self.wrapperView).offset(15)
            make.width.equalTo(100)
            make.height.equalTo(100)
        }
        
        self.profileImageView = profileImageView
        self.profileImageView.clipsToBounds = true
        self.profileImageView.layer.cornerRadius = 5
        
        self.imageViewTapRecognizer = UITapGestureRecognizer()
        self.imageViewTapRecognizer.numberOfTapsRequired = 1
        self.profileImageView.addGestureRecognizer(imageViewTapRecognizer)
        self.profileImageView.isUserInteractionEnabled = true
        setUsernameLabel(myProfileImageView: self.profileImageView)
        loadProfileImage()
    }
    
    // Get the image from the server and display it
    func loadProfileImage () {
        if (user.value(forKey: ParseObjectColumns.Profile_Picture.rawValue) != nil) {
            let imageData = user.value(forKey: ParseObjectColumns.Profile_Picture.rawValue) as! PFFile
            imageData.getDataInBackground { (data: Data?, error: Error?) in
                let image = UIImage(data: data!)
                if image != nil {
                    self.profileImageView.image = image
                }
            }
        }
    }

    func setUsernameLabel (myProfileImageView: UIImageView) {
        let myUsernameLabel = UILabel()
        myUsernameLabel.text = user.username
        myUsernameLabel.font = UIFont.systemFont(ofSize: 18)
        self.wrapperView.addSubview(myUsernameLabel)
        myUsernameLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.wrapperView)
            make.top.equalTo(myProfileImageView.snp.bottom).offset(25)
        }
        
        self.usernameLabel = myUsernameLabel
        if user.isEqual(PFUser.current()) {
            setEditProfileButton(myUsernameLabel: self.usernameLabel)
        } else {
            setAddFriendButton(myUsernameLabel: self.usernameLabel)
        }
    }
    
    func setAddFriendButton (myUsernameLabel: UILabel) {
        let addFriendButton = UIButton()
        addFriendButton.setTitle("Add Friend", for: .normal)
        addFriendButton.backgroundColor = .white
        addFriendButton.setTitleColor(.black, for: .normal)
        addFriendButton.layer.borderColor = Colors.invitationTextGrayColor.value.cgColor
        addFriendButton.layer.borderWidth = 1
        self.wrapperView.addSubview(addFriendButton)
        addFriendButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.wrapperView)
            make.top.equalTo(myUsernameLabel.snp.bottom).offset(UIConstants.ProfileViewVerticalSpacing.rawValue)
            make.width.equalTo(100)
            make.height.equalTo(UIConstants.ProfileViewButtonHeights.rawValue)
        }
        self.addFriendButton = addFriendButton
        setBioTextField(myOptionsButton: self.addFriendButton, myEditProfileButton: self.addFriendButton)
    }
    
    func setEditProfileButton (myUsernameLabel:UILabel) {
        let editProfileButton = UIButton()
        editProfileButton.setTitle("Edit Profile", for: .normal)
        editProfileButton.backgroundColor = .white
        editProfileButton.setTitleColor(.black, for: .normal)
        editProfileButton.layer.borderColor = Colors.invitationTextGrayColor.value.cgColor
        editProfileButton.layer.borderWidth = 1
        self.wrapperView.addSubview(editProfileButton)
        editProfileButton.snp.makeConstraints { (make) in
            make.right.equalTo(self.snp.centerX).offset(-10)
            make.top.equalTo(myUsernameLabel.snp.bottom).offset(UIConstants.ProfileViewVerticalSpacing.rawValue)
            make.width.equalTo(100)
            make.height.equalTo(UIConstants.ProfileViewButtonHeights.rawValue)
        }
        
        self.editProfileButton = editProfileButton
        setOptionsButton(myEditProfileButton: self.editProfileButton)
    }
    
    func setOptionsButton (myEditProfileButton:UIButton) {
        let optionsButton = UIButton()
        optionsButton.setTitle("Options", for: .normal)
        optionsButton.backgroundColor = .white
        optionsButton.setTitleColor(.black, for: .normal)
        optionsButton.layer.borderColor = Colors.invitationTextGrayColor.value.cgColor
        optionsButton.layer.borderWidth = 1
        self.wrapperView.addSubview(optionsButton)
        optionsButton.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.centerX).offset(10)
            make.centerY.equalTo(myEditProfileButton)
            make.width.equalTo(100)
            make.height.equalTo(myEditProfileButton)
        }
        
        self.optionsButton = optionsButton
        setBioTextField(myOptionsButton: self.optionsButton, myEditProfileButton: self.editProfileButton)
    }
    
    func setBioTextField (myOptionsButton:UIButton, myEditProfileButton: UIButton)
    {
        let bioTextView = UITextView()
        bioTextView.text = "Nothing I love more than sitting back and drinking a nice ice cold beer"
        bioTextView.textColor = .black
        self.wrapperView.addSubview(bioTextView)
        bioTextView.snp.makeConstraints { (make) in
            make.left.equalTo(self.wrapperView).offset(UIConstants.ProfileViewHorizontalSpacing.rawValue)
            make.top.equalTo(myEditProfileButton.snp.bottom).offset(UIConstants.ProfileViewVerticalSpacing.rawValue)
            make.right.equalTo(self.wrapperView).offset(-UIConstants.ProfileViewHorizontalSpacing.rawValue)
            make.height.equalTo(35)
        }
        
        self.bioTextView = bioTextView
        setInterestsView(myBioTextView: self.bioTextView)
    }
    
    func setInterestsView (myBioTextView: UITextView) {
        let interestsView = InterestsView()
        self.wrapperView.addSubview(interestsView)
        self.showInterests()
        interestsView.snp.makeConstraints { (make) in
            make.left.equalTo(myBioTextView)
            if self.interestsContainerView != nil {
                make.top.equalTo(self.interestsContainerView.snp.bottom).offset(UIConstants.ProfileViewVerticalSpacing.rawValue)
            }
            else {
                make.top.equalTo(myBioTextView.snp.bottom).offset(UIConstants.ProfileViewVerticalSpacing.rawValue)
            }
            make.right.equalTo(myBioTextView).offset(UIConstants.ProfileViewHorizontalSpacing.rawValue)
            make.height.equalTo(75)
        }
        
        self.interestsView = interestsView
        self.followersLabel = setUserDetailCountLabels(myInterestsView: self.interestsView, text: "0\nFollowers", labelOnLeft: nil, isLastLabelOnRight: false)
        self.followingLabel = setUserDetailCountLabels(myInterestsView: self.interestsView, text: "0\nFollowing", labelOnLeft: self.followersLabel, isLastLabelOnRight: false)
        self.inviteesLabel = setUserDetailCountLabels(myInterestsView: self.interestsView, text: "0\nInvitees", labelOnLeft: self.followingLabel, isLastLabelOnRight: false)
        self.rsvpLabel = setUserDetailCountLabels(myInterestsView: self.interestsView, text: "0\nRSVPs", labelOnLeft: self.inviteesLabel, isLastLabelOnRight: true)
        self.setViewInvitationsTableView(viewAbove: self.rsvpLabel)
    }
    
    func setUserDetailCountLabels (myInterestsView: InterestsView, text: String, labelOnLeft: UILabel!, isLastLabelOnRight: Bool) -> UILabel {
        let detailLabel = UILabel()
        detailLabel.text = text
        detailLabel.textAlignment = .center
        detailLabel.numberOfLines = 2
        self.wrapperView.addSubview(detailLabel)
        let applicationWindow = UIApplication.shared.delegate?.window!
        let screenWidth = applicationWindow?.frame.size.width
        detailLabel.snp.makeConstraints { (make) in
            if labelOnLeft == nil {
                make.left.equalTo(self.wrapperView)
            }
            else {
                make.left.equalTo(labelOnLeft.snp.right)
            }
            make.top.equalTo(myInterestsView).offset(UIConstants.ProfileViewVerticalSpacing.rawValue)
            make.width.equalTo(screenWidth! / CGFloat(UIConstants.ProfileViewNumberOfLabelColumns.rawValue)) // Set a temp width
            if isLastLabelOnRight {
                make.right.equalTo(self.wrapperView)
            }
            
            make.height.equalTo(UIConstants.ProfileViewUserDetailCountsHeight.rawValue)
        
        }
        return detailLabel
    }
    
    func setViewInvitationsTableView (viewAbove: UIView) {
        let viewInvitationsTableView = UITableView()
        self.wrapperView.addSubview(viewInvitationsTableView)
        viewInvitationsTableView.snp.makeConstraints { (make) in
            make.left.equalTo(self.wrapperView)
            make.top.equalTo(viewAbove.snp.bottom).offset(UIConstants.ProfileViewVerticalSpacing.rawValue)
            make.right.equalTo(self.wrapperView)
            make.bottom.equalTo(self.wrapperView).offset(-50)
        }
        self.viewInvitationsTableView = viewInvitationsTableView
        self.viewInvitationsTableView.isUserInteractionEnabled = false
    }
    
}

class InterestsView : UIView {
    init() {
        super.init(frame: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
