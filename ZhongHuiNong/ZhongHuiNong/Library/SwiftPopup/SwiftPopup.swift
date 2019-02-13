//
//  SwiftPopup.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/12.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class SwiftPopup: UIViewController {
    
    var backViewColor: UIColor = UIColor(white: 0.1, alpha: 0.5)
    
    // Custom animatedTransitioning
    var showAnimation: UIViewControllerAnimatedTransitioning? = SwiftPopupShowAnimation()
    var dismissAnimation: UIViewControllerAnimatedTransitioning? = SwiftPopupDismissAnimation()
    
    var isShowing: Bool { return mIsShowing }
    
    private var mIsShowing: Bool = false
    
    // MARK: Life Cycle
    
    init() {
        super.init(nibName: nil, bundle: nil)
        commonInit()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.clear
    }
    
    // MARK: Public Methods
    
    func show(above viewController: UIViewController? = UIApplication.shared.keyWindow?.rootViewController,
              completion: (()-> Void)? = nil) {
        mIsShowing = true
        viewController?.present(self, animated: true, completion: completion)
    }
    
    func dismiss(completion: (()-> Void)? = nil) {
        dismiss(animated: true) {
            self.mIsShowing = false
            completion?()
        }
    }
    
    // MARK: Private Methods
    
    fileprivate func commonInit() {
        modalPresentationStyle = .custom
        transitioningDelegate = self
    }
}

extension SwiftPopup: UIViewControllerTransitioningDelegate {
    
    func presentationController(forPresented presented: UIViewController,
                                presenting: UIViewController?,
                                source: UIViewController) -> UIPresentationController? {
        let controller = SwiftPopupPresentationController(presentedViewController: presented, presenting: presenting)
        controller.backViewColor = backViewColor
        return controller
    }
    
    func animationController(forPresented presented: UIViewController,
                             presenting: UIViewController,
                             source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return showAnimation
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return dismissAnimation
    }
}
