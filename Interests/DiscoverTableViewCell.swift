//
//  DiscoverTableViewCell.swift
//  Interests
//
//  Created by David on 2015/9/4.
//  Copyright © 2015年 David. All rights reserved.
//

import UIKit

class DiscoverTableViewCell: UITableViewCell {

    @IBOutlet weak var backgroundViewWithShadow: CardView!
    @IBOutlet weak var interestTitleLabel: UILabel!
    @IBOutlet weak var joinButton: InterestButton!
    @IBOutlet weak var interestFeaturedImage: UIImageView!
    @IBOutlet weak var interestDescriptionLabel: UILabel!
    
    var interest: Interest! {
        didSet {
            updateUI()
        }
    }
    
    func updateUI() {
        interestTitleLabel.text! = interest.title
        interestFeaturedImage.image! = interest.featuredImage
        interestDescriptionLabel.text! = interest.description
        
        joinButton.setTitle("→", forState: UIControlState.Normal)
    }

    @IBAction func jsonButtonClicked(sender: InterestButton) {
        
    }
    
    override func layoutSubviews() {
        interestFeaturedImage.clipsToBounds = true
        interestFeaturedImage.layer.cornerRadius = 5.0
    }
}
