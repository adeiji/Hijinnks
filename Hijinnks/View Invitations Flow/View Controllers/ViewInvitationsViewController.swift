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
    var invitations:[Invitation] = [Invitation]()
    var activitySpinner:UIActivityIndicatorView!
    
    func startActivitySpinner () {
        // Add the activity spinner
        self.activitySpinner = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        self.activitySpinner.startAnimating()
        self.activitySpinner.hidesWhenStopped = true
        self.tabBarController?.tabBar.isUserInteractionEnabled = false
        
        self.view.addSubview(self.activitySpinner)
        self.activitySpinner.snp.makeConstraints { (make) in
            make.center.equalTo(self.view)
        }
    }
    
    override func viewDidLoad() {
        startActivitySpinner()
        self.tableView.separatorColor = Colors.TableViewSeparatorColor.value
        self.tabBarController?.tabBar.isUserInteractionEnabled = false
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
                let invitation = invitationParseObject.getInvitation()
                self.invitations.append(invitation)
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
    
    func calculateHeightForCell (invitation: Invitation) -> CGFloat {
        let viewInvitationCell = ViewInvitationsCell(invitation: invitation)
        viewInvitationCell.contentView.layoutIfNeeded()
        let size = viewInvitationCell.contentView.systemLayoutSizeFitting(UILayoutFittingCompressedSize)
        return size.height
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
