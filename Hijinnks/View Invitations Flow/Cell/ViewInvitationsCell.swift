//
//  ViewInvitationsCell.swift
//  Hijinnks
//
//  Created by adeiji on 3/3/17.
//  Copyright © 2017 adeiji. All rights reserved.
//

import Foundation
import UIKit

class ViewInvitationsCell : UITableViewCell {
    
    weak var headerView:UIView!
    weak var profileImageView:UIImageView!
    weak var invitedDateLabel:UILabel!
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
    weak var rsvpLabel:UILabel!
    var invitation:Invitation
    
    required init(invitation: Invitation) {
        self.invitation = invitation
        super.init(style: .default, reuseIdentifier: nil)
        
        setupUI()
    }
    
    func setupUI () {
        self.contentView.autoresizingMask = .flexibleHeight
        self.autoresizingMask = .flexibleHeight
        // Set the very large sized content view so that the contentView will shrink.  There seems to be an iOS bug with it growing in size
        self.contentView.bounds = CGRect(x: 0, y: 0, width: 9999, height: 9999)
        
        headerView = setHeaderView()
        profileImageView = setProfileImageView()
        invitedDateLabel = setInvitedDateLabel()
        fromLabel = setFromLabel()
        fromUserLabel = setFromUserLabel()
        timeLabel = setTimeLabel()
        startTimeLabel = setStartTimeLabel()
        toLabel = setToLabel()
        toUserLabel = setToUserLabel()
        messageLabel = setMessageLabel()
        messageDataLabel = setMessageDataLabel()
        footerView = setFooterView()
        mapButton = setMapButton()
        likeButton = setLikeButton()
        rsvpLabel = setRSVPLabel()
    }
    
