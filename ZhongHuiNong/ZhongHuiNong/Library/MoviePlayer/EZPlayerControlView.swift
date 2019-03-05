//
//  EZPlayerControlView.swift
//  SmartVillage
//
//  Created by Andylau on 2018/11/27.
//  Copyright © 2018年 Andylau. All rights reserved.
//

import UIKit

/// 播放器控制面板
class EZPlayerControlView: UIView {
    
    var fullScreenButtonClickBlock: ((_ sender: UIButton) -> ())?
    var closeButtonClickBlock: ((_ sender: UIButton) -> ())?
    var playOrPauseButtonClickBlock: ((_ sender: UIButton) -> ())?
    
    var barIsHidden: Bool = false {
        didSet {
            if barIsHidden {
                hideTopBottomBar()
            } else {
                showTopBottomBar()
            }
            
            if let view = UIApplication.shared.value(forKey: "statusBar") as? UIView {  //根据 barIsHiden 改变状态栏的透明度
                if fullScreen {
                    view.alpha = barIsHidden ? 0 : 1.0
                }
            }
        }
    }
    
    ///  是否为全屏状态
    var fullScreen: Bool = false {
        didSet {
            updateTopBarWith(fullScreen: fullScreen)
        }
    }
    
    /// 关闭
    lazy var closeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: ""), for: .normal)
        button.setImage(UIImage(named: "player_back"), for: .selected)
        button.setImage(UIImage(named: "player_back_hight"), for: .highlighted)
        button.addTarget(self, action: #selector(closeButtonClick(_:)), for: .touchUpInside)
        return button
    }()
    
    /// 播放和暂停
    lazy var playOrPauseBtn: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "player_play"), for: .normal)    // player_pause
        button.setImage(UIImage(named: "player_pause"), for: .selected) //  player_play
        button.backgroundColor = UIColor(white: 0.0, alpha: 0.3)
        button.imageEdgeInsets.left = 2.5
        button.layer.cornerRadius = 27.5
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(playOrPauseBtnClick(_:)), for: .touchUpInside)
        return button
    }()
    
    /// 全屏
    lazy var fullScreenBtn: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "player_fullscreen"), for: .normal)
        button.setImage(UIImage(named: "player_shrinkScreen"), for: .selected)
        button.addTarget(self, action: #selector(fullScreenBtnClick(_:)), for: .touchUpInside)
        return button
    }()

    // MARK: - 手势
    lazy var singleTapGesture: UITapGestureRecognizer = {
        let gesture = UITapGestureRecognizer()
        gesture.delegate = self
        gesture.addTarget(self, action: #selector(singleTapGestureRecognizers(_:)))
        gesture.numberOfTapsRequired = 1
        gesture.numberOfTouchesRequired = 1
        return gesture
    }()
    
    init(frame: CGRect, fullScreen: Bool) {
        super.init(frame: frame)
        setupUI()
        addGesture()
    }
 
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: Action
    @objc func closeButtonClick(_ sender: UIButton) {
        if self.closeButtonClickBlock != nil {
            self.closeButtonClickBlock!(sender)
        }
    }
    
    @objc func playOrPauseBtnClick(_ sender: UIButton) {
        barIsHidden = !barIsHidden
        if self.playOrPauseButtonClickBlock != nil {
            self.playOrPauseButtonClickBlock!(sender)
        }
    }
    
    @objc func fullScreenBtnClick(_ sender: UIButton){
        if self.fullScreenButtonClickBlock != nil {
            self.fullScreenButtonClickBlock!(sender)
        }
    }
    
    // MARK: - GestureRecognizers - Action
    @objc func singleTapGestureRecognizers(_ sender: UITapGestureRecognizer) {
        // 1. 隐藏状态栏和暂停和播放
        barIsHidden = !barIsHidden // 单击改变操作栏的显示隐藏
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(autoHideTopBottomBar), object: nil)
        self.perform(#selector(autoHideTopBottomBar), with: nil, afterDelay: 3)
    }
    
    /// 自动隐藏操作栏
    @objc func autoHideTopBottomBar() {
        barIsHidden = true
    }

    /// MARK: - layoutSubviews
    override func layoutSubviews() {
        super.layoutSubviews()
    }

}

extension EZPlayerControlView {
 
    func setupUI() {
        
        addSubview(closeButton)
        addSubview(playOrPauseBtn)
        //addSubview(fullScreenBtn)
        
        closeButton.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.leading.equalToSuperview()
            make.width.equalTo(0)
        }
        
        playOrPauseBtn.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.equalTo(55)
            make.height.equalTo(55)
        }
        
        //        fullScreenBtn.snp.makeConstraints { (make) in
        //            make.bottom.equalToSuperview()
        //            make.trailing.equalTo(-5)
        //            make.width.height.equalTo(40)
        //        }
        
        /// 刷新布局
        self.layoutIfNeeded()
    }
    
    func addGesture() {
        addGestureRecognizer(singleTapGesture)
        singleTapGesture.isEnabled = true
        singleTapGesture.delaysTouchesBegan = true
    }
 
    /// 隐藏操作栏，带动画
    func hideTopBottomBar() {
        UIView.animate(withDuration: 0.2) {
            self.closeButton.isHidden = true
            self.playOrPauseBtn.isHidden = true
            self.fullScreenBtn.isHidden = true
        }
    }
    
    ///显示操作栏，带动画
    func showTopBottomBar() {
        UIView.animate(withDuration: 0.2) {
            self.closeButton.isHidden = false
            self.playOrPauseBtn.isHidden = false
            self.fullScreenBtn.isHidden = false
        }
    }
    
    func updateTopBarWith(fullScreen: Bool) {
        closeButton.snp.updateConstraints { (make) in
            make.top.equalTo(fullScreen ? 20 : 0)
        }
    }
}

// MARK: - UIGestureRecognizerDelegate
extension EZPlayerControlView: UIGestureRecognizerDelegate {
 
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return true
    }
}
