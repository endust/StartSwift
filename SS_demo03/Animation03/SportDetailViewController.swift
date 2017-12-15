//
//  SportDetailViewController.swift
//  Animation03
//
//  Created by Winn on 2017/12/11.
//  Copyright © 2017年 Winn. All rights reserved.
//

import UIKit

class SportDetailViewController: UIViewController {
    
    var detailWebView = UIWebView()
    var detailModel = SportDetailModel()

}

extension SportDetailViewController:UIWebViewDelegate {
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = detailModel.sportDetailTitle
        view.backgroundColor = UIColor.white
        
        detailWebView = UIWebView.init(frame: self.view.bounds)
        detailWebView.delegate = self
        view.addSubview(detailWebView)
        detailWebView.loadRequest(URLRequest.init(url: URL.init(string:detailModel.sportDetailURL)!))
        
    }
    //MARK: webViewDelegate
    func webViewDidStartLoad(_ webView: UIWebView) {
        view.hud.showLoading("加载中")
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        view.hud.dismiss()
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        view.hud.dismiss()
        //
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
