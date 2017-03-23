//
//  ConversationViewController.swift
//  Hijinnks
//
//  Created by adeiji on 3/23/17.
//  Copyright © 2017 adeiji. All rights reserved.
//

import Foundation
import UIKit
import SendBirdSDK
import Parse

class ConversationViewController : UIViewController, UITableViewDataSource, SBDChannelDelegate {
    
    var toUser:PFUser
    var messages:[SBDUserMessage] = [SBDUserMessage]()
    
    var conversationView:ConversationView!
    
    init(toUser: PFUser) {
        self.toUser = toUser
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        SBDMain.add(self as SBDChannelDelegate, identifier: "test")
        self.conversationView = ConversationView()
        self.conversationView.user = toUser
        self.conversationView.setupUI()
        self.conversationView.messagesTableView.dataSource = self
        self.view.addSubview(self.conversationView)
        self.conversationView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
    }
    
    func channel(_ sender: SBDBaseChannel, didReceive message: SBDBaseMessage) {
        if message is SBDUserMessage
        {
            let message = message as! SBDUserMessage
            messages.append(message)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let messageOwner = messages[indexPath.row].sender
        var messageParseUser:PFUser!
        
        if messageOwner?.userId == PFUser.current()?.objectId {
            messageParseUser = PFUser.current()
        } else {
            messageParseUser = toUser
        }
        
        let messageCell = MessageCell(messageOwner: messageParseUser, message: messages[indexPath.row].message!)
        return messageCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
}

