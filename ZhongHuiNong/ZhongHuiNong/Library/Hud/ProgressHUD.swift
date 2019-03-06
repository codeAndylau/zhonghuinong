//
//  ProgressHUD.swift
//  SmartVillage
//
//  Created by Andylau on 2018/10/30.
//  Copyright © 2018年 Andylau. All rights reserved.
//

import UIKit

private let shadowColor = UIColor(r: 0, g: 0, b: 0, alpha: 0.7)

/// 全局自定义HUD
class ProgressHUD: UIView {
    
    // MARK: - 下面四个属性可以控制 hud 的边距
    
    /// containtView 到 superView 的左右边距
    var outsideRightAndLeftMargin: CGFloat = 50
    
    /// containtView 的 subView 到 containtView 的左右边距
    var insideRightAndLefMargin: CGFloat = 10
    
    /// containtView 的 subView 到 containtView 顶部的距离
    var insideTopMargin: CGFloat = 10
    
    /// containtView 的 subView 到 containtView 底部的距离
    var insideBottomMargin: CGFloat = 10
    
    /// containtView 距离 superView 中心的偏移量
    var mainViewOffSet: CGFloat = 0

    /// HUD 的 superView 是否可以点击 默认不可点击
    var superViewClickable = false

    
    // MARK: - 外部可控制的属性
    
    /// 背景 View 的颜色
    var backgroundViewColor = UIColor.clear {
        didSet{
            backgroundView.backgroundColor = backgroundViewColor
        }
    }
    
    /// mainView 的颜色
    var containtViewColor = shadowColor {
        didSet{
            containtView.backgroundColor = containtViewColor
        }
    }
    
    /// 自定义 indicatorView
    var customIndicatorView: UIView? {
        didSet{
            if indicatorContainerVisible {
                indicatorContainerSize = customIndicatorView!.frame.size
                indicatorView.removeFromSuperview()
                indicatorContainerView.addSubview(customIndicatorView!)
            } else {
                customIndicatorView = nil
            }
        }
    }
    
    /// 是否显示 indicatorView
    var indicatorContainerVisible = true {
        didSet{
            if !indicatorContainerVisible {
                indicatorContainerSize = CGSize(width: 0, height: 0)
                indicatorView.removeFromSuperview()
            }
        }
    }
    
    /// titleLabel 显示的文字
    var titleText = ""{
        didSet{
            titleLabel.text = titleText
            containtView.addSubview(titleLabel)
        }
    }
    
    /// detailText 显示的文字
    var detailText = "" {
        didSet{
            detailLabel.text = detailText
            containtView.addSubview(detailLabel)
        }
    }
    
    /// detailText 显示的文字
    var detailFont: CGFloat = 0 {
        didSet{
            detailLabel.font = UIFont.systemFont(ofSize: detailFont)
        }
    }
    
    /// 是否圆角
    var cornerRadius: CGFloat? {
        didSet {
            guard let tempCornerRadius = cornerRadius else { return }
            containtView.layer.cornerRadius = tempCornerRadius
        }
    }
    
    /// 内部颜色
    var contentColor: UIColor? {
        didSet {
            tintColor = contentColor
            titleLabel.textColor = contentColor
            detailLabel.textColor = contentColor
        }
    }
    
    /// 文字字体
    var textFont: UIFont! {
        didSet{
            titleLabel.font = textFont
            detailLabel.font = textFont
        }
    }
    
    // MARK: - 内部属性
    
    /// 控件高度上的间距
    private let spaceOfHeight: CGFloat = 10.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(view: UIView) {
        self.init(frame: view.bounds)
        setupUI()
    }
    
    override func layoutSubviews() {
        calculateLayout()
        setContaintViewFrame()
        setSubviewsFrames()
        super.layoutSubviews()
    }
    
