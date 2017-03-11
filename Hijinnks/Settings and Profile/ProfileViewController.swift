//
//  ProfileViewController.swift
//  Hijinnks
//
//  Created by adeiji on 3/10/17.
//  Copyright © 2017 adeiji. All rights reserved.
//

import Foundation
import UIKit
import Parse

class ProfileViewController : UIViewController, UITableViewDelegate, UITableViewDataSource {
 
    var profileView:ProfileView!
    var user:PFUser!
    var invitations:[Invitation]! = [Invitation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.profileView = ProfileView(myUser: user, myTableViewDataSourceAndDelegate: self)
        self.view.addSubview(self.profileView)
        self.profileView.setupUI()  // Setup the UI after we've added to the subview to make sure that the profile view can be set up with autolayout to it's superview
        self.getAllInvitationsFromUser()
    }
    
    // Get all the invitations that have been sent by the user of this profile view
    func getAllInvitationsFromUser () {
        let query = InvitationParseObject.query()
        query?.whereKey(ParseObjectColumns.FromUser.rawValue, equalTo: user)
        query?.findObjectsInBackground(block: { (invitationParseObjects, error) in
            if error != nil {
                // Display that there was an error retrieving the invitations
                print(error!.localizedDescription)
            }
            else {
                self.displayInvitationsForUser(invitationParseObjects: invitationParseObjects as! [InvitationParseObject]!)
            }
        })
    }
    
    // Display the invitations that this user has done in the table view for this view controller
    func displayInvitationsForUser (invitationParseObjects : [InvitationParseObject]!) {
        for invitationParseObject in invitationParseObjects! {
            let myInvitation = invitationParseObject.getInvitation()
            // Set the user to the user that is already set for this View Controller, otherwise we'll have to fetch the user from every single invitation parse object that is received from the user which would be pointless because we already have that fetched object (user) as a property for this class
            myInvitation.fromUser = user
            self.invitations?.append(myInvitation)
        }
        
        self.profileView.viewInvitationsTableView.dataSource = self
        self.profileView.viewInvitationsTableView.delegate = self
        self.profileView.viewInvitationsTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // This can happen if there are no invitations for the user or any in the area
        return invitations.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return calculateHeightForCell(invitation: invitations[indexPath.row])
    }
    
    func calculateHeightForCell (invitation: Invitation) -> CGFloat {
        let viewInvitationCell = ViewInvitationsCell(invitation: invitation)
        viewInvitationCell.contentView.layoutIfNeeded()
        let size = viewInvitationCell.contentView.systemLayoutSizeFitting(UILayoutFittingCompressedSize)
        return size.height
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewInvitationsCell = ViewInvitationsCell(invitation: invitations[indexPath.row])
        return viewInvitationsCell
    }
    
}
