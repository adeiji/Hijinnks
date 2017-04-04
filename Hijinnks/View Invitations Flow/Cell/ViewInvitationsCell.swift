//
//  ViewInvitationsCell.swift
//  Hijinnks
//
//  Created by adeiji on 3/3/17.
//  Copyright © 2017 adeiji. All rights reserved.
//

import Foundation
import UIKit
import GoogleMaps
import Parse

class ViewInvitationsCell : UITableViewCell {
    
    weak var headerView:UIView!
    weak var profileImageView:UIImageView!
    weak var eventNameLabel:UILabel!
    weak var fromLabel:UILabel!
    weak var fromUserLabel:UILabel!
    weak var toLabel:UILabel!
    weak var toUserLabel:UILabel!
    weak var messageLabel:UILabel!
    weak var messageDataLabel:UILabel!
    weak var timeLabel:UILabel!
    weak var startTimeLabel:UILabel!
    weak var footerView:UIView!
    
    weak var mapButton:HijinnksButton!
    weak var likeButton:HijinnksButton!
    weak var rsvpButton:UIButton!
    weak var commentButton:UIButton!
    
    weak var addressDataLabel:UILabel!
    weak var addressLabel:UILabel!
    weak var interestsLabel:UILabel!
    weak var interestsDataLabel:UILabel!
    weak var mapView:UIView!
    var invitation:InvitationParseObject
    var isMapShown:Bool = false
    
    let delegate:PassDataBetweenViewControllersProtocol // View Controller Handling the View
    var imageTapGestureRecognizer:UITapGestureRecognizer! // Must keep a reference to this object otherwise the tap gesture recognizer will not work
    
    required init(invitation: InvitationParseObject, delegate: PassDataBetweenViewControllersProtocol) {
        self.invitation = invitation
        self.delegate = delegate
        super.init(style: .default, reuseIdentifier: nil)        
        setupUI()
    }
    
    func setupUI () {
        self.contentView.autoresizingMask = .flexibleHeight
        self.autoresizingMask = .flexibleHeight
        // Set the very large sized content view so that the contentView will shrink.  There seems to be an iOS bug with it growing in size
        self.contentView.bounds = CGRect(x: 0, y: 0, width: 9999, height: 9999)
        self.selectionStyle = .none
        let font = UIFont.systemFont(ofSize: 14)
        self.headerView = setHeaderView()
        self.profileImageView = setProfileImageView()
        self.addGestureTapToProfileImageView(imageView: self.profileImageView)
        self.eventNameLabel = setEventNameLabel(font: font)
        
        var toUserText:String!
        let invitees:Array<PFUser>! = self.invitation.invitees
        
        if self.invitation.isPublic {
            toUserText = "Anyone"
        } else {
            var inviteesCount = 0
            if invitees != nil {
                inviteesCount = invitees.count
            }
            toUserText = "You and \(inviteesCount - 1) others"
        }
        
        // To: Adebayo Ijidakinro
        self.toLabel = setDescriptionLabel(descriptionViewAbove: nil, invitationDetailViewAbove: nil, text: "To:")
        self.toUserLabel = setInvitationDetailLabel(viewToLeft: self.toLabel, text: toUserText)
        // From: Yo' Mamma
        self.fromLabel = setDescriptionLabel(descriptionViewAbove: self.toLabel, invitationDetailViewAbove: self.toUserLabel,  text: "From:")
        self.fromUserLabel = setInvitationDetailLabel(viewToLeft: self.fromLabel, text: invitation.fromUser.username!)
        // Location: 3423 Yo Mamma Drive
        self.addressLabel = setDescriptionLabel(descriptionViewAbove: self.fromLabel, invitationDetailViewAbove: self.fromUserLabel, text: "Location:")
        self.addressDataLabel = setInvitationDetailLabel(viewToLeft: self.addressLabel, text: invitation.address)
        // Time: Mar 28, 2017, 7:45 PM
        self.timeLabel = setDescriptionLabel(descriptionViewAbove: self.addressLabel, invitationDetailViewAbove: self.addressDataLabel, text: "Time:")
        let startingTime = StyledDate.getDateAsString(date: self.invitation.startingTime)
        self.startTimeLabel = setInvitationDetailLabel(viewToLeft: self.timeLabel, text: startingTime)
        // Message: We all gonna have a great time!
        self.messageLabel = setDescriptionLabel(descriptionViewAbove: self.timeLabel, invitationDetailViewAbove: self.startTimeLabel, text: "Message:")
        self.messageDataLabel = setInvitationDetailLabel(viewToLeft: self.messageLabel, text: invitation.message)
        // Interests: Sports/Exercising, Dancing, Eating Out
        self.interestsLabel = setDescriptionLabel(descriptionViewAbove: self.messageLabel, invitationDetailViewAbove: self.messageDataLabel, text: "Interests:")
        self.interestsDataLabel = setInvitationDetailLabel(viewToLeft: self.interestsLabel, text: getInterestsAsString())
        
        self.footerView = setFooterView()
        self.mapButton = setMapButton()
        self.likeButton = setLikeButton()
        self.rsvpButton = setRSVPButton(font: font)
        self.commentButton = setCommentButton()
        
    }
    