    /// 判断hud下面的试图是否能接受触摸事件
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if superViewClickable {
            guard let hitView: UIView = super.hitTest(point, with: event) else { return nil }
            if hitView == self { return nil } else { return hitView }
        } else {
            return super.hitTest(point, with: event)
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - 懒加载
    /// 背景试图
    lazy var backgroundView: BackgroundView = {
        let view = BackgroundView()
        return view
    }()
    
    /// 内容试图
    var containtViewSize = CGSize(width: 0, height: 0)
    lazy var containtView: BackgroundView = {
        let view = BackgroundView()
        view.backgroundColor = shadowColor
        view.layer.cornerRadius = 3
        view.layer.masksToBounds = true
        return view
    }()
    
    /// 指示内容 - 显示 indicator 的 View
    var indicatorContainerSize = CGSize(width: 50, height: 50)
    private lazy var indicatorContainerView: UIView = {
        let view = UIView()
        return view
    }()
    
    /// 指示器
    private lazy var indicatorView: IndicatorView = {
        let view = IndicatorView()
        return view
    }()
    
    /// 显示 title 的 label
    var titleTextSize: CGSize = CGSize(width: 0, height: 0)
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 17)
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.lineBreakMode = NSLineBreakMode.byTruncatingMiddle
        titleLabel.text = ""
        titleLabel.textColor = UIColor.hexColor(0x28D68E) //UIColor.white
        return titleLabel
    }()
    
    /// 显示 detail 的 label
    var detailTextSize = CGSize(width: 0, height: 0)
    private lazy var detailLabel: UILabel = {
        let detailLabel = UILabel()
        detailLabel.font = UIFont.systemFont(ofSize: 15)
        detailLabel.textAlignment = NSTextAlignment.center
        detailLabel.numberOfLines = 0
        detailLabel.text = ""
        detailLabel.textColor = UIColor.hexColor(0x28D68E) //UIColor.white
        return detailLabel
    }()

}

// MARK: - UI
extension ProgressHUD {
    
    func setupUI() {
        // 清除画hud的背景颜色
        backgroundColor = UIColor.clear
        tintColor = UIColor.white
        
        addSubview(backgroundView)
        addSubview(containtView)
        
        containtView.addSubview(indicatorContainerView)
        indicatorContainerView.addSubview(indicatorView)
        
        // 注册通知，防止屏幕选择的情况
        NotificationCenter.default.addObserver(self, selector: #selector(statusBarOrientationDidChange(notification:)), name: UIApplication.didChangeStatusBarOrientationNotification, object: nil)
    }

    
    // 接收通知调用的方法
    @objc func statusBarOrientationDidChange(notification:NSNotification) {
        guard let temp = self.superview else {
            return
        }
        frame = temp.bounds
    }
}

// MARK: - 布局方法
extension ProgressHUD {
    
    /// 计算布局
    func calculateLayout() {
        
        // 获取 titleText 的 size
        guard let titleText = titleLabel.text else { return }
        
        if !(titleText == "") {
            
            let tempTitltTextSize = getTextRectSize(text: titleText, font: titleLabel.font, size: CGSize(width: 0, height: 0)).size
            
            if tempTitltTextSize.width > (frame.size.width - (insideRightAndLefMargin * 2 + outsideRightAndLeftMargin * 2)) {
                titleTextSize = CGSize(width: frame.size.width - (insideRightAndLefMargin * 2 + outsideRightAndLeftMargin * 2),height: tempTitltTextSize.height)
            } else {
                titleTextSize = tempTitltTextSize
            }
            titleTextSize.height = titleTextSize.height + spaceOfHeight
        }
        
        // 获取 detailText 的 size
        guard let detailText = detailLabel.text else { return }
        if !(detailText == "") {
            
            let tempDetailTextSize = getTextRectSize(text: detailText, font: detailLabel.font, size: CGSize(width: 0, height: 0)).size
            
            if tempDetailTextSize.width > (frame.size.width - (insideRightAndLefMargin * 2 + outsideRightAndLeftMargin * 2)) {
                detailTextSize = getTextRectSize(text: detailText, font: detailLabel.font, size: CGSize(width: frame.size.width - (insideRightAndLefMargin * 2 + outsideRightAndLeftMargin * 2), height: 0)).size
                detailTextSize.height = detailTextSize.height + tempDetailTextSize.height
            } else if tempDetailTextSize.width < kScreenW/4 {
                detailTextSize = CGSize(width: kScreenW/4, height: tempDetailTextSize.height)
            } else {
                detailTextSize = tempDetailTextSize
            }
            detailTextSize.height = detailTextSize.height + spaceOfHeight
        }
        
        // 计算 mainView 的 size
        let mainViewHeight = indicatorContainerSize.height + titleTextSize.height + detailTextSize.height + insideBottomMargin + insideTopMargin
        
        var arr = [indicatorContainerSize.width, titleTextSize.width, detailTextSize.width]
        var max = arr[0]
        for i in 0..<arr.count { if arr[i] > max{ max = arr[i] } }
        let mainViewWidth = max
        
        // 统一控件宽度
        indicatorContainerSize.width = max
        titleTextSize.width = max
        detailTextSize.width = max
        
        /*
         var containtViewWidth: CGFloat = 0
         
         if mainViewWidth + insideRightAndLefMargin * 2 < mainViewHeight {
         containtViewWidth = mainViewHeight
         }else {
         containtViewWidth = mainViewWidth
         }
         */
        
        //        var containtViewWidth: CGFloat = 0
        //
        //        if mainViewWidth + insideRightAndLefMargin * 2 < mainViewHeight {
        //            containtViewWidth = mainViewHeight
        //        }else {
        //            containtViewWidth = mainViewHeight
        //        }
        
        indicatorContainerSize.width = max
        titleTextSize.width = max
        detailTextSize.width = max
        
        containtViewSize = CGSize(width: mainViewWidth + insideRightAndLefMargin*2, height: mainViewHeight)
    }
    
