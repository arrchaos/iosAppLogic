//
//  WebView.swift
//  WidgetX
//
//  Created by Илья on 25.03.2023.
//

import SwiftUI
import WebKit
 
struct WebView: UIViewRepresentable {
 
    @ObservedObject var webViewModel: WWebViewModel
    
    private let webView = WKWebView()
    
    init(webViewModel: WWebViewModel) {
        self.webViewModel = webViewModel
    }
    
    
    func makeUIView(context: Context) -> WKWebView {
//        let webView = WKWebView()
        self.webView.uiDelegate = context.coordinator
        self.webView.navigationDelegate = context.coordinator
        let request = URLRequest(url: webViewModel.endURL())
        webView.load(request)
        return self.webView
        
    }
 
    func updateUIView(_ webView: WKWebView, context: Context) {
//        let request = URLRequest(url: webViewModel.endURL())
//        webView.load(request)
    }
    
    func makeCoordinator() -> WebViewCoordinator {
        return WebViewCoordinator(parent: self)
    }
}
