//
//  SearchView.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/14.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class SearchView: View {
    
    var searchImg = UIImageView(image: UIImage(named: "search_icon"))
    var textField = UITextField().then { (tf) in
        tf.textColor = UIColor.black
        tf.backgroundColor = UIColor.hexColor(0xEFEFEF)
        tf.tintColor = UIColor(r: 12, g: 95, b: 254)
        tf.clearButtonMode = UITextField.ViewMode.whileEditing
        tf.returnKeyType = UIReturnKeyType.search
        tf.becomeFirstResponder()
        tf.font = UIFont.systemFont(ofSize: 15)
        tf.placeholder = "搜索食材"
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: kScreenW-120, height: 34)
    }
    
    override func makeUI() {
        super.makeUI()

        addSubview(searchImg)
        addSubview(textField)
        
        searchImg.snp.makeConstraints { (make) in
            make.left.equalTo(11)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(17)
        }
        
        textField.snp.makeConstraints { (make) in
            make.left.equalTo(searchImg.snp.right).offset(8)
            make.centerY.equalToSuperview()
            make.right.equalTo(self).offset(-8)
            make.height.equalToSuperview()
        }
    }
    
    class func loadView() -> SearchView {
        let view = SearchView(frame: CGRect(x: 0, y: 0, width: kScreenW - 120, height: 34))
        view.backgroundColor = UIColor.orange
        view.cuttingCorner(radius: 17)
        return view
    }
    
}
