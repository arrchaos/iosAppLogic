//
//  LoadingView.swift
//  WidgetX
//
//  Created by Илья on 27.03.2023.
//

import SwiftUI

public struct LoadingView<Content>: View where Content: View {
    @Binding var isShowing: Bool
    var content: () -> Content
    
    public var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {
                self.content()
                    .disabled(self.isShowing)
                    .blur(radius: self.isShowing ? 3 : 0)
                
                VStack {
                    ActivityIndicatorView(isAnimating: .constant(true), style: .medium)
                }
                .opacity(self.isShowing ? 1 : 0)
                
            }
        }
    }
}

