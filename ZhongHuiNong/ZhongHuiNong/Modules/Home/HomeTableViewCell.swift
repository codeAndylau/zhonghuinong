//
//  HomeTableViewCell.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/1/23.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class HomeTableViewCell: TableViewCell {

    static let resueIdentifier = "HomeTableViewCell"
    
    lazy var titleLab = Label()
    lazy var detailLab = Label()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    override func makeUI() {
        super.makeUI()
//        stackView.spacing = 0
//        stackView.distribution = .fillEqually
//        stackView.axis = .vertical
//        stackView.addArrangedSubview(detailLab)
//        stackView.addArrangedSubview(titleLab)

        contentView.addSubview(titleLab)
        contentView.addSubview(detailLab)
        detailLab.numberOfLines = 0
        
        titleLab.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self)
            make.height.equalTo(20)
        }
        
        detailLab.snp.makeConstraints { (make) in
            make.top.equalTo(titleLab.snp.bottom)
            make.left.right.bottom.equalTo(self)
        }
        
    }
    
    func bind(to model: HomePublicityEntity) {
        Driver.just(model.title).drive(titleLab.rx.text).disposed(by: rx.disposeBag)
        Driver.just(model.texts + "您好，我是一名湖北省利川市来渝工作的年轻人，今年29岁，在重庆渝中区一家上市公司做基层员工，税后工资也挺不错，但是现在申请公租房太麻烦了，可以关注一下这方面的问题吗").drive(detailLab.rx.text).disposed(by: rx.disposeBag)
    }

}
