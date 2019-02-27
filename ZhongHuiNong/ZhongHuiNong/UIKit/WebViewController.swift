//
//  WebViewController.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/1/22.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit
import WebKit
import RxSwift
import RxCocoa

class WebViewController: ViewController {

    let url = BehaviorRelay<URL?>(value: nil)
    
    lazy var webView: WKWebView = {
        let web = WKWebView(frame: CGRect(x: 0, y: kNavBarH, width: kScreenW, height: kScreenH-kNavBarH))
        web.backgroundColor = UIColor.white
        web.navigationDelegate = self
        return web
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func makeUI() {
        super.makeUI()
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        url.map { $0?.absoluteString }.asObservable().bind(to: navigationItem.rx.title).disposed(by: rx.disposeBag)
    }
    
    func load(url: URL) {
        self.url.accept(url)
        webView.load(URLRequest(url: url))
    }

}

extension WebViewController: WKNavigationDelegate {
    
    // 页面开始加载时调用
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        debugPrints("页面开始加载时调用")
    }
    
    // 当内容开始返回时调用
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        debugPrints("当内容开始返回时调用")
    }
    
    // 页面加载完成之后调用
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        debugPrints("页面加载完成之后调用")
        
        navigationItem.title = webView.title
    }
    
    // 页面加载失败时调用
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        debugPrints("页面加载失败时调用")
    }
    
    // 接收到服务器跳转请求之后调用
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        debugPrints("接收到服务器跳转请求之后调用")
    }
}