    /// 设置 backgroundView 和 mainView 的 frame
    func setContaintViewFrame() {
        
        backgroundView.frame = bounds
        containtView.frame.size = CGSize(width: containtViewSize.width, height: containtViewSize.height)
        
        var center = self.center
        center.y = center.y + mainViewOffSet
        containtView.center = center
    }
    
    /// 设置 mianView 子控件 frame
    func setSubviewsFrames () {
        
        // indicatorView
        indicatorContainerView.frame = CGRect(x: insideRightAndLefMargin, y: insideTopMargin, width: indicatorContainerSize.width, height: indicatorContainerSize.height) // -insideRightAndLefMargin * 2
        if (customIndicatorView != nil) {
            customIndicatorView!.center = CGPoint(x: viewWidth((customIndicatorView?.superview)!)/2, y: viewHeight((customIndicatorView?.superview)!)/2)
            // customIndicatorView 没有设置 frame
            assert( viewWidth(customIndicatorView!) > CGFloat(0) && viewHeight(customIndicatorView!) > CGFloat(0) ,"warning：customIndicatorView 没有设置宽和高，如果你确实想这么干，那就注释了这个断言吧 ")
        } else {
            indicatorView.frame = indicatorContainerView.bounds
        }
        
        // titleLabel
        titleLabel.frame = CGRect(x: insideRightAndLefMargin, y: rectMaxY(indicatorContainerView), width: titleTextSize.width, height: titleTextSize.height) // -insideRightAndLefMargin * 2
        // detailLabel
        detailLabel.frame = CGRect(x: insideRightAndLefMargin, y: rectMaxY(titleLabel) , width: detailTextSize.width, height: detailTextSize.height)  // -insideRightAndLefMargin * 2
        
    }
    
    func viewWidth(_ view:UIView) -> CGFloat {
        return view.frame.size.width
    }
    
    func viewHeight(_ view:UIView) -> CGFloat {
        return view.frame.size.height
    }
    
    func rectMaxX(_ view:UIView) -> CGFloat {
        return view.frame.maxX
    }
    
    func rectMaxY(_ view:UIView) -> CGFloat {
        return view.frame.maxY
    }
    
    func rectMinX(_ view:UIView) -> CGFloat {
        return view.frame.minX
    }
    
    func rectMinY(_ view:UIView) -> CGFloat {
        return view.frame.minY
    }
}

// MARK: - 创建和移除HUD的方法
extension ProgressHUD {
    
    // 创建 HUD，并添加到 View 上
    class func showHUD(AddTo view: UIView) -> ProgressHUD {
        // 调用便利构造方法 创建HUD
        let hud = ProgressHUD(view: view)
        view.addSubview(hud)
        return hud
    }
    
    // 移除 Hud
    class func hideHUD(ForView view: UIView ,animated: Bool) -> Bool {
        guard let hud = self.getHUD(From: view) else { return false }
        if animated {
            UIView.animate(withDuration: 0.5, animations: {
                hud.transform = CGAffineTransform.init(scaleX: 0.9, y: 0.9)
                hud.alpha = 0.001
            }, completion: { (true) in
                hud.removeFromSuperview()
            })
        } else {
            hud.removeFromSuperview()
        }
        return true
    }
    
