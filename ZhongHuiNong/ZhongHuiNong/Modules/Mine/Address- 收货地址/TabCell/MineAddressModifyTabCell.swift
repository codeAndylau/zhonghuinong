//
//  MineAddressModifyTabCell.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/22.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class MineAddressModifyTabCell: TableViewCell, TabReuseIdentifier {

    let titleLab = Label().then { (lab) in
        lab.text = "联系人"
        lab.textColor = UIColor.hexColor(0x666666)
        lab.font = UIFont.systemFont(ofSize: 14)
        lab.numberOfLines = 0
    }
    
    let textField = UITextField().then { (tf) in
        tf.placeholder = "请填写内容"
        tf.textColor = UIColor.hexColor(0x333333)
        tf.font = UIFont.systemFont(ofSize: 14)
    }
    
    let lineView = View().then { (view) in
        view.backgroundColor = UIColor.hexColor(0xF5F5F5)
    }
    
    let arrowImg = ImageView().then { (img) in
        img.image = UIImage(named: "mine_arrow")
        img.isHidden = true
    }
    
    let sureBtn = Button().then { (btn) in
        btn.isHidden = true
    }
    
    var cell_IndexPath = IndexPath(row: 0, section: 0)
    
    override func makeUI() {
        super.makeUI()
        addSubview(titleLab)
        addSubview(textField)
        addSubview(lineView)
        addSubview(arrowImg)
        addSubview(sureBtn)
        
        textField.delegate = self
    }
    
    override func updateUI() {
        super.updateUI()
        
        titleLab.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(15)
            make.centerY.equalTo(self)
        }
        
        textField.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(95)
            make.centerY.equalTo(self)
            make.right.equalTo(self).offset(-50)
        }
        
        lineView.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(15)
            make.right.equalTo(self).offset(-15)
            make.bottom.equalTo(self)
            make.height.equalTo(1)
        }
        
        arrowImg.snp.makeConstraints { (make) in
            make.right.equalTo(self).offset(-15)
            make.centerY.equalTo(self)
        }
        
        sureBtn.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        
    }
    
    var cellTFClosure: ((_ text: String, _ index: Int)->Void)?

}

extension MineAddressModifyTabCell: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        debugPrints("输入编辑完成---\(textField.text!)")
        cellTFClosure?(textField.text!, cell_IndexPath.row)
    }
    
}
