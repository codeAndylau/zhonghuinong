//
//  SearchHotView.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/14.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class SearchHotView: View {
    
    /// 标题
    let titleLabel = UILabel()
    
    let deleteBtn = UIButton()
    
    /// 上一个按钮的maxX加上间距
    var lastX: CGFloat = 0
    
    /// 上一个按钮的y值
    var lastY: CGFloat = 52
    
    /// 按钮的回调block
    var btnCallBackBlock: ((_ btn: UIButton) -> ())?
    
    /// 删除按钮的回调block
    var deleteBtnCallBackBlock: ((_ btn: UIButton) -> ())?
    
    /// SearchView的总高度
    var searchViewHeight: CGFloat = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        titleLabel.frame = CGRect(x: 0, y: 15, width: frame.size.width - 50, height: 35)
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.textColor = UIColor.hexColor(0x333333)
        addSubview(titleLabel)
        
        deleteBtn.frame = CGRect(x: kScreenW-38-22, y: 0, width: 44, height: 46)
        deleteBtn.centerY = titleLabel.centerY
        deleteBtn.setImage(UIImage(named: "search_delete"), for: .normal)
        deleteBtn.addTarget(self, action: #selector(deleteBtnClick(sender:)), for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(frame: CGRect, titleLabelText: String, isHot: Bool = false, btnTexts: [String], btnCallBackBlock: @escaping ((_ sender: UIButton) -> ())) {
        self.init(frame: frame)
        
        titleLabel.text = titleLabelText
        
        if isHot {
            addSubview(deleteBtn)
        }
        
        //按钮文字的宽度
        var btnW: CGFloat = 0
        //按钮的高度
        let btnH: CGFloat = 30
        //文字与按钮两边的距离之和
        let addW: CGFloat = 30
        //横向间距
        let marginX: CGFloat = 12
        //纵向间距
        let marginY: CGFloat = 12
        
        for i in 0..<btnTexts.count {
            let btn = UIButton(type: .custom)
            btn.setTitle(btnTexts[i], for: .normal)
            btn.setTitleColor(UIColor.hexColor(0x666666), for: .normal)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            btn.titleLabel?.sizeToFit()
            btn.backgroundColor = UIColor.hexColor(0xF7F7F7)
            btn.layer.cornerRadius = 15
            btn.titleLabel?.lineBreakMode = .byTruncatingTail
            btn.addTarget(self, action: #selector(btnClick(sender:)), for: .touchUpInside)
            
            // 按钮的总宽度
            btnW = btn.titleLabel!.bounds.width + addW
            
            // 在给按钮的frame赋值之前先判断本行余下的宽度是否大于将要布局的按钮的宽度,如果大于则x值为上一个按钮的宽度加上横向间距,y值与上一个按钮相同,如果小于则x值为0,y值为上一个按钮的y值加上按钮的高度和纵向间距
            if frame.width - lastX > btnW {
                btn.frame = CGRect(x: lastX, y: lastY, width: btnW, height: btnH)
            } else if frame.width < btnW {
                btn.frame = CGRect(x: 0, y: lastY + marginY + btnH, width: frame.width, height: btnH)
            }else {
                btn.frame = CGRect(x: 0, y: lastY + marginY + btnH, width: btnW, height: btnH)
            }
            
            lastX = btn.frame.maxX + marginX
            lastY = btn.frame.origin.y
            searchViewHeight = btn.frame.maxY
            addSubview(btn)
        }
        self.btnCallBackBlock = btnCallBackBlock
    }
    
    @objc func btnClick(sender: UIButton) {
        // 点击热门搜索视图的按钮会发生四件事: 1.将按钮文字显示到搜索框 2.将按钮文字写入到偏好设置 3.在历史记录中显示按钮 4.更新清空历史按钮的状态
        btnCallBackBlock?(sender)
    }
    
    @objc func deleteBtnClick(sender: UIButton) {
        deleteBtnCallBackBlock?(sender)
    }
    
}

/*
 这个类分为上面的标题文字和下面的按钮.按钮的数量是不确定的,在将按钮添加到SearchView之前先记录下这个按钮的maxX加上横向间距的值和y值,在布局下一个按钮的时候先判断这一行余下的距离是否大于这个按钮的宽度,也就是SearchView视图的宽度减去上一个按钮的maxX加上横向间距的值是否大于这个按钮的宽度.如果大于就是说剩下的距离可以放下这个按钮,那么这个按钮的x值就是上一个按钮的maxX加上横向间距,y值与上一个按钮相同;如果小于就是说剩下的距离放不下这个按钮,那么就将这个按钮放到下一行,这个按钮的x值就是0,y值就是上一个按钮的y值加上纵向间距和按钮的高度.整个SearchView视图的高度是最后一个按钮的maxY.
 ---------------------
 */