    // Takes the array of interests and turns it into a string with the interests seperated by commas
    func getInterestsAsString () -> String {
        var interestString:String = String()
        for interest in invitation.interests {
            if interest != invitation.interests.last {
                interestString = interestString + "\(interest), "
            }
            else {
                interestString = interestString + "\(interest)"
            }
        }
        return interestString
    }
    
    func setDescriptionLabel (descriptionViewAbove: UIView!, invitationDetailViewAbove: UIView!, text: String) -> UILabel {
        let myDescriptionLabel = UILabel()
        myDescriptionLabel.text = text
        myDescriptionLabel.font = UIFont.systemFont(ofSize: 14, weight: UIFontWeightBold)
        myDescriptionLabel.textAlignment = .right        
        self.contentView.addSubview(myDescriptionLabel)
        myDescriptionLabel.snp.makeConstraints { (make) in
            if descriptionViewAbove == nil {
                make.right.equalTo(self.contentView.snp.left).offset(90)
            }
            else {
                make.right.equalTo(self.contentView.snp.left).offset(90)
            }
            if invitationDetailViewAbove == nil {
                make.top.equalTo(self.headerView.snp.bottom).offset(25)
            }
            else {
                make.top.equalTo(invitationDetailViewAbove.snp.bottom).offset(UIConstants.ProfileViewVerticalSpacing.rawValue)
            }
        }
        
        return myDescriptionLabel
    }
    
    func setInvitationDetailLabel (viewToLeft: UIView, text: String) -> UILabel {
        let myInvitationDetailLabel = UILabel()
        myInvitationDetailLabel.text = text
        myInvitationDetailLabel.font = UIFont.systemFont(ofSize: 14)
        myInvitationDetailLabel.textColor = Colors.invitationTextGrayColor.value
        myInvitationDetailLabel.numberOfLines = 0
        self.contentView.addSubview(myInvitationDetailLabel)
        myInvitationDetailLabel.snp.makeConstraints { (make) in
            make.left.equalTo(viewToLeft.snp.right).offset(UIConstants.ProfileViewHorizontalSpacing.rawValue)
            make.top.equalTo(viewToLeft)
            make.right.equalTo(self.contentView).offset(-UIConstants.ProfileViewHorizontalSpacing.rawValue)
        }
        
        return myInvitationDetailLabel
    }
    