    // 获取 view 上的 HUD
    class func getHUD(From view: UIView) -> ProgressHUD? {
        
        for view in view.subviews {
            if view.isKind(of: self){
                return view as? ProgressHUD
            }
        }
        return nil
    }
}

// MAKR: - 指示器试图
class IndicatorView: UIView {
    
    let radius: CGFloat = 10.0
    let lineWidth:CGFloat = 2.0
    
    private lazy var indicatorLayer: CAShapeLayer = {
        let indicatorLayer = CAShapeLayer()
        return indicatorLayer
    }()
    
    private lazy var gradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        return gradientLayer
    }()
    
    override var frame: CGRect{
        didSet{
            setupUI()
            startAnimation()
            NotificationCenter.default.addObserver(self, selector: #selector(startAnimation), name: UIApplication.willEnterForegroundNotification, object: nil)
        }
    }
    
    func setupUI() {
        
        backgroundColor = UIColor.clear
        
        // 设置 渐变 图层
        gradientLayer.colors =  [UIColor.hexColor(0x29D68F).cgColor, UIColor.hexColor(0x0BC4B4).cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.25)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        gradientLayer.locations = [0,1]
        
        let gradientLayerCenter = CGPoint(x: bounds.size.width/2 - radius, y: bounds.size.height/2 - radius)
        gradientLayer.frame = CGRect(x: gradientLayerCenter.x, y: gradientLayerCenter.y, width: radius * 2 + lineWidth, height: radius * 2 + lineWidth)
        
        // 设置 mask 图层
        indicatorLayer.fillColor = UIColor.clear.cgColor
        indicatorLayer.strokeColor = UIColor.black.cgColor
        indicatorLayer.lineWidth = lineWidth
        indicatorLayer.lineCap = CAShapeLayerLineCap.round
        
        // 绘制 path
        let startAngle: CGFloat = 0
        let endAngle = CGFloat(Double.pi/2 * 3)
        let arcCenter = CGPoint(x: gradientLayer.frame.size.width/2, y :gradientLayer.frame.size.height/2)
        let path = UIBezierPath(arcCenter: arcCenter, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        indicatorLayer.path = path.cgPath
        gradientLayer.mask = indicatorLayer
        layer.addSublayer(gradientLayer)
        
    }
    
    @objc func startAnimation() {
        //创建旋转动画
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.toValue = NSNumber.init(value:  Double.pi*2.0)
        //旋转指定角度需要的时间
        animation.duration = 1.0
        //旋转重复次数
        animation.repeatCount = MAXFLOAT
        //动画执行完后不移除
        animation.isRemovedOnCompletion = true
        //将动画添加到视图的laye上
        gradientLayer.add(animation, forKey: "rotationAnimation")
    }
    
    // 创建 HUD，并添加到 View 上
    class func showHUD(AddTo view: UIView) -> IndicatorView {
        // 调用便利构造方法 创建HUD
        let hud = IndicatorView()
        view.addSubview(hud)
        return hud
    }
    
    // 移除 Hud
    class func hideHUD(ForView view: UIView ,animated: Bool) -> Bool {
        guard let hud = self.getHUD(From: view) else { return false }
        if animated {
            UIView.animate(withDuration: 0.5, animations: {
                hud.transform = CGAffineTransform.init(scaleX: 0.9, y: 0.9)
                hud.alpha = 0.001
            }, completion: { (true) in
                hud.removeFromSuperview()
            })
        } else {
            hud.removeFromSuperview()
        }
        return true
    }
    
    // 获取 view 上的 HUD
    class func getHUD(From view: UIView) -> IndicatorView? {
        for view in view.subviews {
            if view.isKind(of: self){
                return view as? IndicatorView
            }
        }
        return nil
    }
    
}

// MAKR: - 处理触摸事件的view
class BackgroundView: UIView {
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard let hitView: UIView = super.hitTest(point, with: event) else {
            return nil
        }
        if hitView == self {
            return nil
        } else {
            return hitView
        }
    }
}


// MAKR: - 环形指示器...
class AnnularIndicatorView: UIView {

    var lineWidth: CGFloat = 0
    var radius: CGFloat = 0
    
