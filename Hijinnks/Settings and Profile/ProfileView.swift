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

class ProfileView : UIView {
    
    weak var usernameLabel:UILabel!
    weak var editProfileButton:UIButton!
    weak var optionsButton:UIButton!
    weak var profileImage:UIImageView!
    weak var bioTextView:UITextView!
    weak var interestsView:InterestsView!
    weak var followersLabel:UILabel!
    weak var followingLabel:UILabel!
    weak var inviteesLabel:UILabel!
    weak var rsvpLabel:UILabel!
    weak var viewInvitationsTableView:UITableView!
    weak var profileImageView:UIImageView!
    weak var addFriendButton:UIButton!
    var tableViewDataSourceAndDelegate:UIViewController!
    weak var user:PFUser!
    
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
        setProfileImageView()
    }
    
    
    func setProfileImageView () {
        let profileImageView = UIImageView()
        profileImageView.image = nil
        profileImageView.backgroundColor = Colors.invitationTextGrayColor.value
        profileImageView.layer.cornerRadius = 50
        self.addSubview(profileImageView)
        profileImageView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.top.equalTo(self).offset(15)
            make.width.equalTo(100)
            make.height.equalTo(100)
        }
        self.profileImageView = profileImageView
        self.profileImageView.clipsToBounds = true
        setUsernameLabel(myProfileImageView: self.profileImageView)
        loadProfileImage()
    }
    
    // Get the image from the server and display it
    func loadProfileImage () {
        let imageData = PFUser.current()?.value(forKey: ParseObjectColumns.Profile_Picture.rawValue) as! PFFile
        imageData.getDataInBackground { (data: Data?, error: Error?) in
            let image = UIImage(data: data!)
            if image != nil {
                self.profileImageView.image = image
            }
        }
    }

    func setUsernameLabel (myProfileImageView: UIImageView) {
        let myUsernameLabel = UILabel()
        myUsernameLabel.text = user.username
        myUsernameLabel.font = UIFont.systemFont(ofSize: 18)
        self.addSubview(myUsernameLabel)
        myUsernameLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
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
        self.addSubview(addFriendButton)
        addFriendButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
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
        self.addSubview(editProfileButton)
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
        self.addSubview(optionsButton)
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
        self.addSubview(bioTextView)
        bioTextView.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(UIConstants.ProfileViewHorizontalSpacing.rawValue)
            make.top.equalTo(myEditProfileButton.snp.bottom).offset(UIConstants.ProfileViewVerticalSpacing.rawValue)
            make.right.equalTo(self).offset(-UIConstants.ProfileViewHorizontalSpacing.rawValue)
            make.height.equalTo(120)
        }
        
        self.bioTextView = bioTextView
        setInterestsView(myBioTextView: self.bioTextView)
    }
    
    func setInterestsView (myBioTextView: UITextView) {
        let interestsView = InterestsView()
        self.addSubview(interestsView)
        interestsView.snp.makeConstraints { (make) in
            make.left.equalTo(myBioTextView)
            make.top.equalTo(myBioTextView).offset(UIConstants.ProfileViewVerticalSpacing.rawValue)
            make.right.equalTo(myBioTextView).offset(UIConstants.ProfileViewHorizontalSpacing.rawValue)
            make.height.equalTo(75)
        }
        
        self.interestsView = interestsView
        self.followersLabel = setUserDetailCountLabels(myInterestsView: self.interestsView, text: "0\nFollowers", labelOnLeft: nil, isLastLabelOnRight: false)
        self.followingLabel = setUserDetailCountLabels(myInterestsView: self.interestsView, text: "0\nFollowing", labelOnLeft: self.followersLabel, isLastLabelOnRight: false)
        self.inviteesLabel = setUserDetailCountLabels(myInterestsView: self.interestsView, text: "0\nInvitees", labelOnLeft: self.followingLabel, isLastLabelOnRight: false)
        self.rsvpLabel = setUserDetailCountLabels(myInterestsView: self.interestsView, text: "0\nRSVPs", labelOnLeft: self.inviteesLabel, isLastLabelOnRight: true)
        self.setViewInvitationsTableView(myRsvpLabel: self.rsvpLabel)
    }
    
    func setUserDetailCountLabels (myInterestsView: InterestsView, text: String, labelOnLeft: UILabel!, isLastLabelOnRight: Bool) -> UILabel {
        let detailLabel = UILabel()
        detailLabel.text = text
        detailLabel.textAlignment = .center
        detailLabel.numberOfLines = 2
        self.addSubview(detailLabel)
        let applicationWindow = UIApplication.shared.delegate?.window!
        let screenWidth = applicationWindow?.frame.size.width
        detailLabel.snp.makeConstraints { (make) in
            if labelOnLeft == nil {
                make.left.equalTo(self)
            }
            else {
                make.left.equalTo(labelOnLeft.snp.right)
            }
            make.top.equalTo(myInterestsView).offset(UIConstants.ProfileViewVerticalSpacing.rawValue)
            make.width.equalTo(screenWidth! / CGFloat(UIConstants.ProfileViewNumberOfLabelColumns.rawValue)) // Set a temp width
            if isLastLabelOnRight {
                make.right.equalTo(self)
            }
            
            make.height.equalTo(UIConstants.ProfileViewUserDetailCountsHeight.rawValue)
        
        }
        return detailLabel
    }
    
    func setViewInvitationsTableView (myRsvpLabel: UILabel) {
        let viewInvitationsTableView = UITableView()
        self.addSubview(viewInvitationsTableView)
        viewInvitationsTableView.snp.makeConstraints { (make) in
            make.left.equalTo(self)
            make.top.equalTo(myRsvpLabel.snp.bottom).offset(UIConstants.ProfileViewVerticalSpacing.rawValue)
            make.right.equalTo(self)
            make.bottom.equalTo(self).offset(-50)
        }
        self.viewInvitationsTableView = viewInvitationsTableView
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
