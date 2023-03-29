//
//  WebViewDelegate.swift
//  WidgetX
//
//  Created by Илья on 27.03.2023.
//

import Foundation
import WebKit

class WebViewCoordinator: NSObject, WKUIDelegate, WKNavigationDelegate {
    var parent: WebView
    
    init(parent: WebView) {
        self.parent = parent
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        //load cookie of current domain
        webView.loadDiskCookies(for: self.parent.webViewModel.endURL().host!){
            decisionHandler(.allow)
        }
    }
    
    public func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        //write cookie for current domain
        webView.writeDiskCookies(for: self.parent.webViewModel.endURL().host!){
            decisionHandler(.allow)
        }
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        self.parent.webViewModel.loading = true
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.parent.webViewModel.loading = false
    }
    
}
