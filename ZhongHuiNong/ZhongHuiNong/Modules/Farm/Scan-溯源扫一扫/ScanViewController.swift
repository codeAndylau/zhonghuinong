//
//  ScanViewController.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/27.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit
import WebKit
import Photos
import AVFoundation

// 溯源扫一扫
class ScanViewController: ViewController, UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    
    // 调用系统照相设备
    var captureSession: AVCaptureSession! // 二维码生成的绘画
    var captureVideoPreviewLayer: AVCaptureVideoPreviewLayer! // 二维码生成的图层
    
    var captureDevice: AVCaptureDevice! // 摄像头设备
    var captureDeviceInput: AVCaptureDeviceInput! // 设备输入
    var captureMetadataOutput: AVCaptureMetadataOutput! // 设备输出
    
    // 扫码中各种状态值
    var annimationTimer: Timer? // 负责线条上下走动的timer
    var turnoff: Bool = true // 闪光灯默认关闭
    
    var isBig = false
    
    override func makeUI() {
        super.makeUI()
        
        navigationItem.title = localized("二维码/条码")
        navigationItem.rightBarButtonItem = rightPhotoItem
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Color.whiteColor]
        
        statusBarStyle.accept(true)
        setupViews()
        setupCamera()
        
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
        lampBtn.rx.tap.subscribe(onNext: { [weak self]  (_) in
            guard let self = self else { return }
            if self.captureDevice.hasTorch {
                if self.turnoff {
                    if self.captureDevice.isTorchModeSupported(AVCaptureDevice.TorchMode.on) {
                        if self.captureDevice.torchMode != AVCaptureDevice.TorchMode.on {
                            self.lampBtn.setImage(UIImage(named: "farm_scan_ lamp_h"), for: .normal)
                            do {
                                try self.captureDevice.lockForConfiguration()
                                self.captureDevice.torchMode = AVCaptureDevice.TorchMode.on
                                self.captureDevice.unlockForConfiguration()
                            }catch {
                                debugPrints("打开闪光灯失败")
                            }
                        }
                    }
                    self.turnoff = false
                }else {
                    if self.captureDevice.isTorchModeSupported(AVCaptureDevice.TorchMode.off) {
                        if self.captureDevice.torchMode != AVCaptureDevice.TorchMode.off {
                            self.lampBtn.setImage(UIImage(named: "farm_scan_ lamp"), for: .normal)
                            do {
                                try self.captureDevice.lockForConfiguration()
                                self.captureDevice.torchMode = AVCaptureDevice.TorchMode.off
                                self.captureDevice.unlockForConfiguration()
                            }catch {
                                debugPrints("关闭闪光灯失败")
                            }
                        }
                    }
                    self.turnoff = true
                }
            }
            
        }).disposed(by: rx.disposeBag)
        
        let tap = UITapGestureRecognizer()
        tap.numberOfTapsRequired = 2
        tap.rx.event.subscribe(onNext: { [weak self] (_) in
            guard let self = self else { return }
            if self.isBig {
                do {
                    try self.captureDevice.lockForConfiguration()
                } catch _ {
                    debugPrints("Error: lockForConfiguration.");
                }
                
                self.captureDevice.videoZoomFactor = 1.0
                self.captureDevice.unlockForConfiguration()
                self.isBig = false
            }else {
                do {
                    try self.captureDevice.lockForConfiguration()
                } catch _ {
                    debugPrints("Error: lockForConfiguration.");
                }
                self.captureDevice.videoZoomFactor = 2.0
                self.captureDevice.unlockForConfiguration()
                self.isBig = true
            }
            
        }).disposed(by: rx.disposeBag)
        view.addGestureRecognizer(tap)
        
        NotificationCenter.default.rx.notification(UIApplication.didBecomeActiveNotification).subscribe(onNext: { [weak self] (_) in
            guard let self = self else { return }
            if self.captureSession != nil {
                self.captureSession.startRunning()
            }
        }).disposed(by: rx.disposeBag)
        
        
        webBottomView.backBtn.rx.tap.subscribe(onNext: { [weak self] (_) in
            guard let self = self else { return }
            if self.webView.canGoBack {
               self.webView.goBack()
            }
        }).disposed(by: rx.disposeBag)
        
        webBottomView.forwardBtn.rx.tap.subscribe(onNext: { [weak self] (_) in
            guard let self = self else { return }
            if self.webView.canGoForward {
                self.webView.goForward()
            }
        }).disposed(by: rx.disposeBag)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if captureSession != nil {
            captureSession.startRunning()
        }
        annimationTimer = Timer.scheduledTimer(timeInterval: 0.03, target: self, selector: #selector(scanLineAnimation), userInfo: nil, repeats: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        annimationTimer?.invalidate()
        annimationTimer = nil
        
        if turnoff == false {
            if self.captureDevice.isTorchModeSupported(AVCaptureDevice.TorchMode.off) {
                if self.captureDevice.torchMode != AVCaptureDevice.TorchMode.off {
                    self.lampBtn.setImage(UIImage(named: "farm_scan_ lamp"), for: .normal)
                    do {
                        try self.captureDevice.lockForConfiguration()
                        self.captureDevice.torchMode = AVCaptureDevice.TorchMode.off
                        self.captureDevice.unlockForConfiguration()
                    }catch {
                        debugPrints("关闭闪光灯失败")
                    }
                }
            }
            self.turnoff = true
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        //计算中间可探测区域
        let windowSize = UIScreen.main.bounds.size
        let scanSize = CGSize(width: windowSize.width*3/4, height: windowSize.width*3/4)
        let scanRect = CGRect(x:(windowSize.width-scanSize.width)/2, y:(windowSize.height-scanSize.height)/2, width:scanSize.width, height:scanSize.height)
        
        scanImg.frame = scanRect
        lineImg.frame = CGRect(x: (kScreenW-kScreenW*3/4)/2, y: (kScreenH-kScreenW*3/4)/2, width: scanSize.width, height: 4)
        
        topView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view)
            make.left.right.equalTo(self.view)
            make.height.equalTo((kScreenH-kScreenW*3/4)/2+3)
        }
        
        leftView.snp.makeConstraints { (make) in
            make.left.bottom.equalTo(self.view)
            make.top.equalTo(topView.snp.bottom)
            make.width.equalTo((kScreenW-kScreenW*3/4)/2+3)
        }
        
        rightView.snp.makeConstraints { (make) in
            make.right.bottom.equalTo(self.view)
            make.top.equalTo(topView.snp.bottom)
            make.width.equalTo((kScreenW-kScreenW*3/4)/2+3)
        }
        
        bottomView.snp.makeConstraints { (make) in
            make.left.equalTo(self.view).offset((kScreenW-kScreenW*3/4)/2+3)
            make.right.equalTo(self.view).offset(-(kScreenW-kScreenW*3/4)/2-3)
            make.bottom.equalTo(self.view)
            make.height.equalTo((kScreenH-kScreenW*3/4)/2+3)
        }
        
        tipsLab.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
        }
        
        lampBtn.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-30)
            make.centerX.equalToSuperview()
        }
        
        lampLab.snp.makeConstraints { (make) in
            make.top.equalTo(lampBtn.snp.bottom)
            make.centerX.equalToSuperview()
        }
    }
    
    // 在监听方法中设置 back 与 forward 按钮
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard let key = keyPath else { return }
        switch key {
        case "title":
            debugPrints("web---title---\(String(describing: webView.title))")
        case "URL":
            debugPrints("web---URL---\(String(describing: webView.url?.absoluteString))")
        case "loading":
            debugPrints("web---loading---\(webView.isLoading)")
        case "canGoBack":
            debugPrints("web---canGoBack---\(webView.isLoading)")
            webBottomView.backBtn.isEnabled = webView.canGoBack
        case "canGoForward":
            debugPrints("web---canGoForward---\(webView.isLoading)")
            webBottomView.forwardBtn.isEnabled = webView.canGoForward
        case "estimatedProgress":
            progressView.alpha = 1.0
            progressView.setProgress(Float(webView.estimatedProgress), animated: true)
            if webView.estimatedProgress >= 1.0 {
                UIView.animate(withDuration: 0.3, delay: 0.1, options: .curveEaseOut, animations: {
                    self.progressView.alpha = 0
                }, completion: { (finish) in
                    self.progressView.setProgress(0.0, animated: false)
                })
            }
        default: break
        }
    }
    
    deinit {
        self.webView.removeObserver(self, forKeyPath: "title")
        self.webView.removeObserver(self, forKeyPath: "URL")
        self.webView.removeObserver(self, forKeyPath: "loading")
        self.webView.removeObserver(self, forKeyPath: "canGoBack")
        self.webView.removeObserver(self, forKeyPath: "canGoForward")
        self.webView.removeObserver(self, forKeyPath: "estimatedProgress")
        self.webView.navigationDelegate = nil
    }
    
    // MARK: - Property
    let topView = View().then { (view) in view.backgroundColor = UIColor.black.withAlphaComponent(0.6) }
    let leftView = View().then { (view) in view.backgroundColor = UIColor.black.withAlphaComponent(0.6) }
    let rightView = View().then { (view) in view.backgroundColor = UIColor.black.withAlphaComponent(0.6) }
    let bottomView = View().then { (view) in view.backgroundColor = UIColor.black.withAlphaComponent(0.6) }
    
    let scanImg = ImageView().then { (img) in
        img.image = UIImage(named: "farm_scan_box")
        img.isUserInteractionEnabled = true
    }
    
    let lineImg = ImageView().then { (img) in
        img.image = UIImage(named: "farm_scan_line")
    }
    
    let tipsLab = Label().then { (lab) in
        lab.text = "将二维码放入框内,即可自动扫描"
        lab.textColor = UIColor.white
        lab.font = UIFont.boldSystemFont(ofSize: 15)
        lab.textAlignment = .center
    }
    
    let lampBtn = Button().then { (btn) in
        btn.setImage(UIImage(named: "farm_scan_ lamp"), for: .normal)
        btn.adjustsImageWhenHighlighted = false
    }
    
    let lampLab = Label().then { (lab) in
        lab.text = "轻触照亮"
        lab.textColor = UIColor.white
        lab.font = UIFont.boldSystemFont(ofSize: 14)
        lab.textAlignment = .center
    }
    
    // MARK: - Lazy
    lazy var rightPhotoItem = BarButtonItem(image: UIImage(named: "farm_scan_photo"), target: self, action: #selector(photoAction))
    
    lazy var webBottomView = WebBottomView.loadView()
    
    lazy var progressView: UIProgressView = {
        let progress = UIProgressView(frame: CGRect(x: 0, y: 42, width: kScreenW, height: 2))
        progress.tintColor = Color.theme1DD1A8
        progress.trackTintColor = UIColor.white
        progress.progress = 0
        return progress
    }()
        
    lazy var webView: WKWebView = {
        let web = WKWebView(frame: CGRect(x: 0, y: kNavBarH, width: kScreenW, height: kScreenH-kNavBarH))
        web.backgroundColor = UIColor.white
        web.navigationDelegate = self
        web.addObserver(self, forKeyPath: "title", options: .new, context: nil)     // 创建WKWebView时设置，或者在viewDidLoad()中
        web.addObserver(self, forKeyPath: "URL", options: .new, context: nil)       // 注意：url 属性对应的 keyPath 是大写的 URL
        web.addObserver(self, forKeyPath: "loading", options: .new, context: nil)   // 注意：isLoading 属性对应的 keyPath 是 loading
        web.addObserver(self, forKeyPath: "canGoBack", options: .new, context: nil)
        web.addObserver(self, forKeyPath: "canGoForward", options: .new, context: nil)
        web.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        return web
    }()
    
    // MARK: - Action
    @objc func scanLineAnimation() {
        if scanImg.frame.maxY - lineImg.frame.maxY < 4 {
            lineImg.frame = CGRect(x: lineImg.frame.origin.x, y: scanImg.frame.minY, width: lineImg.frame.width, height: lineImg.frame.height)
        }else {
            lineImg.frame = CGRect(x: lineImg.frame.origin.x, y: lineImg.frame.origin.y + 4,width: lineImg.frame.width, height: lineImg.frame.height)
        }
    }
    
    @objc func photoAction() {
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .authorized:
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                let picker = UIImagePickerController()
                picker.delegate = self
                picker.sourceType = .photoLibrary
                picker.allowsEditing = true
                present(picker, animated: true, completion: nil)
            }else {
                ZYToast.showCenterWithText(text: "读取相册失败!")
            }
            
        case .notDetermined,.denied,.restricted:
            PHPhotoLibrary.requestAuthorization({ [weak self] (status) in
                if let strongSelf = self {
                    if status == PHPhotoLibrary.authorizationStatus()  {
                        if status.hashValue == 3 {
                            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                                let picker = UIImagePickerController()
                                picker.delegate = self
                                picker.sourceType = .photoLibrary
                                picker.allowsEditing = true
                                strongSelf.present(picker, animated: true, completion: nil)
                            }else {
                                ZYToast.showCenterWithText(text: "读取相册失败!")
                            }
                        }else {
                            strongSelf.showAlertWithTitle(title: "无法使用相册", message: "请在iPhone的\"设置－隐私－相册\"中允许访问相册", openSettingsURLString: UIApplication.openSettingsURLString, isShowOKBtn: true)
                        }
                    }
                }
            })
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage  else { return }
        guard let ciImage = CIImage(image: image) else { return }
        
        let context = CIContext(options: nil) // 二维码读取
        let detector = CIDetector(ofType: CIDetectorTypeQRCode, context: context, options: [CIDetectorAccuracy:CIDetectorAccuracyHigh])
        let features = detector?.features(in: ciImage)
        
        var array = [String]()
        for feature in features as! [CIQRCodeFeature] {
            array.append(feature.messageString!)
        }

        picker.dismiss(animated: true) {  [weak self] in
            if let strongSelf = self {
                if features?.count == 0 {
                    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
                    ZYToast.showTopWithText(text: "未在图中发现二维码")
                } else if features?.count ?? 0 >= 1 {
                    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
                    strongSelf.navigationItem.rightBarButtonItem = nil
                    if let stringValue = array.first  {
                        
                        strongSelf.view.addSubview(strongSelf.webView)
                        strongSelf.view.addSubview(strongSelf.webBottomView)
                        strongSelf.navigationController?.navigationBar.addSubview(strongSelf.progressView)
                        
                        let backColor = UIImage().getImageWithColor(color: UIColor.white)
                        strongSelf.navigationController?.navigationBar.setBackgroundImage(backColor, for: .default)
                        strongSelf.navigationController?.navigationBar.tintColor = UIColor.black
                        strongSelf.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
                        strongSelf.statusBarStyle.accept(false)
                        
                        debugPrints("相册扫码出的url---\(stringValue)")
                        let url = URL(string: stringValue)
                        guard let u = url else { return }
                        let request = URLRequest(url: u)
                        strongSelf.webView.load(request)
                    }
                }
            }
        }
    }
    
}

