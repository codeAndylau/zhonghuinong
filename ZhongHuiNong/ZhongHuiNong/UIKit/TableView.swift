//
//  TableView.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/1/22.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

class TableView: UITableView {

    init () {
        super.init(frame: CGRect(), style: .plain)
    }
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        makeUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        makeUI()
    }
    
    func makeUI() {
        separatorStyle = .none
        backgroundColor = Color.whiteColor
        rowHeight = UITableView.automaticDimension
        sectionHeaderHeight = Configs.Size.tableHeaderHeight
        estimatedRowHeight = Configs.Size.tableRowHeight
        cellLayoutMarginsFollowReadableWidth = false
        separatorInset = UIEdgeInsets(top: 0, left: inset, bottom: 0, right: 0)
        tableHeaderView = UIView()
        tableFooterView = UIView()
        keyboardDismissMode = .onDrag
    }
}
