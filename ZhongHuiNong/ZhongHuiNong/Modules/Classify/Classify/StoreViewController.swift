//
//  StoreViewController.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/1/31.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

/// 商店
class StoreViewController: ViewController {

    var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func makeUI() {
        super.makeUI()
        view.backgroundColor = UIColor.white
        navigationItem.leftBarButtonItem = leftBarItem
        navigationItem.rightBarButtonItem = rightMsgItem
        navigationItem.titleView = searchView
        view.addSubview(leftTableView)
        view.addSubview(rightTableView)
        leftTableView.selectRow(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .none)
    }
    
    override func bindViewModel() {
        super.bindViewModel()
    }

    // MARK: - Lazy
    
    lazy var leftArray = ["store_qianggou_h","store_jingpin","store_shuiguo","store_danlei",
                          "store_liangyou","store_rupin","store_tiaowei","store_gaodian","store_renquan"]
    
    lazy var rightMsgItem = BarButtonItem(image: UIImage(named: "farm_message"), target: self, action: #selector(messageAction))
    
    lazy var leftBarItem = BarButtonItem.leftBarView()
    lazy var searchView = MemberSearchView.loadView()
    
    //左侧表格
    lazy var leftTableView : UITableView = {
        let leftTableView = UITableView()
        leftTableView.delegate = self
        leftTableView.dataSource = self
        leftTableView.frame = CGRect(x: 0, y: kNavBarH + 10, width: 88, height: UIScreen.main.bounds.height-kNavBarH-kTabBarH)
        leftTableView.rowHeight = 55
        leftTableView.showsVerticalScrollIndicator = false
        leftTableView.separatorColor = UIColor.clear
        leftTableView.backgroundColor = UIColor.white
        leftTableView.register(StoreLeftCell.self, forCellReuseIdentifier: StoreLeftCell.identifier)
        return leftTableView
    }()
    
    //右侧表格
    lazy var rightTableView : UITableView = {
        let rightTableView = UITableView()
        rightTableView.delegate = self
        rightTableView.dataSource = self
        rightTableView.frame = CGRect(x: 88, y: kNavBarH+10, width: UIScreen.main.bounds.width - 88, height: UIScreen.main.bounds.height-kNavBarH-kTabBarH-10)
        rightTableView.rowHeight = 80
        rightTableView.showsVerticalScrollIndicator = false
        rightTableView.separatorColor = UIColor.clear
        rightTableView.backgroundColor = UIColor.white
        rightTableView.register(StoreRightCell.self, forCellReuseIdentifier: StoreRightCell.identifier)
        return rightTableView
    }()
    
    // MAKR: - Action
    @objc func messageAction() {
        
    }
    
}

extension StoreViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if leftTableView == tableView {
            return leftArray.count
        } else {
            return 8
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            if leftTableView == tableView {
                let cell = tableView.dequeueReusableCell(withIdentifier: StoreLeftCell.identifier, for: indexPath) as! StoreLeftCell
                cell.ImgView.image = UIImage(named: leftArray[indexPath.row])
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: StoreRightCell.identifier, for: indexPath) as! StoreRightCell
                return cell
            }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if leftTableView == tableView {
            return 88
        }
        return 110
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if leftTableView == tableView {
            
            //leftTableView.scrollToRow(at: IndexPath(row: indexPath.row, section: 0), at: .middle, animated: true)
            rightTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
            
            guard currentIndex != indexPath.row else { return }
            leftArray[currentIndex] = leftArray[currentIndex].components(separatedBy: "_h").first!
            leftArray[indexPath.row] = leftArray[indexPath.row] + "_h"
            leftTableView.reloadData()
            currentIndex = indexPath.row
        }
        
        if rightTableView == tableView {
            
            self.navigator.show(segue: .goodsDetail, sender: self)
        }
    }
}
