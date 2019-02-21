//
//  PageTitleView.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/21.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

// MARK:- 定义协议 点击title时候的方法回调
protocol PageTitleViewDelegate : class {
    func pageTitleView(_ titleView : PageTitleView, selectedIndex index : Int)
}

private let kLineWidth: CGFloat = 20
private let kScrollLineH : CGFloat = 4
private let kScrollLineW : CGFloat = 36

class PageTitleView: UIView {

    // MARK:- 定义属性
    fileprivate var currentIndex : Int!  // 默认选中第一个
    fileprivate var titles : [String] = []
    weak var delegate : PageTitleViewDelegate?
    
    // MARK:- 懒加载属性
    fileprivate lazy var titleLabels : [UILabel] = [UILabel]()
    
    fileprivate lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        return scrollView
    }()
    
    fileprivate lazy var scrollLine : UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.hexColor(0x1DD1A8)
        return scrollLine
    }()
    
    // MARK:- 自定义构造函数
    init(frame: CGRect, titles: [String], currentIndex: Int) {
        self.titles = titles
        self.currentIndex = currentIndex
        super.init(frame: frame)
        
        // 设置UI界面
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


// MARK:- 设置UI界面
extension PageTitleView {
    
    fileprivate func setupUI() {
        
        backgroundColor = UIColor.white
        // 1.添加UIScrollView
        addSubview(scrollView)
        scrollView.frame = bounds
        
        // 2.添加title对应的Label
        setupTitleLabels()
    }
    
    fileprivate func setupTitleLabels() {
        
        // 0.确定label的一些frame的值
        let labelW : CGFloat = frame.width / CGFloat(titles.count)
        let labelH : CGFloat = frame.height - kScrollLineH
        let labelY : CGFloat = 0
        
        for (index, title) in titles.enumerated() {
            // 1.创建UILabel
            let label = UILabel()
            
            // 2.设置Label的属性
            label.text = title
            label.tag = index
            label.textAlignment = .center
            label.textColor = UIColor.hexColor(0x999999)
            label.font = UIFont.systemFont(ofSize: 14)
            
            // 3.设置label的frame
            let labelX : CGFloat = labelW * CGFloat(index)
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            
            // 4.将label添加到scrollView中
            scrollView.addSubview(label)
            titleLabels.append(label)
            
            // 5.给Label添加手势
            label.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(self.titleLabelClick(_:)))
            label.addGestureRecognizer(tapGes)
            
            if index == currentIndex {
                // 2.添加scrollLine
                
                // 添加title下划细线的宽度
                //let lineWidth = LCUtils.calculateTextSizeWith(title, font: 12, maxW: kScreen_w/3).width
                
                // 2.2.设置scrollLine的属性
                scrollView.addSubview(scrollLine)
                scrollLine.frame = CGRect(x: 0, y: frame.height - kScrollLineH, width: kLineWidth, height: kScrollLineH)
                scrollLine.center = CGPoint(x: label.center.x, y: frame.height - kScrollLineH/2)
                scrollLine.layer.cornerRadius = kScrollLineH/2
            }
        }
    }
    
}

// MARK:- 监听Label的点击
extension PageTitleView {
    
    @objc fileprivate func titleLabelClick(_ tapGes : UITapGestureRecognizer) {
        
        // 0.获取当前Label
        guard let currentLabel = tapGes.view as? UILabel else { return }
        
        // 1.如果是重复点击同一个Title,那么直接返回
        if currentLabel.tag == currentIndex { return }
        
        // 2.保存最新Label的下标值
        currentIndex = currentLabel.tag
        
        // 添加title下划细线的宽度
        let title = titles[currentIndex]
        //let lineWidth = LCUtils.calculateTextSizeWith(title, font: 12, maxW: kScreen_w/3).width
        
        // 3.滚动条位置发生改变
        UIView.animate(withDuration: 0.25, animations: {
            self.scrollLine.frame = CGRect(x: 0, y: self.frame.height - kScrollLineH, width: kLineWidth, height: kScrollLineH)
            self.scrollLine.center = CGPoint(x: self.titleLabels[currentLabel.tag].center.x, y: self.frame.height - kScrollLineH/2)
        })
        
        // 4.通知代理
        delegate?.pageTitleView(self, selectedIndex: currentIndex)
    }
}


// MARK:- 对外暴露的方法

extension PageTitleView {
    
    func setTitleWithTargetIndex(_ targetIndex : Int) {
        
        currentIndex = targetIndex
        
        // 添加title下划细线的宽度
        let title = titles[currentIndex]
        //let lineWidth = LCUtils.calculateTextSizeWith(title, font: 12, maxW: kScreen_w/3).width
        
        UIView.animate(withDuration: 0.25, animations: {
            self.scrollLine.frame = CGRect(x: 0, y: self.frame.height - kScrollLineH, width: kLineWidth, height: kScrollLineH)
            self.scrollLine.center = CGPoint(x: self.titleLabels[targetIndex].center.x, y: self.frame.height - kScrollLineH/2)
        })
    }
}
