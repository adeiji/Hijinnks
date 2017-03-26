//
//  CommentViewController.swift
//  Hijinnks
//
//  Created by adeiji on 3/26/17.
//  Copyright © 2017 adeiji. All rights reserved.
//

import Foundation
import UIKit
import Parse

class CommentViewController : UIViewController, UITableViewDataSource {
    
    var commentView:CommentView!
    var invitation:Invitation!
    var comments:Array<CommentParseObject>!
    
    override func viewDidLoad() {
        
        self.commentView = CommentView()
        self.commentView.setupUI()
        self.commentView.commentsTableView.dataSource = self
        self.commentView.sendButton.addTarget(self, action: #selector(sendButtonPressed), for: .touchUpInside)
        self.view.addSubview(self.commentView)
        self.commentView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(invitation: Invitation) {
        self.invitation = invitation
        if self.invitation.comments != nil {
            self.comments = self.invitation.comments
        } else {
            self.comments = Array<CommentParseObject>()
        }
        super.init(nibName: nil, bundle: nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let comment = self.comments[indexPath.row]
        let commentViewCell = CommentViewCell(comment: comment)
        commentViewCell.setupUI()
        return commentViewCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.comments != nil {
            return self.comments.count
        }
        
        return 0
    }

    /**
     * - Description User presses the send button on the view add the comment to the comment count
     */
    func sendButtonPressed () {
        if self.commentView.commentTextField.text?.replacingOccurrences(of: " ", with: "") != "" {
            let commentParseObject = CommentParseObject()
            commentParseObject.comment = self.commentView.commentTextField.text!
            commentParseObject.user = PFUser.current()
            self.comments.append(commentParseObject)
        }
        
        self.invitation.setComments(comments: self.comments)
        self.invitation.getParseObject().saveInBackground()
        _ = self.navigationController?.popViewController(animated: true)
    }
}
