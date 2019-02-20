//
//  PasswordLoginView.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/18.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class PasswordLoginView: View {

    let backImg = ImageView().then { (img) in
        //img.image = UIImage(named: "wechaLogin_icon")
        img.contentMode = .scaleAspectFit
        img.backgroundColor = Color.backdropColor
    }
    
    let phoneView = View().then { (view) in
        view.backgroundColor = UIColor.hexColor(0xFFFFFF, alpha: 0.8)
        view.cuttingCorner(radius: 22)
    }
    
    let userImg = ImageView().then { (img) in
        img.image = UIImage(named: "login_user")
        img.contentMode = .scaleAspectFit
    }
    
    let codeBtn = Button(type: .custom).then { (btn) in
        btn.setTitle("获取验证码", for: .normal)
        btn.setTitleColor(UIColor.hexColor(0x95DBD5), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
    }
    
    let phoneTF = UITextField().then { (tf) in
        tf.placeholder = "请输入手机号"
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.keyboardType = .numberPad
    }
    
    let psdView = View().then { (view) in
        view.backgroundColor = UIColor.hexColor(0xFFFFFF, alpha: 0.8)
        view.cuttingCorner(radius: 22)
    }
    
    let psdImg = ImageView().then { (img) in
        img.image = UIImage(named: "login_user")
        img.contentMode = .scaleAspectFit
    }
    
    let psdTF = UITextField().then { (tf) in
        tf.placeholder = "请输入验证码"
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.keyboardType = .numberPad
    }

    let wechatBtn = Button(type: .custom).then { (btn) in
        btn.set(image: UIImage(named: "login_wechat"), title: "微信登录", titlePosition: .right, additionalSpacing: 10, state: .normal)
        btn.setTitleColor(UIColor.hexColor(0x15C5A2, alpha: 0.75), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        btn.adjustsImageWhenHighlighted = false
    }
    
    let psdBtn = Button(type: .custom).then { (btn) in
        btn.setImage(UIImage(named: "navigation_back_icon"), for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.adjustsImageWhenHighlighted = false
    }
    
    override func makeUI() {
        super.makeUI()
        addSubview(backImg)
        addSubview(phoneView)
        addSubview(psdView)
        
        phoneView.addSubview(userImg)
        phoneView.addSubview(phoneTF)
        phoneView.addSubview(codeBtn)
        
        psdView.addSubview(psdImg)
        psdView.addSubview(psdTF)
        
        addSubview(wechatBtn)
        addSubview(psdBtn)

        rxAction()
    }
    
    func rxAction() {
        
        // 监听手机号的输入只能输入11个
        phoneTF.rx.controlEvent(UIControl.Event.editingChanged).subscribe { [weak self] (_) in
            guard let weakSelf = self else { return }
            guard let text = weakSelf.phoneTF.text else { return }
            if text.count > 11 {
                weakSelf.phoneTF.text = String(text.prefix(11))
            }
            }.disposed(by: rx.disposeBag)
        
        psdTF.rx.controlEvent(UIControl.Event.editingChanged).subscribe { [weak self] (_) in
            guard let weakSelf = self else { return }
            guard let text = weakSelf.psdTF.text else { return }
            if text.count > 8 {
                weakSelf.psdTF.text = String(text.prefix(8))
            }
            }.disposed(by: rx.disposeBag)
        
        let tap = UITapGestureRecognizer()
        tap.rx.event.subscribe { [weak self] (_) in
            self?.endEditing(true)
            }.disposed(by: rx.disposeBag)
        addGestureRecognizer(tap)
    }
    
    override func updateUI() {
        super.updateUI()
        backImg.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        phoneView.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(280)
            make.centerX.equalTo(self)
            make.width.equalTo(kScreenW-36*2)
            make.height.equalTo(44)
        }
        
        psdView.snp.makeConstraints { (make) in
            make.top.equalTo(phoneView.snp.bottom).offset(20)
            make.centerX.equalTo(self)
            make.width.height.equalTo(phoneView)
        }
        
        userImg.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.centerY.equalToSuperview()
        }
        
        codeBtn.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-20)
            make.centerY.height.equalToSuperview()
            make.width.equalTo(70)
        }
        
        phoneTF.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(50)
            make.centerY.equalToSuperview()
            make.right.equalTo(codeBtn.snp.left).offset(-10)
        }
        
        psdImg.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.centerY.equalToSuperview()
        }
        
        psdTF.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(50)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-10)
        }
        
        wechatBtn.snp.makeConstraints { (make) in
            make.top.equalTo(psdTF.snp.bottom).offset(45)
            make.centerX.equalTo(self)
        }
        
        
        psdBtn.snp.makeConstraints { (make) in
            make.right.equalTo(self).offset(-36)
            make.centerY.equalTo(wechatBtn)
            make.width.height.equalTo(60)
        }
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // fillCode
        let bgLayer1 = CAGradientLayer()
        bgLayer1.colors = [UIColor(red: 0.16, green: 0.84, blue: 0.61, alpha: 1).cgColor, UIColor(red: 0.04, green: 0.77, blue: 0.71, alpha: 1).cgColor]
        bgLayer1.locations = [0, 1]
        bgLayer1.frame = psdBtn.bounds.insetBy(dx: 3, dy: 3)
        bgLayer1.startPoint = CGPoint(x: 0.01, y: 0.49)
        bgLayer1.endPoint = CGPoint(x: 0.49, y: 0.49)
        bgLayer1.cornerRadius = psdBtn.bounds.insetBy(dx: 3, dy: 3).height/2
        psdBtn.layer.insertSublayer(bgLayer1, at: 0)

        let bgLayer2 = CALayer()
        bgLayer2.frame = psdBtn.bounds
        bgLayer2.backgroundColor = UIColor.hexColor(0x1DD1A8, alpha: 0.2).cgColor
        bgLayer2.cornerRadius = psdBtn.bounds.height/2
        psdBtn.layer.insertSublayer(bgLayer2, at: 0)
    }
    
    /// - Publich Methods
    class func loadView() -> PasswordLoginView {
        let view = PasswordLoginView(frame: UIScreen.main.bounds)
        return view
    }

}
