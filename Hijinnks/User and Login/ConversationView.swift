//
//  ConversationView.swift
//  Hijinnks
//
//  Created by adeiji on 3/23/17.
//  Copyright © 2017 adeiji. All rights reserved.
//

import Foundation
import UIKit
import Parse

class ConversationView : UIView {
    
    var listOfUsersView:UIView!
    var messagesTableView:UITableView!
    var messageTextField:UITextField!
    var user:PFUser!
    var keyboardHeight:CGFloat!
    var sendButton:UIButton!
    
    init() {
        super.init(frame: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI () {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
        setListOfUsersView()
        setMessageTextField()
        setMessagesTableView()
        setSendButton()
        self.backgroundColor = .white
    }
    
    func keyboardWillShow (notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardHeight = keyboardSize.height
            self.messageTextField.snp.makeConstraints { (make) in
                make.left.equalTo(self).offset(5)
                make.right.equalTo(self).offset(-75)
                make.bottom.equalTo(self).offset(-keyboardHeight)
                make.height.equalTo(50)
            }
        }
    }
    
    func setSendButton () {
        self.sendButton = UIButton()
        self.sendButton.setTitle("Send", for: .normal)
        self.sendButton.setTitleColor(.white, for: .normal)
        self.sendButton.backgroundColor = Colors.blue.value
        self.addSubview(self.sendButton)
        self.sendButton.snp.makeConstraints { (make) in
            make.right.equalTo(self)
            make.width.equalTo(75)
            make.height.equalTo(50)
            make.centerY.equalTo(self.messageTextField)
        }
    }
    
    func setMessageTextField () {
        self.messageTextField = UITextField()
        self.messageTextField.becomeFirstResponder()
        self.messageTextField.backgroundColor = .white
        self.addSubview(self.messageTextField)
    }
    
    func setMessagesTableView () {
        self.messagesTableView = UITableView()
        self.messagesTableView.separatorStyle = .none
        self.addSubview(self.messagesTableView)
        self.messagesTableView.snp.makeConstraints { (make) in
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.top.equalTo(listOfUsersView.snp.bottom)
            make.bottom.equalTo(self.messageTextField.snp.top)
        }
    }
    
    func setListOfUsersView () {
        self.listOfUsersView = UIView()
        self.listOfUsersView.backgroundColor = .white
        self.listOfUsersView.layer.borderColor = UIColor.black.cgColor
        self.listOfUsersView.layer.borderWidth = 0.5
        self.showUsers()
        self.addSubview(self.listOfUsersView)
        self.listOfUsersView.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(-1)
            make.top.equalTo(self)
            make.right.equalTo(self).offset(1)
            make.height.equalTo(75)
        }
    }
    
    // Show a list of users that are part of this conversation
    func showUsers () {
        
        let profileImageView = UIImageView()
        loadProfileImage(profileImageView: profileImageView)
        let profileNameLabel = UILabel()
        profileNameLabel.text = self.user.username
        self.listOfUsersView.addSubview(profileImageView)
        self.listOfUsersView.addSubview(profileNameLabel)
        
        profileImageView.snp.makeConstraints { (make) in
            make.left.equalTo(self.listOfUsersView).offset(10)
            make.centerY.equalTo(self.listOfUsersView)
            make.height.equalTo(50)
            make.width.equalTo(50)
        }
        profileImageView.layer.cornerRadius = 25
        profileImageView.clipsToBounds = true
        
        profileNameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(profileImageView.snp.right).offset(5)
            make.centerY.equalTo(self.listOfUsersView)
        }
    }
    
    // Get the image from the server and display it
    func loadProfileImage (profileImageView: UIImageView!) {
        if self.user.value(forKey: ParseObjectColumns.Profile_Picture.rawValue) != nil {
            let imageData = self.user.value(forKey: ParseObjectColumns.Profile_Picture.rawValue) as! PFFile
            imageData.getDataInBackground { (data: Data?, error: Error?) in
                let image = UIImage(data: data!)
                if image != nil {
                    profileImageView.image = image
                }
            }
        }
    }
}

class MessageCell : UITableViewCell {
    weak var messageLabel:UILabel!
    weak var messageOwnerLabel:UILabel!
    var messageOwner:PFUser
    var message:String
    
    init(messageOwner: PFUser, message: String) {
        self.messageOwner = messageOwner
        self.message = message
        super.init(style: .default, reuseIdentifier: "message")
        
        self.setMessageOwnerLabel()
        self.setMessageLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setMessageOwnerLabel () {
        self.messageOwnerLabel = UILabel()
        self.messageOwnerLabel.font = UIFont.systemFont(ofSize: 12)
        self.messageOwnerLabel.text = messageOwner.username
        self.messageOwnerLabel.snp.makeConstraints { (make) in
            make.right.equalTo(self.contentView).offset(-20)
            make.top.equalTo(self.contentView).offset(10)
        }
    }
    
    func setMessageLabel () {
        self.messageLabel = UILabel()
        self.messageLabel.text = message
        self.contentView.addSubview(self.messageLabel)
        self.messageLabel.snp.makeConstraints { (make) in
            if messageOwner == PFUser.current() {
                make.right.equalTo(self.messageOwnerLabel)
                make.left.equalTo(self.contentView).offset(75)
            }
            make.top.equalTo(self.messageOwnerLabel.snp.bottom).offset(5)
        }
    }
}
