//
//  PayBoxView.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/3/1.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

let w: CGFloat = 52

class PayBoxView: View, UITextFieldDelegate {

    typealias EntryCompleteBlock = (String)->Void
    var entryCompleteBlock: EntryCompleteBlock?

    var roundLayerArray = [CALayer]()
    
    let tf: CustomTextField = {
        let tf = CustomTextField(frame: CGRect(x: 0, y: 0, width: w*6, height: w))
        tf.textColor = .clear
        tf.tintColor = .clear
        tf.layer.borderWidth = 1
        tf.layer.borderColor = UIColor.hexColor(0xD3D3D3).cgColor
        tf.layer.masksToBounds = true
        tf.backgroundColor = UIColor.white
        tf.keyboardType = .numberPad
        tf.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        return tf
    }()
    
    override func makeUI() {
        super.makeUI()
        createTF()
        tf.becomeFirstResponder()
    }
    
    override func updateUI() {
        super.updateUI()
    }

    func createTF() {
        
        tf.delegate = self
        addSubview(tf)

        for  i  in 0...5 {
            
            let lineLayer = CALayer()
            lineLayer.frame = CGRect(x: CGFloat(i)*w, y: 0, width: 1, height: w)
            lineLayer.backgroundColor = UIColor.hexColor(0xEDEDED).cgColor
            tf.layer.addSublayer(lineLayer)
            
            let roundLayer = CALayer()
            let roundLayerW = w*0.25
            roundLayer.frame = CGRect(x: CGFloat(i)*w + w*3/8 , y: w*3/8, width: roundLayerW, height: roundLayerW)
            roundLayer.cornerRadius = roundLayerW/2
            roundLayer.isHidden = true
            roundLayer.backgroundColor = UIColor.black.cgColor
            tf.layer.addSublayer(roundLayer)
            roundLayerArray.append(roundLayer)
        }
        
    }
    
    @objc func textFieldDidChange(_ textField:UITextField) {
        
        for layer in roundLayerArray {
            layer.isHidden = true
        }
        
        for i in 0..<textField.text!.count{
            let layer = roundLayerArray[i]
            layer.isHidden = false
        }
        
        if textField.text!.count == 6 { //输入完毕，可以进行相关的操作
            self.entryCompleteBlock?(textField.text!)
            self.tf.text = ""
        }
    }
    
    func clearLayer() {
        roundLayerArray.forEach { (layer) in
            layer.isHidden = true
        }
    }
    
    //MARK:UITextFieldDelegate
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let proposeLength = (textField.text?.lengthOfBytes(using: String.Encoding.utf8))! - range.length + string.lengthOfBytes(using: String.Encoding.utf8)
        if proposeLength > 6{ //输入的字符个数大于6，忽略输入，可以进行相关的操作
            return false
        }else{
            return true
        }
    }
}

class CustomTextField: UITextField {
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return false //重写canPerformAction 禁止复制粘贴弹框
    }
}
