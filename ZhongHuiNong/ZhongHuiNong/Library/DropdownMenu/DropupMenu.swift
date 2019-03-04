//
//  DropupMenu.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/15.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class DropupMenu: UIView {

    open var isShown: Bool = false
    
    private var contentView: UIView!
    private var backgroundView: UIView!
    private var menuWrapper: UIView!
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(containerView: UIView = UIApplication.shared.keyWindow!, contentView: UIView) {
        
        guard let window = UIApplication.shared.keyWindow else {
            super.init(frame: CGRect.zero)
            return
        }
        
        self.contentView = contentView
        
        super.init(frame: .zero)
        
        let menuWrapperBounds = window.bounds
        
        self.menuWrapper = UIView(frame: CGRect(x: menuWrapperBounds.origin.x, y: 0, width: menuWrapperBounds.width, height: menuWrapperBounds.height))
        self.menuWrapper.viewIdentifier = "DropDownMenu-MenuWrapper"
        self.menuWrapper.clipsToBounds = true
        self.menuWrapper.autoresizingMask = [ .flexibleWidth, .flexibleHeight ]
        
        self.backgroundView = UIView(frame: menuWrapperBounds)
        self.backgroundView.backgroundColor = UIColor.black
        self.backgroundView.autoresizingMask = [ .flexibleWidth, .flexibleHeight ]
        
        self.menuWrapper.addSubview(self.backgroundView)
        self.menuWrapper.addSubview(contentView)
        
        let backgroundTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(DropdownMenu.hideMenu))
        self.backgroundView.isUserInteractionEnabled = true
        self.backgroundView.addGestureRecognizer(backgroundTapRecognizer)
        
        containerView.subviews
            .filter({$0.viewIdentifier == "DropDownMenu-MenuWrapper"})
            .forEach({$0.removeFromSuperview()})
        
        containerView.addSubview(self.menuWrapper)
        
        self.menuWrapper.isHidden = true
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.menuWrapper.frame = CGRect(x: 0, y: 0, width: kScreenW, height: kScreenH-kTabBarH)
        contentView.frame.origin.y = kScreenH - contentView.height
    }
    
    
    // MARK: - Action
    @objc func showMenu() {
        self.menuWrapper.frame = CGRect(x: 0, y: 0, width: kScreenW, height: kScreenH-kTabBarH)
        contentView.frame.origin.y = kScreenH - contentView.height
        self.isShown = true
        
        self.menuWrapper.isHidden = false
        
        self.backgroundView.alpha = 0
        
        self.contentView.frame.origin.y = kScreenH + contentView.frame.height
        
        self.menuWrapper.superview?.bringSubviewToFront(self.menuWrapper)
        
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            options: UIView.AnimationOptions(),
            animations: {
                self.contentView.frame.origin.y = kScreenH - self.contentView.height
                self.backgroundView.alpha = 0.3
        },completion: nil)
    }
    
    @objc func hideMenu() {
        self.isShown = false
        self.backgroundView.alpha = 0.3
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            options: UIView.AnimationOptions(),
            animations: {
                self.contentView.frame.origin.y = kScreenH
                self.backgroundView.alpha = 0 },
            completion: { _ in
                if self.isShown == false  {
                    self.menuWrapper.isHidden = true
                }
        })
    }
   
}
