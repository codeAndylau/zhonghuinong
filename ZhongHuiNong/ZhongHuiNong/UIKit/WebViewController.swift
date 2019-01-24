//
//  WebViewController.swift
//  ZhongHuiNong
//
//  Created by Andylau on 2019/1/22.
//  Copyright © 2019 Andylau. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class WebViewController: ViewController {

    let url = BehaviorRelay<URL?>(value: nil)

    lazy var webView: UIWebView = {
        let view = UIWebView()
        view.delegate = self
        self.contentView.addSubview(view)
        view.snp.makeConstraints({ (make) in
            make.edges.equalToSuperview()
        })
        return view
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
        webView.loadRequest(URLRequest(url: url))
    }

}

extension WebViewController: UIWebViewDelegate {
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebView.NavigationType) -> Bool {
        url.accept(request.url)
        return true
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        //        startAnimating()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        //        stopAnimating()
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        //        stopAnimating()
    }
}
