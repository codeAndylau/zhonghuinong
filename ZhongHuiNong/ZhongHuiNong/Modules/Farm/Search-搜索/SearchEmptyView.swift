//
//  SearchEmptyView.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/14.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class SearchEmptyView: View {
    
    var imgView = ImageView().then { (img) in
        img.image = UIImage(named: "search_empty")
        img.contentMode = .scaleAspectFit
    }
    
    let titleLab = Label().then { (lab) in
        lab.text = "未搜索到相关内容试试别的吧！"
        lab.textColor = UIColor.hexColor(0x9B9B9B)
        lab.font = UIFont.systemFont(ofSize: 14)
    }

    override func makeUI() {
        super.makeUI()
        addSubview(imgView)
        addSubview(titleLab)
    }
    
    override func updateUI() {
        super.updateUI()
        
        imgView.snp.makeConstraints { (make) in
            make.top.equalTo(80)
            make.centerX.equalTo(self)
        }
        
        titleLab.snp.makeConstraints { (make) in
            make.top.equalTo(imgView.snp.bottom).offset(5)
            make.centerX.equalTo(self)
        }
    }
    
    class func loadView() -> SearchEmptyView {
        let view = SearchEmptyView(frame: CGRect(x: 0, y: kNavBarH, width: kScreenW, height: kScreenH-kNavBarH))
        return view
    }

}
