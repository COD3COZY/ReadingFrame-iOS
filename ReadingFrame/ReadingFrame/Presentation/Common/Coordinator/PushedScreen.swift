//
//  PushedScreen.swift
//  ReadingFrame
//
//  Created by 석민솔 on 2026/04/14.
//

import SwiftUI

/// push된 화면 공통 modifier
/// - back 텍스트 숨김(.editor)
/// - 탭바 숨김
private struct PushedScreenModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .toolbarRole(.editor)
            .toolbar(.hidden, for: .tabBar)
    }
}

extension View {
    func pushedScreen() -> some View {
        modifier(PushedScreenModifier())
    }
}
