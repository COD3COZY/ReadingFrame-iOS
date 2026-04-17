//
//  LoginRootView.swift
//  ReadingFrame
//
//  Created by 석민솔 on 4/18/26.
//

import SwiftUI

struct LoginRootView: View {
    @State private var showSplash = true

    var body: some View {
        if showSplash {
            LaunchView()
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        showSplash = false
                    }
                }
        } else {
            Login()
        }
    }
}
