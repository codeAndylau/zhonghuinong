//
//  SwiftPopupPresentationController.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/12.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class SwiftPopupPresentationController: UIPresentationController {
    
    public var backViewColor = UIColor(white: 0.1, alpha: 0.5) {
        didSet {
            backgroundView.backgroundColor = backViewColor
        }
    }
    
    private lazy var backgroundView = UIView(frame: CGRect.zero)
    
    // MARK: Override Methods
    
    override open func presentationTransitionWillBegin() {
        if let containerView = containerView {
            containerView.insertSubview(backgroundView, at: 0)
            backgroundView.snp.makeConstraints { (make) in
                make.edges.equalTo(containerView).inset(UIEdgeInsets.zero)
            }
            excuteBackgroundAnimation()
        }
    }
    
    override open func dismissalTransitionWillBegin() {
        excuteBackgroundDismissAnimation()
    }
    
    override open var shouldRemovePresentersView: Bool {
        return false
    }
    
    // MARK: Private Methods
    
    fileprivate func excuteBackgroundAnimation() {
        backgroundView.alpha = 0
        if let coordinator = presentedViewController.transitionCoordinator {
            coordinator.animate(alongsideTransition: { (_) in
                self.backgroundView.alpha = 1
            }, completion: nil)
        }
    }
    
    fileprivate func excuteBackgroundDismissAnimation() {
        if let coordinator = presentedViewController.transitionCoordinator {
            coordinator.animate(alongsideTransition: { _ in
                self.backgroundView.alpha = 0
            }, completion: nil)
        }
    }
}