extension ScanViewController {
    
    func setupViews() {
        view.addSubview(lineImg)
        view.addSubview(topView)
        view.addSubview(leftView)
        view.addSubview(rightView)
        view.addSubview(bottomView)
        view.addSubview(scanImg)
        scanImg.addSubview(lampBtn)
        scanImg.addSubview(lampLab)
        bottomView.addSubview(tipsLab)
    }
    
    func setupCamera() {
        if isRightCamera() {
            do {
                
                captureDevice = AVCaptureDevice.default(for: AVMediaType.video)
                
                // 自动对焦
                if captureDevice.isFocusModeSupported(AVCaptureDevice.FocusMode.continuousAutoFocus) && captureDevice.isFocusPointOfInterestSupported {
                    
                    do {
                        try captureDevice.lockForConfiguration()
                    }catch {
                        debugPrint("不支持自动对焦")
                        ZYToast.showCenterWithText(text: "不支持自动对焦")
                    }
                    
                    captureDevice.focusPointOfInterest = CGPoint(x: kScreenW/2, y: kScreenH/2)
                    captureDevice.focusMode = .continuousAutoFocus
                    captureDevice.unlockForConfiguration()
                }
                
                captureDeviceInput = try AVCaptureDeviceInput(device: captureDevice)
                
                captureMetadataOutput = AVCaptureMetadataOutput()
                
                captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
                
                captureSession = AVCaptureSession()
                
                if kScreenH < 500 {
                    captureSession.sessionPreset = AVCaptureSession.Preset.vga640x480
                }else {
                    captureSession.sessionPreset = AVCaptureSession.Preset.high
                }
                
                captureSession.addInput(captureDeviceInput)
                captureSession.addOutput(captureMetadataOutput)
                
                captureMetadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr,
                                                             AVMetadataObject.ObjectType.ean13,
                                                             AVMetadataObject.ObjectType.ean8,
                                                             AVMetadataObject.ObjectType.code128,
                                                             AVMetadataObject.ObjectType.code39,
                                                             AVMetadataObject.ObjectType.code93]
                
                
                //计算中间可探测区域
                let windowSize = UIScreen.main.bounds.size
                let scanSize = CGSize(width: windowSize.width*3/4, height: windowSize.width*3/4)
                var scanRect = CGRect(x:(windowSize.width-scanSize.width)/2,
                                      y:(windowSize.height-scanSize.height)/2,
                                      width:scanSize.width, height:scanSize.height)
                
                //计算rectOfInterest 注意x,y交换位置
                scanRect = CGRect(x:scanRect.origin.y/windowSize.height,
                                  y:scanRect.origin.x/windowSize.width,
                                  width:scanRect.size.height/windowSize.height,
                                  height:scanRect.size.width/windowSize.width)
                
                captureMetadataOutput.rectOfInterest = scanRect
                
                captureVideoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
                captureVideoPreviewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
                captureVideoPreviewLayer.frame = UIScreen.main.bounds
                
                captureVideoPreviewLayer.frame = UIScreen.main.bounds
                view.layer.insertSublayer(captureVideoPreviewLayer, at:0)
                
                //开始捕获
                captureSession.startRunning()

            } catch {
                showAlertWithTitle(title: "无法使用相机", message: "请在iPhone的\"设置－隐私－相机\"中允许访问相机", openSettingsURLString: UIApplication.openSettingsURLString, isShowOKBtn: true)
            }
            
        }else {
            AVCaptureDevice.requestAccess(for: AVMediaType.video) { [weak self] (flag) in
                if let strongSelf = self, flag == true {
                    DispatchQueue.main.async {
                       strongSelf.setupCamera()
                    }
                }else {
                    self?.showAlertWithTitle(title: "无法使用相机", message: "请在iPhone的\"设置－隐私－相机\"中允许访问相机", openSettingsURLString: UIApplication.openSettingsURLString, isShowOKBtn: true)
                }
            }
        }
        
    }
}

