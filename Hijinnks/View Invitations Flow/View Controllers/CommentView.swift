//
//  CommentView.swift
//  Hijinnks
//
//  Created by adeiji on 3/26/17.
//  Copyright © 2017 adeiji. All rights reserved.
//

import Foundation
import UIKit
import Parse

class CommentView : UIView {
    
    var commentsTableView:UITableView!
    var commentTextField:UITextField!
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
        setcommentTextField()
        setcommentsTableView()
        setSendButton()
        self.backgroundColor = .white
    }
    
    func keyboardWillShow (notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardHeight = keyboardSize.height
            self.commentTextField.snp.remakeConstraints { (make) in
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
            make.centerY.equalTo(self.commentTextField)
        }
    }
    
    func setcommentTextField () {
        self.commentTextField = UITextField()
        self.commentTextField.becomeFirstResponder()
        self.commentTextField.backgroundColor = .white
        self.addSubview(self.commentTextField)
        self.commentTextField.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(5)
            make.right.equalTo(self).offset(-75)
            make.bottom.equalTo(self).offset(-75)
            make.height.equalTo(50)
        }
    }
    
    func setcommentsTableView () {
        self.commentsTableView = UITableView()
        self.commentsTableView.separatorStyle = .none
        self.commentsTableView.layer.borderWidth = 0.5
        self.commentsTableView.layer.borderColor = UIColor.gray.cgColor
        self.addSubview(self.commentsTableView)
        self.commentsTableView.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(-1)
            make.right.equalTo(self).offset(1)
            make.top.equalTo(self)
            make.bottom.equalTo(self.commentTextField.snp.top)
        }
    }
    
}

class CommentViewCell : UITableViewCell {
    
    let comment:String
    var profileImageView:UIImageView!
    var messageLabel:UILabel!
    let profileImage:UIImage!
    
    init(comment: String, profileImage: UIImage!) {
        self.comment = comment
        self.profileImage = profileImage
        super.init(style: .default, reuseIdentifier: TableViewCellIdentifiers.Comment.rawValue)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI () {
        self.contentView.autoresizingMask = .flexibleHeight
        self.autoresizingMask = .flexibleHeight
        self.contentView.bounds = CGRect(x: 0, y: 0, width: 9999, height: 9999)
        // 1.  Add the profile Image
        self.setProfileImage()
    }
    
    func setProfileImage () {
        self.profileImageView = UIImageView()
        self.contentView.addSubview(self.profileImageView)
        self.profileImageView.layer.cornerRadius = 35 / 2.0
        self.profileImageView.clipsToBounds = true
        self.profileImageView.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView).offset(20)
            make.centerY.equalTo(self.contentView)
            make.height.equalTo(35)
            make.width.equalTo(self.profileImageView.snp.height)
        }
        
        self.profileImageView.image = self.profileImage
        self.setMessageLabel()
    }
    
    func setMessageLabel () {
        self.messageLabel = UILabel(text: self.comment)
        self.messageLabel.numberOfLines = 0
        
        self.contentView.addSubview(self.messageLabel)
        self.messageLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.profileImageView.snp.right).offset(10)
            make.right.equalTo(self.contentView).offset(-20)
            make.top.equalTo(self.contentView).offset(10)
            make.bottom.equalTo(self.contentView).offset(-10)
        }
    }
    
}
