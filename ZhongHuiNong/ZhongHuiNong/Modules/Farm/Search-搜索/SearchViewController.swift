//
//  SearchViewController.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/2/14.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit

let HistorySearch = "HistorySearch"

class SearchViewController: ViewController {

    // MARK: - Property
    var hotView: SearchHotView!
    var historyView: SearchHotView!
    var isTab = false  // 是否添加过tab
    var isEmpty = false
    
    var goodsList: [GoodsInfo] = [] {
        didSet {
            
            if goodsList.count == 0 {
                sectionView.titleLab.text = ""
                view.addSubview(emptyView)
            }else {
                
                if isEmpty {
                    debugPrints("刷新数据的时候---有占位符号")
                    emptyView.removeFromSuperview()
                }
                
                sectionView.titleLab.text = "共\(goodsList.count)件商品"
                
                DispatchQueue.main.async {
                    
                    // 2. 隐藏scrollView
                    self.scrollView.isHidden = true
                    
                    // 3. 刷新tab
                    if self.isTab {
                        self.tableView.isHidden = false
                    }else {
                        self.view.addSubview(self.tableView)
                        self.isTab = true
                    }
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        HudHelper.hideHUD()
    }
    
    override func makeUI() {
        super.makeUI()
        view.backgroundColor = Color.backdropColor
        
        navigationItem.titleView = searchView
        view.addSubview(scrollView)
        bringLayertoFront()
        setupHotView()
        setupHistoryView()
        
        // 监听tf的变化
        searchView.textField.rx.controlEvent(UIControl.Event.editingChanged).subscribe { [weak self] (_) in
            guard let weakSelf = self else { return }
            let text = weakSelf.searchView.textField.text
                if text == "" {
                
                }
            }.disposed(by: rx.disposeBag)
    }

    // MARK: - Lazy
    
    var emptyView = SearchEmptyView.loadView()
    lazy var sectionView = CartSectionHeaderView.loadOtherView()
    
    lazy var searchView: SearchView = {
        let view = SearchView(frame: CGRect(x: 0, y: 0, width: kScreenW - 120, height: 34))
        view.backgroundColor = UIColor.hexColor(0xEFEFEF)
        view.cuttingCorner(radius: 17)
        view.textField.delegate = self
        return view
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: kNavBarH, width: kScreenW, height: kScreenH-kNavBarH))
        scrollView.alwaysBounceVertical = true
        scrollView.backgroundColor = UIColor.white
        scrollView.delegate = self
        return scrollView
    }()

    lazy var tableView: UITableView = {
        let tab = UITableView(frame: CGRect(x: 0, y: kNavBarH, width: kScreenW, height: kScreenH-kNavBarH), style: .plain)
        tab.backgroundColor = UIColor.white
        tab.separatorStyle = .none
        tab.estimatedRowHeight = 0
        tab.estimatedSectionHeaderHeight = 0
        tab.estimatedSectionFooterHeight = 0
        tab.tableFooterView = UIView()
        tab.dataSource = self
        tab.delegate = self
        tab.register(SearchGoodsTabCell.self, forCellReuseIdentifier: SearchGoodsTabCell.identifier)
        return tab
    }()
    
    // MARK: - Public methods
    
    func bringLayertoFront() {
        extendedLayoutIncludesOpaqueBars = true
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        }else {
            automaticallyAdjustsScrollViewInsets = false
        }
    }
    
    func setupHotView() {
        
        //如果偏好设置为空写入一个空数组
        var historySearch = UserDefaults.standard.object(forKey: HistorySearch) as? [String]
        if historySearch == nil {
            historySearch = [String]()
            UserDefaults.standard.set(historySearch, forKey: HistorySearch)
        }
        
        //标签的标题 可以从服务器获得
        let arr = ["牛排", "土家鸡蛋", "精牛肉", "手工豆腐", "无常大米", "火锅料", "皇帝蕉", "麦趣尔牛奶"]
        hotView = SearchHotView(frame: CGRect(x: 10, y:33, width: kScreenW - 20, height: 100), titleLabelText: "热门搜索", btnTexts: arr, btnCallBackBlock: { [weak self](btn) in
            guard let weakSelf = self else { return }
            let str = btn.title(for: .normal)
            weakSelf.searchView.textField.text = str
            
            guard let text = str else { return }
            weakSelf.reloadSearchData(text: text)
        })
        
        hotView?.bounds.size.height = (hotView?.searchViewHeight)!
        scrollView.addSubview(hotView!)
        debugPrints("热门的高度---\(hotView.frame)")
    }
    
