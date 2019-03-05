//
//  EmptyDataSet.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/3/4.
//  Copyright © 2019 Andylau. All rights reserved.
//

import Foundation
import EmptyDataSet_Swift

extension UIScrollView {
    
    private struct AssociatedKeys {
        static var uemptyKey: Void?
    }
    
    var uempty: UEmptyView? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.uemptyKey) as? UEmptyView
        }
        set {
            self.emptyDataSetDelegate = newValue
            self.emptyDataSetSource = newValue
            objc_setAssociatedObject(self, &AssociatedKeys.uemptyKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

class UEmptyView: EmptyDataSetSource, EmptyDataSetDelegate {
    
    var image: UIImage?
    
    var allowShow: Bool = false
    var verticalOffset: CGFloat = -kNavBarH
    
    private var tapClosure: (() -> Void)?
    
    //    func description(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
    //        let myAttribute = [NSAttributedString.Key.foregroundColor: UIColor.lightGray,
    //                           NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue,
    //                           NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13)] as [NSAttributedString.Key : Any]
    //        let attString = NSAttributedString(string: localized("什么也木有啊,哭晕在厕所"), attributes: myAttribute)
    //        return attString
    //    }
    
    init(image: UIImage? = UIImage(named: "login_nodata"), verticalOffset: CGFloat = 0, tapClosure: (() -> Void)?) {
        self.image = image
        self.verticalOffset = verticalOffset
        self.tapClosure = tapClosure
    }
    
    func verticalOffset(forEmptyDataSet scrollView: UIScrollView) -> CGFloat {
        return verticalOffset
    }
    
    internal func image(forEmptyDataSet scrollView: UIScrollView) -> UIImage? {
        return image
    }
    
    internal func emptyDataSetShouldDisplay(_ scrollView: UIScrollView) -> Bool {
        return allowShow
    }
    
    internal func emptyDataSet(_ scrollView: UIScrollView, didTapView view: UIView) {
        guard let tapClosure = tapClosure else { return }
        tapClosure()
    }
}
