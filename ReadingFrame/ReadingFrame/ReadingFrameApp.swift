//
//  ReadingFrameApp.swift
//  ReadingFrame
//
//  Created by 석민솔 on 1/30/24.
//

import SwiftUI
import KakaoSDKAuth
import KakaoSDKCommon

@main
struct ReadingFrameApp: App {
    @StateObject private var loginManager = LoginManager.shared

    init() {
        KakaoSDK.initSDK(appKey: Bundle.main.object(forInfoDictionaryKey: "KAKAO_APP_KEY") as! String)
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(loginManager)
                .onOpenURL { url in
                    if AuthApi.isKakaoTalkLoginUrl(url) {
                        _ = AuthController.handleOpenUrl(url: url)
                    }
                }
        }
    }
}
