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
        invitations.append(invitation)
        self.tableView.reloadData()
    }
    
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
    
    func rsvpButtonPressed(invitation: InvitationParseObject) {
        // If the user has already rsvp'd to this shindig
        if (invitation.rsvpUsers.contains((PFUser.current()?.objectId)!)) {
            invitation.rsvpUsers = invitation.rsvpUsers.filter {
                $0 != PFUser.current()?.objectId
            }
            invitation.rsvpCount = invitation.rsvpCount - 1
        }
        else {
            invitation.incrementKey(ParseObjectColumns.RSVPCount.rawValue, byAmount: 1)
            invitation.rsvpUsers.append((PFUser.current()?.objectId)!)
            let confirmationViewColor = UIColor(red: 36/255, green: 66/255, blue: 156/255, alpha: 1.0)
            Animations.showConfirmationView(type: AnimationConfirmation.Circle, message: "You RSVP'd", backgroundColor: confirmationViewColor, superView: self.view.superview!, textColor: .white)
        }
        
    }
}
