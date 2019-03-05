//
//  EZPlayerView.swift
//  SmartVillage
//
//  Created by Andylau on 2018/11/27.
//  Copyright © 2018年 Andylau. All rights reserved.
//

import UIKit

enum EZPlayerStatus {
    case Playing      // 播放中
    case Pause        // 暂停
    case ReadyToPlay  // 准备播放
    case Buffering    // 缓冲中
    case Unknown      // 未知
    case Failed       // 播放失败
}

/// 播放器试图
class EZPlayerView: UIView {

    /// 监控视频播放器
    var player: EZUIPlayer!

    var playerStatus: EZPlayerStatus = .Unknown {
        didSet {
            if playerStatus == .Playing {
                playControlView.playOrPauseBtn.isSelected = true
                player.startPlay()
            }else if playerStatus == .Pause {
                player.stopPlay()
                playControlView.playOrPauseBtn.isSelected = true
            }
        }
    }
    
    /// 判断视频链接是否更改，更改了就重置播放器
    var playUrl: String? {
        didSet {
            if let videoUrl = playUrl {
                /// 重制播放资源
                resetPlayerResource(url: videoUrl)
            }
        }
    }
    
    /// 内容试图
    var fatherView: UIView? {
        
        willSet {
            if newValue != nil {
                for view in newValue!.subviews {
                    if view.tag != 0 {
                        view.isHidden = true // 这里用于cell播放时，隐藏播放按钮
                    }
                }
            }
        }
        
        didSet {
            if oldValue != nil && oldValue != fatherView {
                for view in oldValue!.subviews {     // 当前播放器的tag为0
                    if view.tag != 0 {
                        view.isHidden = false           // 显示cell上的播放按钮
                    }
                }
            }
            
            if fatherView != nil && !fatherView!.subviews.contains(self) {
                fatherView!.addSubview(self)
            }
        }
    }
    
    /// 是否是全屏
    var isFullScreen: Bool = false {
        didSet {
            
            playControlView.closeButton.isSelected = isFullScreen
            playControlView.fullScreenBtn.isSelected = isFullScreen
            playControlView.fullScreen = isFullScreen
            
            // 状态栏变化
            if let view = UIApplication.shared.value(forKey: "statusBar") as? UIView {
                if !isFullScreen {
                    view.alpha = 1.0
                } else {  // 全频
                    if playControlView.barIsHidden { // 状态栏
                        view.alpha = 0
                    } else {
                        view.alpha = 1.0
                    }
                }
            }
            
            if !isFullScreen {
                /// 非全屏状态下，移除自定义视图
                playControlView.closeButton.isEnabled = false
                playControlView.closeButton.snp.updateConstraints { (make) in
                    make.width.equalTo(5)
                }
                
            }else {
                playControlView.closeButton.isEnabled = true
                playControlView.closeButton.snp.updateConstraints { (make) in
                    make.width.equalTo(40)
                }
            }
        }
    }
    
    lazy var playControlView: EZPlayerControlView = {
        let v = EZPlayerControlView(frame: self.bounds, fullScreen: false)
        return v
    }()

}

// MARK: 播放方法
extension EZPlayerView {
    
    func playVideoWith(_ url: String?, containView: UIView?) {
        
        self.playUrl = url
        
        if !isFullScreen {
            fatherView = containView // 更换父视图时
        }
        
        layouSubviews()
        addNotificationAndObserver()
        addUserActionBlock()
    }
    