    var progress: CGFloat = 0 {
        didSet{
            setProgress(progress: progress)
        }
    }
    
    var textSize: CGFloat = 15 {
        didSet{
            progressLabel.font = UIFont.systemFont(ofSize: textSize)
        }
    }
    
    var annularColor: UIColor = UIColor.white  {
        didSet{
            progressLabel.textColor = annularColor
            annularLayer.strokeColor = annularColor.cgColor
        }
    }
    
    var labelVisible = true {
        didSet{
            if !labelVisible {
                progressLabel.removeFromSuperview()
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    lazy var progressLabel: UILabel = {
        let progressLabel = UILabel()
        progressLabel.text = "0%"
        progressLabel.textColor = UIColor.white
        progressLabel.font = UIFont.systemFont(ofSize: 10)
        progressLabel.textAlignment = NSTextAlignment.center
        return progressLabel
    }()

    lazy var backgroundLayer: CAShapeLayer = {
        let backgroundLayer = CAShapeLayer()
        return backgroundLayer
    }()
    
    lazy var annularLayer: CAShapeLayer = {
        let annularLayer = CAShapeLayer()
        return annularLayer
    }()
    
    func setupUI(){
        
        lineWidth = frame.size.height < frame.size.width ? frame.size.height/20 : frame.size.width/20
        radius = frame.size.height < frame.size.width ? frame.size.height/2 - lineWidth/2 : frame.size.width/2 - lineWidth/2
        
        backgroundLayer.fillColor = UIColor.clear.cgColor
        backgroundLayer.strokeColor = UIColor.gray.cgColor
        backgroundLayer.lineWidth = lineWidth
        backgroundLayer.lineCap = CAShapeLayerLineCap.round
        
        annularLayer.fillColor = UIColor.clear.cgColor
        annularLayer.strokeColor = annularColor.cgColor
        annularLayer.lineWidth = lineWidth
        annularLayer.lineCap = CAShapeLayerLineCap.round
        
        // 绘制 path
        let startAngle: CGFloat = 0
        let endAngle = CGFloat(Double.pi * 2)
        let arcCenter = CGPoint(x: frame.size.width/2, y: frame.size.height/2)
        
        let path = UIBezierPath(arcCenter: arcCenter, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        backgroundLayer.path = path.cgPath
        layer.addSublayer(backgroundLayer)
        
        addSubview(progressLabel)
    }
    
    override func layoutSubviews() {
        
        // 设置 progressLabel 的frame
        let x = (radius - lineWidth/2)
        let pw = x * x * 2
        
        progressLabel.frame.size = CGSize(width: sqrt(pw), height: sqrt(pw))
        progressLabel.center = CGPoint(x: frame.size.width/2, y: frame.size.height/2)
    }
    
    func setProgress(progress: CGFloat) {
        
        if progress >= 0.0 && progress <= 100.0 {
            
            let startAngle: CGFloat = CGFloat(Double.pi/2) - CGFloat(Double.pi)
            let endAngle = CGFloat(Double.pi * 1.5)
            let arcCenter = CGPoint(x: frame.size.width/2, y: frame.size.height/2)
            
            let path = UIBezierPath(arcCenter: arcCenter, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
            
            annularLayer.path = path.cgPath
            layer.addSublayer(annularLayer)
            
            annularLayer.strokeEnd = progress / 100
            progressLabel.text = "\(progress)%"
        }
    }

}

/// MARK: - 仿支付宝加载动画 (四边形缩放透明渐变)
class TriangleIndicatorView: UIView {
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        NotificationCenter.default.addObserver(self, selector: #selector(startAnimation), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(frame: CGRect, colorArray: [UIColor]!) {
        self.init(frame: frame)
    }
    
    func setupUI() {
        
        let tWidth = frame.size.width/4
        let tHeight = frame.size.height/4
        
        for i in 0...2 {
            let triangle = TriangleView(frame: CGRect(x: (CGFloat(i) * tWidth)+tWidth/2, y: tWidth+tWidth/4, width: tWidth, height: tHeight))
            addSubview(triangle)
            DispatchQueue.global().async {
                Thread.sleep(forTimeInterval: Double(i)*0.25)
                DispatchQueue.main.async {
                    triangle.startAnimation()
                }
            }
        }
    }
    
    @objc func startAnimation() {
        self.subviews.forEach { (v) in
            v.removeFromSuperview()
        }
        setupUI()
    }
}

class TriangleView: UIView {
    
    private var triangleWidth: CGFloat!
    private var heightOffSet: CGFloat!
    
    private lazy var triangle: CAShapeLayer = {
        let triangle = CAShapeLayer()
        return triangle
    }()
    
    var triangleColor = UIColor.hexColor(0x28D68E) {
        didSet{
            triangle.fillColor = triangleColor.cgColor
        }
    }
    
    var removeBlock: (()->())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        startAnimation()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        
        triangle.fillColor = triangleColor.cgColor
        triangle.strokeColor = nil
        triangle.lineWidth = 0
        triangle.lineCap = CAShapeLayerLineCap.round
        
//        // 三角形
//        let path = UIBezierPath()
//
//        let topPoint = CGPoint(x: triangleWidth/5, y: heightOffSet + triangleWidth/10)
//        path.move(to: topPoint)
//
//        let bottomPoint = CGPoint(x: triangleWidth/5, y: triangleWidth + heightOffSet - triangleWidth/10)
//        path.addQuadCurve(to: bottomPoint, controlPoint: CGPoint(x: 0, y: triangleWidth/2 + heightOffSet))
//
//        let rightPoint = CGPoint(x: triangleWidth , y: triangleWidth/2 + heightOffSet)
//        path.addQuadCurve(to: rightPoint, controlPoint: CGPoint(x: triangleWidth/5*1.5, y: triangleWidth + heightOffSet))
//
//        path.addQuadCurve(to: topPoint, controlPoint: CGPoint(x: triangleWidth/5*1.5, y: heightOffSet))
//        triangle.path = path.cgPath
        
        
        // 四边形
        let path = UIBezierPath()
        let w = frame.width

        let topLeftPoint = CGPoint(x: w/4, y: 0)
        path.move(to: topLeftPoint)
        
        let topRightPoint = CGPoint(x: w, y: 0)
        path.addLine(to: topRightPoint)
        
        let bottomRightPotin = CGPoint(x: w*3/4, y: w)
        path.addLine(to: bottomRightPotin)
        
        let bottomLeftPotin = CGPoint(x: 0, y: w)
        path.addLine(to: bottomLeftPotin)
        
        triangle.path = path.cgPath
        layer.addSublayer(triangle)
        
    }
    
    @objc func startAnimation() {

        //创建旋转动画
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.toValue = NSNumber.init(value: 0.2)
        scaleAnimation.duration = 0.75
        scaleAnimation.repeatCount = MAXFLOAT
        scaleAnimation.isRemovedOnCompletion = true

        let opacityAnimation = CABasicAnimation(keyPath: "opacity")
        opacityAnimation.toValue = NSNumber.init(value: 0.2)
        opacityAnimation.duration = 0.75
        opacityAnimation.repeatCount = MAXFLOAT
        opacityAnimation.isRemovedOnCompletion = true

        let group = CAAnimationGroup()
        group.animations = [scaleAnimation,opacityAnimation]
        group.duration = 0.75
        group.autoreverses = true
        group.repeatCount = MAXFLOAT
        //group.isRemovedOnCompletion = false
        //group.fillMode = CAMediaTimingFillMode.backwards  //forwards
        layer.add(group, forKey: "groupAnimation")
    }
    
    @objc func removeAnimation() {
        layer.removeAllAnimations()
    }
}


// MAKR: - 对ProgressHUD 的二次封装
class HudHelper: NSObject {
    
    // MARK: - 加载指示器
    class func showIndicator(_ onView: UIView? = kWindow) {
        // 获取需要添加 HUD 的 View
        guard let view = onView else { return }
        let hud = IndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        hud.center = kWindow.center
        view.addSubview(hud)
    }
    
    class func hideIndicator( _ FromView: UIView? = kWindow) {
        guard let view = FromView else { return }
        _ = IndicatorView.hideHUD(ForView: view, animated: true)
    }
    
    // MARK: - 加载支付宝hud
    class func showTriangleHUD(onView: UIView) {
        let hud = ProgressHUD.showHUD(AddTo: onView)
        let triangleView = TriangleIndicatorView(frame: CGRect(x: 100, y: 100, width: 50, height: 50))
        hud.customIndicatorView = triangleView
        hud.detailText = "加载中..."
        hud.detailFont = 13
    }
    
    // MARK: - 加载环形进度条
    class func showProgressHUD(onView: UIView) -> AnnularIndicatorView {
        let Indicator = AnnularIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        let hud = ProgressHUD.showHUD(AddTo: onView)
        hud.customIndicatorView = Indicator
        hud.titleText = "loading..."
        return Indicator
    }
    
    // MARK: - StrikeHUD
    class func showStrikeHUD(onView: UIView!) {
        let hud: ProgressHUD = ProgressHUD.showHUD(AddTo: onView)
        hud.contentColor = UIColor.lightGray
        hud.superViewClickable = true
        hud.containtViewColor = UIColor.clear
    }
    
    // MARK: - WaitHUD
    class func showWaittingHUD(msg: String) {
        showWaittingHUD(msg: msg, onView: nil)
    }
    
    class func showWaittingHUD(msg: String, onView: UIView?) {
        // 获取需要添加 HUD 的 View
        var tempView = onView
        if tempView == nil {
            tempView = UIApplication.shared.windows.last
        }
        guard let view = tempView else { return }
        let hud: ProgressHUD = ProgressHUD.showHUD(AddTo: view)
        hud.superViewClickable = true
        hud.detailText = msg
    }

    // MARK: - MessageHUD
    class func showMessageHUD(msg: String) {
        showMessageHUD(msg: msg, onView: nil)
    }
    
    class func showMessageHUD(msg: String, onView: UIView?) {
        // 获取需要添加 HUD 的 View
        var tempView = onView
        if tempView == nil {
            tempView = UIApplication.shared.windows.last
        }
        guard let view = tempView else { return }
        // 创建 HUD
        let hud: ProgressHUD = ProgressHUD.showHUD(AddTo: view)
        // 设置 HUD 的属性
        hud.detailText = msg
        hud.indicatorContainerVisible = false
        
        DispatchQueue.global().async {
            Thread.sleep(forTimeInterval: 2)
            DispatchQueue.main.async {
                if onView == nil{
                    HudHelper.hideHUD(FromView: nil)
                }
                HudHelper.hideHUD(FromView: onView!)
            }
        }
    }
    
    // MARK: - TipsHUD
    class func showSucceedHUD(msg: String) {
        showImageHUD(msg: msg, pictureName: "Checkmark", onView: nil)
    }
    
    class func showSucceedHUD(msg: String ,onView: UIView?) {
        showImageHUD(msg: msg, pictureName: "Checkmark", onView: onView)
    }
    
    class func showWarningHUD(msg: String) {
        showImageHUD(msg: msg, pictureName: "Warning", onView: nil)
    }
    
    class func showWarningHUD(msg: String ,onView: UIView?) {
        showImageHUD(msg: msg, pictureName: "Warning", onView: onView)
    }
    
    class func showErrorHUD(msg: String) {
        showImageHUD(msg: msg, pictureName: "Error", onView: nil)
    }
    
    class func showErrorHUD(msg: String ,onView: UIView?) {
        showImageHUD(msg: msg, pictureName: "Error", onView: onView)
    }
 
    class func showImageHUD(msg: String, pictureName:String ,onView: UIView?) {
        
        // 获取需要添加 HUD 的 View
        var tempView = onView
        if tempView == nil {
            tempView = UIApplication.shared.windows.last
        }
        guard let view = tempView else { return }
        let hud = ProgressHUD.showHUD(AddTo: view)
        var img = UIImage(named: pictureName)
        img = img?.withRenderingMode(.alwaysTemplate)
        let imageView = UIImageView(image: img)
        hud.customIndicatorView = imageView
        hud.detailText = msg
        
        DispatchQueue.global().async {
            Thread.sleep(forTimeInterval: 1.5)
            DispatchQueue.main.async {
                if onView == nil{
                    HudHelper.hideHUD(FromView: nil)
                    return
                }
                HudHelper.hideHUD(FromView: onView!)
            }
        }
    }
    
    // 隐藏 HUD
    class func hideHUD(FromView view: UIView?) {
        var tempView = view
        if tempView == nil {
            tempView = UIApplication.shared.windows.last
        }
        guard let view = tempView else { return }
        _ = ProgressHUD.hideHUD(ForView: view ,animated: true)
    }
    
}
