//
//  EmptyPageForOrder.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/3/22.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit
import EmptyPage

enum EmptyPageForOrderConfig {
    case img
    case title
    case btn
}

class EmptyPageForOrder: UIView, EmptyPageContentViewProtocol {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLab: UILabel!
    @IBOutlet weak var sureBtn: UIButton!
    
    var block: BtnAction?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.white
        sureBtn.backgroundColor = Color.theme1DD1A8
        sureBtn.cuttingCorner(radius: 22)
    }
    
    @IBAction func btnTapEvent(_ sender: UIButton) {
        block?()
    }
    
    class var initFromNib: EmptyPageForOrder {
        return Bundle.main.loadNibNamed(String(describing: self), owner: nil, options: nil)?.first! as! EmptyPageForOrder
    }
    
    func config(empty complete: (_: EmptyPageForOrder) -> ()) -> Self {
        complete(self)
        return self
    }
    
}
