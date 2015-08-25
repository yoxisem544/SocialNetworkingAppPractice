//
//  PostTableViewCell.swift
//  Interests
//
//  Created by David on 2015/8/25.
//  Copyright © 2015年 David. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    // MARK: - public api
    var post: Post! {
        didSet {
            updateUI()
        }
    }
    
    // MARK: - private
    private var currentUserDidLike: Bool = false
    
    private func updateUI() {
        userProfileImageView?.image = post.user.profileImage
        userNameLabel?.text = post.user.fullName
        createAtLabel?.text = post.createdAt
        postImageView?.image = post.postImage
        postTextLabel?.text = post.postText
        
        // rounded post image view, user profile image
        userProfileImageView?.layer.cornerRadius = userProfileImageView.bounds.width / 2
        userProfileImageView?.clipsToBounds = true
        postImageView?.layer.cornerRadius = 5.0
        postImageView?.clipsToBounds = true
        
        likeButton.setTitle("👻 \(post.numberOfLikes) Likes", forState: UIControlState.Normal)
        configureButtonAppearance()
    }
    
    private func configureButtonAppearance() {
        likeButton.cornerRadius = 3.0
        likeButton.borderColor = UIColor.lightGrayColor()
        likeButton.borderWidth = 2.0
        
        commentButton.cornerRadius = 3.0
        commentButton.borderColor = UIColor.lightGrayColor()
        commentButton.borderWidth = 2.0
    }
    
    @IBAction func likeButtonClicked(sender: DesignableButton) {
        post.userDidLike = !post.userDidLike
        if post.userDidLike {
            post.numberOfLikes++
        } else {
            post.numberOfLikes--
        }
        likeButton.setTitle("👻 \(post.numberOfLikes) Likes", forState: UIControlState.Normal)
        
        currentUserDidLike = post.userDidLike
        
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
    
    @IBAction func commentButtonClicked(sender: DesignableButton) {
        
        // animation
        sender.animation = "pop"
        sender.curve = "spring"
        sender.duration = 1.5
        sender.damping = 0.1
        sender.velocity = 0.2
        sender.animate()
    }
    
    @IBOutlet weak var userProfileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var createAtLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var postTextLabel: UILabel!
    @IBOutlet weak var likeButton: DesignableButton!
    @IBOutlet weak var commentButton: DesignableButton!
    
    
}
