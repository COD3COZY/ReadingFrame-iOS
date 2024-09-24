//
//  LoginViewModel.swift
//  ReadingFrame
//
//  Created by 이윤지 on 9/24/24.
//

import Foundation

/// 로그인 화면의 뷰모델
final class LoginViewModel: ObservableObject {
    /// 카카오 로그인
    func loginKakao(request: KakaoLoginRequest, completion: @escaping (Bool) -> (Void)) {
        LoginAPI.shared.loginKakao(request: request) { response in
            switch response {
            case .success(let data):
                if let data = data as? KakaoLoginResponse {
                    KeyChain.shared.addToken(token: data.xAuthToken) // KeyChain에 토큰 저장
                    completion(true)
                }
            case .requestErr(let message):
                print("Request Err: \(message)")
                completion(false)
            case .pathErr:
                print("Path Err")
                completion(false)
            case .serverErr(let message):
                print("Server Err: \(message)")
                completion(false)
            case .networkFail(let message):
                print("Network Err: \(message)")
                completion(false)
            }
        }
    }
}
