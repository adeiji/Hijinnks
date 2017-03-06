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
    
    var invitations:[Invitation]!
    
    override func viewDidLoad() {
        invitations = [Invitation]()
        let mockUser = PFUser()
        mockUser.username = "Adebayo Ijidakinro"
        let invitation = Invitation(eventName: "Party at the Park", location: CLLocation(), details: "We're gonna grill some dogs and have a blast", message: "We're gonna grill some dogs and have a good time", startingTime: Date(), duration: "3 hrs", invitees: nil, interests: nil, fromUser: mockUser, dateInvited: Date())
        invitations.append(invitation)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // This can happen if there are no invitations for the user or any in the area
        if (invitations != nil) {
            return invitations.count
        }
        
        return 0
    }

    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func calculateHeightForCell (invitation: Invitation) -> CGFloat {
        let viewInvitationCell = ViewInvitationsCell(invitation: invitation)
        viewInvitationCell.contentView.layoutIfNeeded()
        let size = viewInvitationCell.contentView.systemLayoutSizeFitting(UILayoutFittingCompressedSize)
        return size.height + 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewInvitationsCell = ViewInvitationsCell(invitation: invitations[indexPath.row])
        return viewInvitationsCell
    }
    
    func addInvitation(invitation: Invitation) {
        // Add the new invitation and update the display
        invitations.append(invitation)
        self.tableView.reloadData()
    }
    
}
