//
//  SlideRightTransitionAnimator.swift
//  Interests
//
//  Created by David on 2015/9/3.
//  Copyright © 2015年 David. All rights reserved.
//

import UIKit

class SlideRightTransitionAnimator: NSObject {
    var duration = 1.0
    private var isPresenting = false
}


extension SlideRightTransitionAnimator : UIViewControllerTransitioningDelegate {
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresenting = true
        return self
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresenting = false
        return self
    }
}

extension SlideRightTransitionAnimator : UIViewControllerAnimatedTransitioning {
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return duration
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey)!
        let toView = transitionContext.viewForKey(UITransitionContextToViewKey)!
        let containView = transitionContext.containerView()!
        
        let offScreenLeft = CGAffineTransformMakeTranslation(-containView.frame.width, 0)
        let minimize = CGAffineTransformMakeScale(0, 0)
        let shiftDown = CGAffineTransformMakeTranslation(0, 15)
        let scaleDown = CGAffineTransformScale(shiftDown, 0.8, 0.8)
        
        if isPresenting {
            let minimaizeAndOffScreenLeft = CGAffineTransformConcat(minimize, offScreenLeft)
            toView.transform = minimaizeAndOffScreenLeft
        }
        
        if isPresenting {
            containView.addSubview(fromView)
            containView.addSubview(toView)
        } else {
            containView.addSubview(toView)
            containView.addSubview(fromView)
        }
        
        // animate
        UIView.animateWithDuration(duration, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.4, options: [], animations: { () -> Void in
            if self.isPresenting {
                fromView.transform = scaleDown
                fromView.alpha = 0.5
                toView.transform = CGAffineTransformIdentity
            } else {
                // dismissing
                fromView.transform = offScreenLeft
                toView.alpha = 1.0
                toView.transform = CGAffineTransformIdentity
            }
            }) { (finished) -> Void in
                if finished {
                    transitionContext.completeTransition(true)
                }
        }
    }
}















