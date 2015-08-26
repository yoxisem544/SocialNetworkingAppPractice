//
//  InterestHeaderView.swift
//  Interests
//
//  Created by David on 2015/8/25.
//  Copyright © 2015年 David. All rights reserved.
//

import UIKit

protocol InterestHeaderViewDelegate {
    func closeButtonTapped()
}

class InterestHeaderView: UIView {
    
    // MARK: - public api
    var interest: Interest! {
        didSet {
            updateUI()
        }
    }
    
    var delegate: InterestHeaderViewDelegate!
    
    @IBAction func closeButtonTapped(sender: UIButton) {
        delegate.closeButtonTapped()
    }
    
    private func updateUI() {
        backgroundImageView?.image! = interest.featuredImage
        interestTitleLabel?.text! = interest.title
        numberOfMembersLabel?.text! = "\(interest.numberOfMembers)"
        numberOfPostsLabel?.text! = "\(interest.numberOfPosts)"
        pullDownToCloseLabel?.text! = "Pull down to close"
        pullDownToCloseLabel?.hidden = true
    }

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var interestTitleLabel: UILabel!
    @IBOutlet weak var numberOfMembersLabel: UILabel!
    @IBOutlet weak var numberOfPostsLabel: UILabel!
    @IBOutlet weak var pullDownToCloseLabel: UILabel!
    @IBOutlet weak var closeButtonBackgroundView: UIView!
    
    override func layoutSubviews() {
        super.layoutSubviews()

        closeButtonBackgroundView.layer.cornerRadius = closeButtonBackgroundView.bounds.width / 2
        closeButtonBackgroundView.clipsToBounds = true
    }

}