    func setupHistoryView() {

        //从偏好设置中读取
        let arr = UserDefaults.standard.object(forKey: HistorySearch) as! [String]
        
        guard arr.count > 0 else { return }
        
        historyView = SearchHotView(frame: CGRect(x: 10, y: hotView!.frame.maxY + 20, width: kScreenW - 20, height: 100), titleLabelText: "历史记录", isHot: true, btnTexts: arr, btnCallBackBlock: { [weak self](btn) in
            guard let weakSelf = self else { return }
            let str = btn.title(for: .normal)
            weakSelf.searchView.textField.text = str
            
            guard let text = str else { return }
            weakSelf.reloadSearchData(text: text)
        })
        debugPrints("历史的高度---\((historyView?.searchViewHeight)!)")
        historyView?.bounds.size.height = (historyView?.searchViewHeight)!
        
        historyView.deleteBtn.rx.tap.subscribe(onNext: { [weak self] in
            debugPrints("点击清除历史i记录---0.0")
            self?.cleanHistory()
        }).disposed(by: rx.disposeBag)
        
        scrollView.addSubview(historyView!)
    }
}


// MARK: - UITableViewDataSource
extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goodsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchGoodsTabCell.identifier, for: indexPath) as! SearchGoodsTabCell
        cell.goodsInfo = goodsList[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let goodId = goodsList[indexPath.row].id
        debugPrints("点击搜索商品的id---\(goodId)")
        self.navigator.show(segue: .goodsDetail(id: goodId), sender: self)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return sectionView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 38
    }
    
}

// MARK: - UIScrollViewDelegate
extension SearchViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.searchView.textField.resignFirstResponder()
    }
    
}


// MARK: - UITextFieldDelegate
extension SearchViewController: UITextFieldDelegate {
    
    /// 点击键盘的搜索按钮
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.text!.count > 0 {
            reloadSearchData(text: textField.text!) // 1. 将搜索框文字写入到偏好设置
        }
        return true
    }
    
    /// 点击输入框的清除按钮
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        showHirstory()
        return true
    }
    
    /// tab 隐藏切换
    func showHirstory() {
        self.emptyView.isHidden = true
        tableView.isHidden = true
        scrollView.isHidden = false
    }

    /// 网络搜索请求
    func reloadSearchData(text: String) {
        
        self.searchView.textField.resignFirstResponder()
        
        if text == "" {
            isEmpty = true
            view.addSubview(emptyView)
        }else {

            // 1. 获取搜索的数据
            fetchSearchGoodsInfo(text)
            
            // 2. 将搜索框文字写入到偏好设置
            self.writeHistorySearchToUserDefaults(str: text)
        }
       
    }
    
    
    func fetchSearchGoodsInfo(_ key: String) {
        
        var params = [String: Any]()
        params["category_id"] = 0 // 所有商品
        params["keywords"] = key
        params["page_size"] = 50
        params["page_index"] = 1
        params["wid"] = wid

        HudHelper.showWaittingHUD(msg: "搜索中...")
        WebAPITool.requestModelArrayWithData(WebAPI.goodsList(params), model: GoodsInfo.self, complete: { (list) in
            HudHelper.hideHUD()
            self.goodsList = list
        }) { (error) in
            HudHelper.hideHUD()
            self.goodsList = []
        }
        
    }
    
    
    /// 将历史搜索写入偏好设置
    func writeHistorySearchToUserDefaults(str: String) {
        //从偏好设置中读取
        var historySearch = UserDefaults.standard.object(forKey: HistorySearch) as? [String]
        //如果已经存在就不重复写入
        for text in historySearch! {
            if text == str {
                return
            }
        }
        
        historySearch!.append(str)
        UserDefaults.standard.set(historySearch, forKey: HistorySearch)
        setupHistoryView()
    }
    
    @objc func cleanHistory() {
        var historys = UserDefaults.standard.object(forKey: HistorySearch) as? [String]
        historys?.removeAll()
        UserDefaults.standard.set(historys, forKey: HistorySearch)

        if historyView != nil {
            historyView?.removeFromSuperview()
            historyView = nil
        }
    }
    
    @objc func cancelAction() {
        self.searchView.textField.resignFirstResponder()
        self.dismiss(animated: false, completion: nil)
    }
}