    func layouSubviews() {
        
        self.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        playControlView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        player.previewView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    func addUserActionBlock() {
        
        playControlView.closeButtonClickBlock = { [weak self] sender in
            guard let strongSelf = self else {return}
            if strongSelf.isFullScreen {
                strongSelf.interfaceOrientation(UIInterfaceOrientation.portrait)
            }else {                                                    // 非全屏状态，停止播放，移除播放视图
                print("非全屏状态，停止播放，移除播放视图")
            }
        }
        
        // 全屏
        playControlView.fullScreenButtonClickBlock = { [weak self] (sender) in
            guard let strongSelf = self else { return }
            if strongSelf.isFullScreen {
                strongSelf.interfaceOrientation(UIInterfaceOrientation.portrait)
            }else{
                strongSelf.interfaceOrientation(UIInterfaceOrientation.landscapeRight)
            }
        }
        
        // 播放暂停
        playControlView.playOrPauseButtonClickBlock = { [weak self] (sender) in
            guard let strongSelf = self else { return }
            
            sender.isSelected = !sender.isSelected
            
            if sender.isSelected {
                debugPrints("停止")
                strongSelf.player.stopPlay()
            }else {
                debugPrints("开始")
                strongSelf.player.startPlay()
            }
            
            //            if strongSelf.playerStatus == .Playing {
            //                strongSelf.playerStatus = .Pause
            //            }else if strongSelf.playerStatus == .Pause {
            //                strongSelf.playerStatus = .Playing
            //            }
        }
    }
    
    /// 强制横屏 通过KVC直接设置屏幕旋转方向
    func interfaceOrientation(_ orientation: UIInterfaceOrientation) {
        if orientation == UIInterfaceOrientation.landscapeRight || orientation == UIInterfaceOrientation.landscapeLeft {
            UIDevice.current.setValue(NSNumber(integerLiteral: UIInterfaceOrientation.landscapeRight.rawValue), forKey: "orientation")
        }else if orientation == UIInterfaceOrientation.portrait {
            UIDevice.current.setValue(NSNumber(integerLiteral: UIInterfaceOrientation.portrait.rawValue), forKey: "orientation")
        }
    }
    
    /// 移除当前播放器屏幕方向监听
    func disableDeviceOrientationChange() {
        NotificationCenter.default.removeObserver(self, name: UIDevice.orientationDidChangeNotification, object: UIDevice.current)
    }
    
    /// 注册屏幕旋转监听通知
    func enableDeviceOrientationChange() {
        NotificationCenter.default.addObserver(self, selector: #selector(orientChange(_:)), name: UIDevice.orientationDidChangeNotification, object: UIDevice.current)
    }
    
}

// MARK: 私有方法
extension EZPlayerView {
    
    func resetPlayerResource(url: String) {
        releasePlayer()
        setupPlayerResource(url: url)
    }
    
    func releasePlayer() {
        if self.player != nil {
            self.player.previewView.removeFromSuperview()
            self.player.release()
            self.player = nil
            debugPrints("视频已经释放掉了")
        }
    }
    
    func setupPlayerResource(url: String) {

        /// 1. 添加播放器
        let triangleView = IndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        player = EZUIPlayer.createPlayer(withUrl: url)
        
        debugPrints("视频播放的链接---\(url)")
        
        player.customIndicatorView = triangleView
        player.mDelegate = self
        player.previewView.frame = bounds
        player.previewView.contentMode = .scaleAspectFill
        addSubview(player.previewView)
        
        /// 2. 添加控制播放的试图
        addSubview(playControlView)
        
        /// 3. 竖屏显示
        orientationSupport = .all
        
        /// 4. 隐藏状态栏
        playControlView.barIsHidden = false
        
        /// 5. 开始播放
        player.startPlay()
    }
    
    func addNotificationAndObserver() {
    
        /// 开始生成设备定位通知
        UIDevice.current.beginGeneratingDeviceOrientationNotifications()
        
        /// 注册屏幕旋转通知
        NotificationCenter.default.removeObserver(self, name: UIDevice.orientationDidChangeNotification, object: UIDevice.current)
        NotificationCenter.default.addObserver(self, selector: #selector(orientChange(_:)), name: UIDevice.orientationDidChangeNotification, object: UIDevice.current)
    }
    
    
    // MARK: - InterfaceOrientation - Change (屏幕方向改变)
    @objc func orientChange(_ sender: Notification) {
        
        let orirntation = UIApplication.shared.statusBarOrientation
        if  orirntation == UIInterfaceOrientation.landscapeLeft || orirntation == UIInterfaceOrientation.landscapeRight  {
            isFullScreen = true
            self.removeFromSuperview()
            UIApplication.shared.keyWindow?.addSubview(self)// transitionCurlUp
            UIView.animate(withDuration: 0.2, delay: 0, options: UIView.AnimationOptions.transitionFlipFromRight, animations: {
                self.snp.makeConstraints({ (make) in
                    make.edges.equalTo(kWindow)
                })
                if #available(iOS 11.0, *) {                           // 横屏播放时，适配X
                    if IPhone_X {
                        self.playControlView.snp.remakeConstraints({ (make) in
                            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(28)
                            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).offset(-28)
                            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
                            make.bottom.equalToSuperview()
                        })
                    }
                }
                self.layoutIfNeeded()
                self.playControlView.layoutIfNeeded()
            }, completion: nil)
            
        } else if orirntation == UIInterfaceOrientation.portrait {
            isFullScreen = false
            self.removeFromSuperview()
            if let containerView = self.fatherView {
                containerView.addSubview(self)
                UIView.animate(withDuration: 0.2, delay: 0, options: UIView.AnimationOptions.curveLinear, animations: {
                    self.snp.makeConstraints({ (make) in
                        make.edges.equalTo(containerView)
                    })
                    if #available(iOS 11.0, *) {         // 竖屏播放时，适配X
                        if IPhone_X {
                            self.playControlView.snp.makeConstraints({ (make) in
                                make.edges.equalToSuperview()
                            })
                        }
                    }
                    self.layoutIfNeeded()
                    self.playControlView.layoutIfNeeded()
                }, completion: nil)
            }
        }
    }
    
}


// MARK: 播放器代理方法
extension EZPlayerView: EZUIPlayerDelegate {
    
    // 播放失败
    func ezuiPlayer(_ player: EZUIPlayer!, didPlayFailed error: EZUIError!) {
        let status = error.errorString
        guard let errorString = status else { return }
        ZYToast.showCenterWithText(text: "播放失败!")
        releasePlayer()
    }
    
    // 播放成功
    func ezuiPlayerPlaySucceed(_ player: EZUIPlayer!) {
        debugPrints("视频播放成功")
    }
    
    // 播放器回调返回视频宽高
    func ezuiPlayer(_ player: EZUIPlayer!, previewWidth pWidth: CGFloat, previewHeight pHeight: CGFloat) {
        
        let ratio = pWidth/pHeight
        let destWidth = frame.width
        let destHeight = destWidth/ratio
        //self.player.setPreviewFrame(CGRect(x: 0, y: player.previewView.frame.minY, width: destWidth, height: destHeight))
    }
    
    // 播放器准备完成回调
    func ezuiPlayerPrepared(_ player: EZUIPlayer!) {
        self.player.startPlay()
        playControlView.barIsHidden = true
    }
    
    //  播放结束，回放模式可用
    func ezuiPlayerFinished(_ player: EZUIPlayer!) {
        self.player.stopPlay()
        self.releasePlayer()
    }
    
    // 回放模式有效，播放的当前时间点回调，每1秒回调一次
    func ezuiPlayerPlayTime(_ osdTime: Date!) {
        
    }
}
