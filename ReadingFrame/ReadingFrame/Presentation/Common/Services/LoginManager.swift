//
//  LoginManager.swift
//  ReadingFrame
//
//  Created by 석민솔 on 4/18/26.
//

import Foundation
import KakaoSDKUser

final class LoginManager: ObservableObject {
    static let shared = LoginManager()
    private init() {}

    @Published private(set) var isLoggedIn: Bool = KeyChainService.shared.getToken() != nil
    @Published var showUnauthorizedAlert: Bool = false

    // MARK: - Login Success

    func handleLoginSuccess(token: String) {
        _ = KeyChainService.shared.addToken(token: token)
        DispatchQueue.main.async { self.isLoggedIn = true }
    }

    // MARK: - 401 Handling

    func handleUnauthorized() {
        _ = KeyChainService.shared.deleteToken()
        DispatchQueue.main.async {
            guard !self.showUnauthorizedAlert else { return }
            self.showUnauthorizedAlert = true
        }
    }

    func confirmUnauthorized() {
        showUnauthorizedAlert = false
        isLoggedIn = false
    }

    // MARK: - Logout

    func logout() {
        switch detectedLoginType {
        case .kakao: deleteKakaoData()
        case .apple: deleteAppleData()
        case nil: break
        }
        _ = KeyChainService.shared.deleteToken()
        UserDefaults.standard.removeObject(forKey: "ThemeColor")
        DispatchQueue.main.async { self.isLoggedIn = false }
    }

    // MARK: - Private

    private enum SocialLoginType { case kakao, apple }

    private var detectedLoginType: SocialLoginType? {
        if KeyChainService.shared.getKeychainItem(key: .kakaoEmail) != nil { return .kakao }
        if KeyChainService.shared.getKeychainItem(key: .appleUserID) != nil { return .apple }
        return nil
    }

    private func deleteKakaoData() {
        UserApi.shared.logout { _ in }
        _ = KeyChainService.shared.deleteKeychainItem(key: .kakaoEmail)
        _ = KeyChainService.shared.deleteKeychainItem(key: .kakaoNickname)
    }

    private func deleteAppleData() {
        _ = KeyChainService.shared.deleteKeychainItem(key: .appleUserID)
        _ = KeyChainService.shared.deleteKeychainItem(key: .appleIDToken)
        _ = KeyChainService.shared.deleteKeychainItem(key: .appleNickname)
    }
}
