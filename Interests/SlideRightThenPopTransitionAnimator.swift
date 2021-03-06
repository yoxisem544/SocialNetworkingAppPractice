//
//  SlideRightThenPopTransitionAnimator.swift
//  Interests
//
//  Created by David on 2015/9/3.
//  Copyright © 2015年 David. All rights reserved.
//

import UIKit

class SlideRightThenPopTransitionAnimator: NSObject {
    var duration = 0.6
    private var isPresenting = false
}

extension SlideRightThenPopTransitionAnimator : UIViewControllerTransitioningDelegate {
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresenting = true
        return self
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresenting = false
        return self
    }
}

extension SlideRightThenPopTransitionAnimator : UIViewControllerAnimatedTransitioning {
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return duration
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey)!
        let toView = transitionContext.viewForKey(UITransitionContextToViewKey)!
        let containerView = transitionContext.containerView()!
        
        // transitions
        let offScreenLeft = CGAffineTransformMakeTranslation(-containerView.frame.width, 0)
        let offScreenRight = CGAffineTransformMakeTranslation(containerView.frame.width, 0)
        let minimize = CGAffineTransformMakeScale(0.5, 0.5)
        let minimizeAndOffScreenLeft = CGAffineTransformConcat(minimize, offScreenLeft)
        
        if isPresenting {
            toView.transform = minimizeAndOffScreenLeft
        }
        
        if isPresenting {
            containerView.addSubview(fromView)
            containerView.addSubview(toView)
        } else {
            containerView.addSubview(toView)
            containerView.addSubview(fromView)
        }
        
        UIView.animateWithDuration(duration, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.4, options: [], animations: { () -> Void in
            let backToMainScreen = CGAffineTransformMakeTranslation(0, 0)
            if self.isPresenting {
                toView.transform = CGAffineTransformConcat(minimize, backToMainScreen)
                fromView.transform = offScreenRight
            } else {
                fromView.transform = CGAffineTransformConcat(minimize, offScreenRight)
            }
            }, completion: nil)
        
        UIView.animateWithDuration(duration / 2, delay: duration, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.4, options: [], animations: { () -> Void in
            if self.isPresenting {
                toView.transform = CGAffineTransformIdentity
            } else {
                fromView.transform = minimizeAndOffScreenLeft
                toView.transform = CGAffineTransformIdentity
            }
            }) { (finished) -> Void in
                if finished {
                    transitionContext.completeTransition(true)
                }
        }
    }
}