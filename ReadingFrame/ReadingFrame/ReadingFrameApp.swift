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
    
    init() {
        KakaoSDK.initSDK(appKey: Bundle.main.object(forInfoDictionaryKey: "KAKAO_APP_KEY") as! String)
    }
    
    var body: some Scene {
        WindowGroup {
            LaunchView()
                .onOpenURL { url in
                    if (AuthApi.isKakaoTalkLoginUrl(url)) {
                        _ = AuthController.handleOpenUrl(url: url)
                    }
                }
        }
    }
}
