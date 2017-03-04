//
//  ViewInvitationsViewController.swift
//  Hijinnks
//
//  Created by adeiji on 2/23/17.
//  Copyright © 2017 adeiji. All rights reserved.
//

import Foundation
import UIKit

// This is basically the home screen.  When the user opens the app they will be able to view all invitations from this page
class ViewInvitationsViewController : UITableViewController, PassDataBetweenViewControllersProtocol {
    
    var invitations:[Invitation]!
    
    override func viewDidLoad() {
        invitations = [Invitation]()
        // Set up the UI
        let tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 0)
        self.tabBarItem = tabBarItem
        
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
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
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
