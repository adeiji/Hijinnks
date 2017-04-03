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

class CommentViewController : UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var commentView:CommentView!
    var invitation:InvitationParseObject!
    var comments:Array<CommentObject>! = Array<CommentObject>()
    var commentParseObjects:Array<CommentParseObject>
    
    struct CommentObject {
        var comment:String
        var profileImage:UIImage!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        let commentsQueue = DispatchQueue(label: "com.parse.comments")
        commentsQueue.async {
            self.getComments()
            DispatchQueue.main.async(execute: { 
                self.commentView = CommentView()
                self.commentView.setupUI()
                self.commentView.commentsTableView.dataSource = self
                self.commentView.commentsTableView.delegate = self
                self.commentView.sendButton.addTarget(self, action: #selector(self.sendButtonPressed), for: .touchUpInside)
                self.view.addSubview(self.commentView)
                self.commentView.snp.makeConstraints { (make) in
                    make.edges.equalTo(self.view)
                }
            })
        }
    }
    
    func getComments () {
        for comment in self.commentParseObjects {
            do {
                try comment.fetchIfNeeded()
                try comment.user.fetchIfNeeded()
                var commentObject = CommentObject(comment: comment.comment, profileImage: nil)
                if comment.user.value(forKey: ParseObjectColumns.Profile_Picture.rawValue) != nil {
                    let profilePicture = comment.user.value(forKey: ParseObjectColumns.Profile_Picture.rawValue) as! PFFile
                    let imageData = try profilePicture.getData()
                    commentObject.profileImage = UIImage(data: imageData)
                }
                self.comments.append(commentObject)
            }
            catch {
                print(error.localizedDescription)
            }
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(invitation: InvitationParseObject) {
        self.invitation = invitation
        if self.invitation.comments != nil {
            self.commentParseObjects = self.invitation.comments
            
        } else {
            self.commentParseObjects = Array<CommentParseObject>()
        }
        super.init(nibName: nil, bundle: nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let comment = self.comments[indexPath.row]
        let commentViewCell = CommentViewCell(comment: comment.comment, profileImage: comment.profileImage)
        commentViewCell.setupUI()
        return commentViewCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.comments != nil {
            return self.comments.count
        }
        
        return 0
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return calculateHeightForCell(comment: self.comments[indexPath.row])
    }
    
    func calculateHeightForCell (comment: CommentObject) -> CGFloat {
        let commentCell = CommentViewCell(comment: comment.comment, profileImage: comment.profileImage)
        commentCell.contentView.layoutIfNeeded()
        let size = commentCell.contentView.systemLayoutSizeFitting(UILayoutFittingCompressedSize)
        return size.height
    }
    
    /**
     * - Description User presses the send button on the view add the comment to the comment count
     */
    func sendButtonPressed () {
        if self.commentView.commentTextField.text?.replacingOccurrences(of: " ", with: "") != "" {
            let commentParseObject = CommentParseObject()
            commentParseObject.comment = self.commentView.commentTextField.text!
            commentParseObject.user = PFUser.current()
            
            self.commentParseObjects.append(commentParseObject)
        }
        self.invitation.comments = self.commentParseObjects
        self.invitation.saveInBackground()
        _ = self.navigationController?.popViewController(animated: true)
    }
}
