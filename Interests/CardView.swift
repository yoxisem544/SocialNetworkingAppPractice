//
//  CardView.swift
//  Interests
//
//  Created by David on 2015/9/4.
//  Copyright © 2015年 David. All rights reserved.
//

import UIKit

class CardView: UIView {

    var cornerRadius: CGFloat = 3.0
    var shadowWidth: CGFloat = 0
    var shadowHeight: CGFloat = 1.0
    var shadowOpacity: Float = 0.2
    var shadowColor: UIColor = UIColor.blackColor()
    
    override func layoutSubviews() {
        layer.cornerRadius = cornerRadius
        clipsToBounds = false
        
        let shawdowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        layer.shadowColor = shadowColor.CGColor
        layer.shadowOffset = CGSize(width: shadowWidth, height: shadowHeight)
        layer.shadowOpacity = shadowOpacity
        layer.shadowPath = shawdowPath.CGPath
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