    // View at the top of the cell which contains the data invited and the profile picture
    func setHeaderView () -> UIView {
        let view = UIView()
        view.backgroundColor = .white
        self.contentView.addSubview(view)
        view.layer.borderWidth = 1
        view.layer.borderColor = Colors.invitationTextGrayColor.value.cgColor
        view.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView).offset(-1)
            make.top.equalTo(self.contentView)
            make.right.equalTo(self.contentView).offset(1)
            make.height.equalTo(50)
        }
        
        return view
    }
 
    // Profile view which will display the profile image of the person who invited you on the top left of the table view cell
    func setProfileImageView () -> UIImageView {
        let imageView = UIImageView()
        headerView.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.left.equalTo(self.headerView).offset(3)
            make.top.equalTo(self.headerView).offset(5)
            make.bottom.equalTo(self.headerView).offset(-5)
            make.height.equalTo(imageView.snp.width)
        }
        // make sure that we display the image in a circle
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 40 / 2
        self.loadProfileImage(imageView: imageView)
        return imageView
    }
    
    func addGestureTapToProfileImageView (imageView: UIImageView) {
        self.imageTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(profileImagePressed))
        self.imageTapGestureRecognizer.numberOfTapsRequired = 1
        self.imageTapGestureRecognizer.delegate = self
        self.profileImageView.isUserInteractionEnabled = true
        self.profileImageView.addGestureRecognizer(self.imageTapGestureRecognizer)
    }
    
    func profileImagePressed () {
        delegate.profileImagePressed!(user: self.invitation.fromUser)
    }
    
    // Get the image from the server and display it
    func loadProfileImage (imageView: UIImageView) {
        if invitation.fromUser.value(forKey: ParseObjectColumns.Profile_Picture.rawValue) != nil {
            let imageData = invitation.fromUser.value(forKey: ParseObjectColumns.Profile_Picture.rawValue) as! PFFile
            imageData.getDataInBackground { (data: Data?, error: Error?) in
                let image = UIImage(data: data!)
                if image != nil {
                    imageView.image = image
                }
            }
        }
    }
    
    // Display the data the user was invited
    func setEventNameLabel (font: UIFont) -> UILabel {
        let label = UILabel()
        let boldFont = UIFont.boldSystemFont(ofSize: font.pointSize)
        label.font = boldFont
        
        label.text =  self.invitation.eventName
        headerView.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.center.equalTo(self.headerView)
        }
        
        return label
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // View at the bottom that contains the map, like and rsvp buttons
    func setFooterView () -> UIView {
        let view = UIView()
        self.contentView.addSubview(view)
        view.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView).offset(-1)
            make.bottom.equalTo(self.contentView)
            make.right.equalTo(self.contentView).offset(1)
            make.top.equalTo(self.interestsDataLabel.snp.bottom).offset(35)
            make.height.equalTo(self.headerView)
        }
        return view
    }
    
    // Button that will display the map to the user when pressed
    func setMapButton () -> HijinnksButton {
        let button = HijinnksButton(customButtonType: .MapButton)
        self.footerView.addSubview(button)
        button.addTarget(self, action: #selector(displayMap), for: .touchUpInside)
        button.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.top.equalTo(self.footerView).offset(15)
            make.bottom.equalTo(self.footerView).offset(-11)
            make.width.equalTo(button.snp.height).offset(-5)
        }
        return button
    }
    
    func displayMap () {
        if self.isMapShown {
            self.mapView.removeFromSuperview()
        }
        else {
            let camera = GMSCameraPosition.camera(withLatitude: invitation.location.latitude, longitude: invitation.location.longitude, zoom: 15)
            let marker = GMSMarker(position: CLLocationCoordinate2D(latitude: invitation.location.latitude, longitude: invitation.location.longitude))
            let mapView = GMSMapView.map(withFrame: .zero, camera: camera)
            marker.map = mapView
            self.mapView = UIView()
            self.mapView = mapView
            self.addSubview(self.mapView)
            self.mapView.snp.makeConstraints { (make) in
                make.left.equalTo(self)
                make.top.equalTo(self.headerView.snp.bottom)
                make.bottom.equalTo(self.footerView.snp.top)
                make.right.equalTo(self)
            }
        }
        self.isMapShown = !self.isMapShown
    }
    
    // This is the like button which is shaped as a heart that they can click on to like the invitation
    func setLikeButton () -> HijinnksButton {
        let button = HijinnksButton(customButtonType: .LikeEmptyButton)
        button.addTarget(self, action: #selector(likeButtonPressed(likeButton:)), for: .touchUpInside)
        self.footerView.addSubview(button)
        
        button.snp.makeConstraints { (make) in
            make.top.equalTo(self.mapButton)
            make.bottom.equalTo(self.mapButton)
            make.width.equalTo(button.snp.height)
            make.left.equalTo(self.mapButton.snp.right).offset(20)
        }
        
        return button
    }
    func setRSVPButton (font: UIFont) -> UIButton {
        let button = UIButton()
        button.titleLabel?.font = font
        
        if invitation.rsvpCount >= invitation.maxAttendees && invitation.maxAttendees != InvitationConstants.NoMaxAttendeesNumber.rawValue
        {
            button.setTitleColor(.red, for: .normal)
            button.setTitle("MAXED\nOUT", for: .normal) // Display the number of people who have RSVP'd
        }
        else
        {
            button.setTitleColor(Colors.CommentButtonBlue.value, for: .normal)
            button.setTitle("\(invitation.rsvpCount!)\nRSVP'd", for: .normal) // Display the number of people who have RSVP'd
        }
        
        button.titleLabel?.lineBreakMode = .byWordWrapping
        button.titleLabel?.textAlignment = .center
        button.addTarget(self, action: #selector(updateRSVPCount), for: .touchUpInside)
        self.footerView.addSubview(button)
        button.snp.makeConstraints { (make) in
            make.right.equalTo(self.footerView).offset(-35)
            make.centerY.equalTo(self.mapButton)
        }
        
        return button
    }
    
    func setCommentButton () -> UIButton {
        let button = HijinnksButton(customButtonType: .CommentButton)
        button.addTarget(self, action: #selector(commentButtonPressed), for: .touchUpInside)
        self.footerView.addSubview(button)
        button.snp.makeConstraints { (make) in
            make.left.equalTo(self.likeButton.snp.right).offset(20)
            make.top.equalTo(self.mapButton)
            make.bottom.equalTo(self.mapButton)
            make.width.equalTo(button.snp.height)
        }
        return button
    }
    
    func commentButtonPressed () {
        delegate.showInvitationCommentScreen!(invitation: self.invitation)
    }
    
    /**
     * - Description Increase or decrease the count of those who have RSVP'd and update the users who have RSVP'd
     */
    func updateRSVPCount () {
        delegate.rsvpButtonPressed!(invitation: self.invitation) // Delegate is ViewInvitationsViewController
        self.invitation.saveInBackground()
        if invitation.rsvpCount == invitation.maxAttendees && invitation.maxAttendees != 0 {
            self.rsvpButton.setTitleColor(.red, for: .normal)
            self.rsvpButton.setTitle("MAXED\nOUT", for: .normal) // Display the number of people who have RSVP'd
        }
        else {
            self.rsvpButton.setTitleColor(Colors.invitationTextGrayColor.value, for: .normal)
            self.rsvpButton.setTitle("\(invitation.rsvpCount!)\nRSVP'd", for: .normal) // Display the number of people who have RSVP'd
        }
    }
    
    func likeButtonPressed (likeButton: HijinnksButton) {
        if likeButton.customButtonType == .LikeEmptyButton {
            likeButton.customButtonType = .LikeFilledButton
            likeButton.setNeedsDisplay()
        }
        else if likeButton.customButtonType == .LikeFilledButton {
            likeButton.customButtonType = .LikeEmptyButton
            likeButton.setNeedsDisplay()
        }
        
        // Increase the count of likes by 1 for the user
        let likes = self.invitation.fromUser.value(forKey: ParseObjectColumns.NumberOfLikes.rawValue)
        if likes != nil {
            var myLikes = likes as! Int
            myLikes += 1
            self.invitation.fromUser.setValue(myLikes, forKey: ParseObjectColumns.NumberOfLikes.rawValue)
        }
    }
}

class StyledDate {
    class func getDateAsString (date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        let formattedDateString = dateFormatter.string(from: date)
        
        return formattedDateString
    }
}
