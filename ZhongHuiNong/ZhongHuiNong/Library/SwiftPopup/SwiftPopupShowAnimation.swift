//
//  SwiftPopupShowAnimation.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/12.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class SwiftPopupShowAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    
    public var duration: TimeInterval = 0.8
    public var delay: TimeInterval = 0.0
    public var springWithDamping: CGFloat = 0.9
    public var springVelocity: CGFloat = 2.0
    
    open func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    open func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toViewController = transitionContext.viewController( forKey: UITransitionContextViewControllerKey.to),
            let toView = transitionContext.view( forKey: UITransitionContextViewKey.to) else { return }
        
        let containerView = transitionContext.containerView
        toView.frame = transitionContext.finalFrame(for: toViewController)
        containerView.addSubview(toView)
        
        toView.transform = CGAffineTransform(translationX: 0, y: UIScreen.main.bounds.height)
        UIView.animate(withDuration: duration,
                       delay: delay,
                       usingSpringWithDamping: springWithDamping,
                       initialSpringVelocity: springVelocity,
                       options: .curveEaseInOut, animations: {
                        toView.transform = CGAffineTransform(translationX: 0, y: 0)
        }) { (finished) in
            transitionContext.completeTransition(finished)
        }
    }
}

class SwiftPopupDismissAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    
    public var duration: TimeInterval = 0.5
    public var delay: TimeInterval = 0.0
    
    open func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    open func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromView = transitionContext.view( forKey: UITransitionContextViewKey.from) else { return }
        
        UIView.animate(withDuration: duration,
                       delay: delay,
                       options: .curveEaseInOut,
                       animations: {
                        fromView.transform = CGAffineTransform(translationX: 0, y: UIScreen.main.bounds.height)
                        fromView.alpha = 0.0
        }) { (finished) in
            fromView.transform = CGAffineTransform(translationX: 0, y: 0)
            fromView.alpha = 1.0
            transitionContext.completeTransition(finished)
        }
    }
}
