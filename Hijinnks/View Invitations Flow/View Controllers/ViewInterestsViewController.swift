//
//  ViewInterestsViewController.swift
//  Hijinnks
//
//  Created by adeiji on 2/23/17.
//  Copyright © 2017 adeiji. All rights reserved.
//

import Foundation
import UIKit
import Parse

@objc protocol PassDataBetweenViewControllersProtocol {
    @objc optional func setSelectedInterests(mySelectedInterest: NSArray)
    @objc optional func setSelectedFriends(mySelectedFriends: NSArray)
    @objc optional func setSelectedFriendsToEveryone ()
    @objc optional func setSelectedFriendsToAnyone ()
    @objc optional func addInvitation (invitation: Invitation)
    @objc optional func loggedIn ()
    @objc optional func loadInvitations (invitations: [InvitationParseObject])
}

class ViewInterestsViewController : UIViewController, UITableViewDelegate, UITableViewDataSource   {
    
    var tableData:NSArray!
    var delegate:PassDataBetweenViewControllersProtocol!
    var tableView = UITableView()
    
    func getInterests () -> NSArray {
        
        let path = Bundle.main.path(forResource: kInterestsPlistFile, ofType: fileType.plist.rawValue)
        let myInterests = NSArray(contentsOfFile: path!)
        
        return myInterests!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableData = getInterests()
        self.tableView = UITableView()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.allowsMultipleSelection = true
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(getAllSelectedInterests))
        self.navigationItem.rightBarButtonItem = doneButton
    }
    
    func showExplanationView () {
        let explanationView = ExplanationView()
        self.view.addSubview(explanationView)
        explanationView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
    }
    
    // Gets all the interests that are selected in the TableView and stores them in an array
    func getAllSelectedInterests () {
        
        let selectedRowsIndexPaths = self.tableView.indexPathsForSelectedRows
        let selectedInterests:NSMutableArray = NSMutableArray()
        
        for indexPath in selectedRowsIndexPaths! {
            let interest = tableData[indexPath.row]
            selectedInterests.add(interest)
        }
        
        delegate.setSelectedInterests!(mySelectedInterest: selectedInterests as NSArray)
        _ = self.navigationController?.popViewController(animated: true)
    }
}

extension ViewInterestsViewController {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Interests"
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = (tableData[indexPath.row] as! String)
        
        return cell
    }
}
