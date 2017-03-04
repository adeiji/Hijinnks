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
    var invitation:Invitation
    
    required init(invitation: Invitation) {
        self.invitation = invitation
        super.init(style: .default, reuseIdentifier: nil)
        setupUI()
    }
    
    func setupUI () {
        headerView = setHeaderView()
        profileImageView = setProfileImageView()
        invitedDateLabel = setInvitedDateLabel()
    }
    
    // View at the top of the cell which contains the data invited and the profile picture
    func setHeaderView () -> UIView {
        let view = UIView()
        self.contentView.addSubview(view)
        view.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView)
            make.top.equalTo(self.contentView)
            make.right.equalTo(self.contentView)
            make.height.equalTo(75)
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
        let startDateAndTime = "Invited: " + dateFormatter.string(from: self.invitation.startingTime)
        label.text =  startDateAndTime
        headerView.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.center.equalTo(headerView)
        }
        
        return label
    }
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
