//
//  ContentView.swift
//  ReadingFrame
//
//  Created by 석민솔 on 4/18/26.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var loginManager: LoginManager

    var body: some View {
        Group {
            if loginManager.isLoggedIn {
                AppTabView()
            } else {
                LoginRootView()
            }
        }
        .animation(.easeInOut(duration: 0.3), value: loginManager.isLoggedIn)
        .alert("로그인이 해제되었습니다", isPresented: $loginManager.showUnauthorizedAlert) {
            Button("확인") { loginManager.confirmUnauthorized() }
        } message: {
            Text("다시 로그인해주세요.")
        }
    }
}