    // View at the top of the cell which contains the data invited and the profile picture
    func setHeaderView () -> UIView {
        let view = UIView()
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.gray.cgColor
        self.contentView.addSubview(view)
        view.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView)
            make.top.equalTo(self.contentView)
            make.right.equalTo(self.contentView)
            make.height.equalTo(65)
        }
        
        return view
    }
 
    // Profile view which will display the profile image of the person who invited you on the top left of the table view cell
    func setProfileImageView () -> UIImageView {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = imageView.frame.size.height / 2
        headerView.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.left.equalTo(headerView).offset(3)
            make.top.equalTo(headerView).offset(3)
            make.bottom.equalTo(headerView).offset(3)
            make.height.equalTo(imageView.snp.width)
        }
        
        return imageView
    }
    
    // Display the data the user was invited
    func setInvitedDateLabel () -> UILabel {
        let label = UILabel()
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        let startDateAndTime = "Invited: " + StyledDate.getDateAsString(date: self.invitation.dateInvited)
        label.text =  startDateAndTime
        headerView.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.center.equalTo(headerView)
        }
        
        return label
    }
    
    func setFromLabel () -> UILabel {
        let label = UILabel()
        label.text = "From: "
        label.font = UIFont.systemFont(ofSize: 18, weight: UIFontWeightBold)
        self.contentView.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView).offset(20)
            make.top.equalTo(headerView.snp.bottom).offset(35)
            make.height.equalTo(30)
        }
        
        return label
    }
    
    // Display From: [PFUser]
    func setFromUserLabel () -> UILabel {
        let label = UILabel()
        label.text = invitation.fromUser.username!
        label.textColor = Colors.invitationTextGrayColor.value
        self.contentView.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.left.equalTo(fromLabel.snp.right).offset(10)
            make.centerY.equalTo(fromLabel)
        }
        
        return label
    }
    // Displays the start time of the event
    func setTimeLabel () -> UILabel {
        let label = UILabel()
        self.contentView.addSubview(label)
        label.font = UIFont.systemFont(ofSize: 18, weight: UIFontWeightBold)
        label.text = "Time: "
        label.snp.makeConstraints { (make) in
            make.left.equalTo(fromLabel)
            make.top.equalTo(fromLabel.snp.bottom).offset(5)
        }
        
        return label
    }
    
    func setStartTimeLabel () -> UILabel {
        let label = UILabel()
        self.contentView.addSubview(label)
        label.text = StyledDate.getDateAsString(date: self.invitation.startingTime)
        label.textColor = Colors.invitationTextGrayColor.value
        label.snp.makeConstraints { (make) in
            make.left.equalTo(fromUserLabel)
            make.centerY.equalTo(timeLabel)
        }
        
        return label
    }
    
    // Display just the label that says To:
    func setToLabel () -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: UIFontWeightBold)
        self.contentView.addSubview(label)
        label.text = "To:"
        label.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView).offset(35)
            make.top.equalTo(startTimeLabel.snp.bottom).offset(20)
            make.width.equalTo(30)
        }
        
        return label
    }
    
    func setToUserLabel () -> UILabel {
        let label = UILabel()
        self.contentView.addSubview(label)
        label.textColor = Colors.invitationTextGrayColor.value
        label.text = "Adebayo Ijidakinro"  // Current User Name
        label.snp.makeConstraints { (make) in
            make.left.equalTo(toLabel.snp.right).offset(65)
            make.centerY.equalTo(toLabel)
        }
        
        return label
    }
    
    func setMessageLabel () -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: UIFontWeightBold)
        self.contentView.addSubview(label)
        label.text = "Message:"
        label.snp.makeConstraints { (make) in
            make.left.equalTo(toLabel)
            make.top.equalTo(toLabel.snp.bottom).offset(5)
        }
        
        return label
    }
    
    func setMessageDataLabel () -> UILabel {
        let label = UILabel()
        self.contentView.addSubview(label)
        label.text = invitation.message
        label.textColor = Colors.invitationTextGrayColor.value
        label.numberOfLines = 0
        label.snp.makeConstraints { (make) in
            make.left.equalTo(toUserLabel)
            make.top.equalTo(messageLabel)
            make.right.equalTo(self.contentView).offset(-20)
        }
        
        return label
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // View at the bottom that contains the map, like and rsvp buttons
    func setFooterView () -> UIView {
        let view = UIView()
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.gray.cgColor
        self.contentView.addSubview(view)
        view.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView)
            make.bottom.equalTo(self.contentView)
            make.right.equalTo(self.contentView)
            make.top.equalTo(messageDataLabel.snp.bottom).offset(45)
            make.height.equalTo(headerView)
        }
        return view
    }
    
    // Button that will display the map to the user when pressed
    func setMapButton () -> HijinnksButton {
        let button = HijinnksButton(customButtonType: .MapButton)
        self.footerView.addSubview(button)
        button.snp.makeConstraints { (make) in
            make.left.equalTo(35)
            make.top.equalTo(footerView).offset(15)
            make.bottom.equalTo(footerView).offset(-15)
            make.width.equalTo(button.snp.height)
        }
        return button
    }
    
    // This is the like button which is shaped as a heart that they can click on to like the invitation
    func setLikeButton () -> HijinnksButton {
        let button = HijinnksButton(customButtonType: .LikeButtonEmpty)
        button.addTarget(self, action: #selector(likeButtonPressed(likeButton:)), for: .touchUpInside)
        self.footerView.addSubview(button)
        button.snp.makeConstraints { (make) in
            make.center.equalTo(self.footerView)
            make.top.equalTo(mapButton)
            make.bottom.equalTo(mapButton)
            make.width.equalTo(button.snp.height)
        }        
        return button
    }
    
    func setRSVPLabel () -> UILabel {
        let label = UILabel()
        label.text = "112 RSVP'd"
        self.footerView.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.right.equalTo(self.footerView).offset(-35)
            make.centerY.equalTo(mapButton)
        }
        
        return label
    }
    
    func likeButtonPressed (likeButton: HijinnksButton) {
        if likeButton.customButtonType == .LikeButtonEmpty {
            likeButton.customButtonType = .LikeButtonFilled
            likeButton.setNeedsDisplay()
        }
        else if likeButton.customButtonType == .LikeButtonFilled {
            likeButton.customButtonType = .LikeButtonEmpty
            likeButton.setNeedsDisplay()
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
