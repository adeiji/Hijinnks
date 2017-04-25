//
//  QuickInviteController.swift
//  Hijinnks
//
//  Created by adeiji on 4/23/17.
//  Copyright © 2017 adeiji. All rights reserved.
//

import Foundation
import Parse

class QuickInviteController : NSObject {
    
    let invitation:InvitationParseObject = InvitationParseObject()
    var quickInviteView:QuickInviteView!
    
    override init() {
        super.init()
        self.quickInviteView = QuickInviteView()
        self.quickInviteView.setupUI()
        self.quickInviteView.publicButton.addTarget(self, action: #selector(publicButtonPressed), for: .touchUpInside)
        self.quickInviteView.allFriendsButton.addTarget(self, action: #selector(allFriendsButtonPressed), for: .touchUpInside)
    }
    
    /**
     * - Description - When the public button is pressed, sets the invitations view scope to public
     */
    func publicButtonPressed () {
        self.invitation.isPublic = true
    }
    
    func allFriendsButtonPressed () {
        // Get all the user's friends' object ids
        let friendIds = DEUserManager.sharedManager.getFriends(user: PFUser.current()!)
        // Get all the user's friends' objects
        let friendObjects = UtilityFunctions.getParseUserObjectsFromObjectIds(user: PFUser.current()!, objectIds: friendIds!)
        self.invitation.invitees = friendObjects!
        self.invitation.isPublic = false
    }
    
    func updateInvitationViewScopeButtonLayouts () {
        // User just pressed the "Public" button
        if invitation.isPublic == true {
            self.quickInviteView.publicButton.backgroundColor = .white
            self.quickInviteView.publicButton.layer.borderColor = Colors.blue.value.cgColor
            self.quickInviteView.publicButton.layer.borderWidth = 2.0
        }
        else {
            self.quickInviteView.allFriendsButton.backgroundColor = Colors.blue.value
            self.quickInviteView.allFriendsButton.layer.borderWidth = 0.0
        }
    }
}