// MARK: - AVCaptureMetadataOutputObjectsDelegate
extension ScanViewController: AVCaptureMetadataOutputObjectsDelegate {
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        
        var stringValue: String?
        if metadataObjects.count > 0 {
            let metadataObject = metadataObjects[0]
                as! AVMetadataMachineReadableCodeObject
            stringValue = metadataObject.stringValue
            
            if stringValue != nil{
                self.captureSession.stopRunning()
            }
        }
        
        self.captureSession.stopRunning()
        self.navigationItem.rightBarButtonItem = nil
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)  // 抖动
        view.addSubview(webView)
        view.addSubview(webBottomView)
        navigationController?.navigationBar.addSubview(progressView)

        
        let backColor = UIImage().getImageWithColor(color: UIColor.white)
        navigationController?.navigationBar.setBackgroundImage(backColor, for: .default)
        navigationController?.navigationBar.tintColor = UIColor.black
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        statusBarStyle.accept(false)
        
        debugPrints("扫码出的url---\(stringValue ?? "")")

        let url = URL(string: stringValue ?? "")
        guard let u = url else { return }
        let request = URLRequest(url: u)
        webView.load(request)
    }
}

// MARK: - WKNavigationDelegate
extension ScanViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        debugPrints("页面开始加载时调用")
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        debugPrints("当内容开始返回时调用")
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        debugPrints("页面加载完成之后调用")
        navigationItem.title = webView.title
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        debugPrints("页面加载失败时调用")
        
    }
    
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        debugPrints("接收到服务器跳转请求之后调用")
    }
    
}
