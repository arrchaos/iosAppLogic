//
//  WebView.swift
//  WidgetX
//
//  Created by Илья on 24.03.2023.
//

import SwiftUI

public struct WWebView: View {
    
    @StateObject var webViewModel: WWebViewModel
    
    public init(_ webViewModel: WWebViewModel) {
        _webViewModel = StateObject(wrappedValue: webViewModel)
    }
    
    public var body: some View {
        LoadingView(isShowing: self.$webViewModel.loading) {
            WebView(webViewModel: self.webViewModel)
        }
    }
}

//struct WWebView_Previews: PreviewProvider {
//    static var previews: some View {
//        WWebView()
//    }
//}
