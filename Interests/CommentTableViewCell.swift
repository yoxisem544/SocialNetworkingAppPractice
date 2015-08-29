//
//  CommentTableViewCell.swift
//  Interests
//
//  Created by David on 2015/8/28.
//  Copyright © 2015年 David. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell {

    // MARK: - public api
    var comment: Comment! {
        didSet {
            updateUI()
        }
    }
    
    // MARK: - private
    private var currentUserDidLike: Bool = false
    
    private func updateUI() {

        userNameLabel?.text = comment.user.fullName
        commentTextLabel?.text = comment.commentText
        
        likeButton.setTitle("👻 \(comment.numberOfLikes) Likes", forState: UIControlState.Normal)
//        configureButtonAppearance()
    }
    
    private func configureButtonAppearance() {
        likeButton.cornerRadius = 3.0
        likeButton.borderColor = UIColor.lightGrayColor()
        likeButton.borderWidth = 2.0
    }
    
    @IBAction func likeButtonClicked(sender: DesignableButton) {
        comment.userDidLike = !comment.userDidLike
        if comment.userDidLike {
            comment.numberOfLikes++
        } else {
            comment.numberOfLikes--
        }
        likeButton.setTitle("👻 \(comment.numberOfLikes) Likes", forState: UIControlState.Normal)
        
        currentUserDidLike = comment.userDidLike
        
        changeLikeButtonColor()
        
        // animation
        sender.animation = "pop"
        sender.curve = "spring"
        sender.duration = 1.5
        sender.damping = 0.1
        sender.velocity = 0.2
        sender.animate()
    }
    
    private func changeLikeButtonColor() {
        if currentUserDidLike {
            likeButton.borderColor = UIColor.redColor()
            likeButton.tintColor = UIColor.redColor()
        } else {
            likeButton.borderColor = UIColor.lightGrayColor()
            likeButton.tintColor = UIColor.lightGrayColor()
        }
    }
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var commentTextLabel: UILabel!
    @IBOutlet weak var likeButton: DesignableButton!

}
