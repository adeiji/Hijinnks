//
//  ViewUsersViewController.swift
//  Hijinnks
//
//  Created by adeiji on 3/13/17.
//  Copyright © 2017 adeiji. All rights reserved.
//

import Foundation
import UIKit
import Parse

class ViewUsersViewController : UITableViewController {
    
    var setting:Settings
    var friends:[PFUser] = [PFUser]()
    var groupOptions:[String] = ["All Your Friends", "Make Public to Anyone"]
    var kFriendIndexPath = 1
    var kGroupIndexPath = 0
    var delegate:PassDataBetweenViewControllersProtocol!
    
    init(setting: Settings) {
        self.setting = setting
        super.init(style: .plain)
        self.tableView.separatorColor = Colors.TableViewSeparatorColor.value
        if setting == Settings.ViewUsersInvite {
            self.tableView.allowsMultipleSelection = true
        }
        else if setting == Settings.ViewUsersAll {
            self.tableView.allowsMultipleSelection = false
        }
    }
    
    func showAllUsers () {
        let query = PFUser.query()
        query?.whereKey(ParseObjectColumns.ObjectId.rawValue, notEqualTo: PFUser.current()?.objectId! as Any)
        query?.findObjectsInBackground(block: { (users, error) in
            self.friends = users as! [PFUser]
            self.tableView.reloadData()
        })
    }
    
    func showAllFriends () {
        let friendsObjectIds = PFUser.current()?.object(forKey: ParseObjectColumns.Friends.rawValue)
        if friendsObjectIds != nil {
            let query = PFUser.query()
            query?.whereKey(ParseObjectColumns.ObjectId.rawValue, containedIn: friendsObjectIds as! [String])
            query?.findObjectsInBackground(block: { (friends, error) in
                self.friends = friends as! [PFUser]
                self.tableView.reloadData()
            })
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        if setting == Settings.ViewUsersInvite {
            let doneButton = UIBarButtonItem()
            doneButton.title = "Done"
            doneButton.target = self
            doneButton.action = #selector(doneButtonPressed)
            self.navigationItem.rightBarButtonItem = doneButton
        }
    }
    
    // Inform the delegate that the users have been selected
    func doneButtonPressed () {
        let selectedFriends = NSMutableArray()
        let indexPaths = self.tableView.indexPathsForSelectedRows
        for indexPath in indexPaths! {
            // Get each indexPath
            let user = self.friends[indexPath.row]
            selectedFriends.add(user)
        }
        
        delegate.setSelectedFriends!(mySelectedFriends: selectedFriends)
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        if setting == Settings.ViewUsersInvite {
            return 2
        }
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if setting != Settings.ViewUsersAll && section == kGroupIndexPath {
            return "Select Groups"
        }
        
        return "Friends"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if setting == Settings.ViewUsersInvite {
            if section == kFriendIndexPath {
                return self.friends.count
            }
            else {
                return self.groupOptions.count
            }
        }
        else {
            return self.friends.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if setting == Settings.ViewUsersAll {   // If we need to view all the users
            let cell = UITableViewCell(style: .default, reuseIdentifier: "userCell")
            cell.textLabel?.text = self.friends[indexPath.row].username
            return cell
        } else if setting == Settings.ViewUsersInvite {   // If the user is currently creating an invitation
            if indexPath.section == kFriendIndexPath {
                let cell = UITableViewCell(style: .default, reuseIdentifier: "userCell")
                cell.textLabel?.text = self.friends[indexPath.row].username
                return cell
            } else {
                let cell = UITableViewCell(style: .default, reuseIdentifier: "groupOptionCell")
                cell.textLabel?.text = groupOptions[indexPath.row]
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if setting == Settings.ViewUsersAll {
            let profileViewController = ProfileViewController()
            profileViewController.user = self.friends[indexPath.row]
            self.navigationController?.pushViewController(profileViewController, animated: true)
        } else if setting == Settings.ViewUsersInvite {
            if indexPath.section == kGroupIndexPath {
                if indexPath.row == 0 {  // all your friends
                    if delegate != nil {
                        delegate!.setSelectedFriendsToEveryone!()
                    }
                }
                else {
                    if delegate != nil {
                        delegate.setSelectedFriendsToAnyone!()
                    }
                }
                
                _ = self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
}
