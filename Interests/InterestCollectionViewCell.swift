//
//  InterestCollectionViewCell.swift
//  Interests
//
//  Created by David on 2015/8/24.
//  Copyright © 2015年 David. All rights reserved.
//

import UIKit

class InterestCollectionViewCell: UICollectionViewCell {
    
    
    // MARK: Public API
    var interest: Interest! {
        didSet {
            updateUI()
        }
    }
    // MARK: - private
    @IBOutlet weak var featuredImageView: UIImageView!
    @IBOutlet weak var interestTitleLabel: UILabel!
    
    private func updateUI() {
        interestTitleLabel?.text! = interest.title
        featuredImageView?.image! = interest.featuredImage
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = 10.0
        self.clipsToBounds = true
    }
}
