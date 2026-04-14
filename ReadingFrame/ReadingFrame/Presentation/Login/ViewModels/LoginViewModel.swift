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
    func loginKakao(request: KakaoLoginRequest, completion: @escaping (SocialLoginResult) -> Void) {
        LoginAPI.shared.loginKakao(request: request) { response in
            completion(Self.handleSocialLoginResponse(response))
        }
    }

    /// 애플 로그인
    func loginApple(request: AppleLoginRequest, completion: @escaping (SocialLoginResult) -> Void) {
        LoginAPI.shared.loginApple(request: request) { response in
            completion(Self.handleSocialLoginResponse(response))
        }
    }

    /// 소셜 로그인 응답 → SocialLoginResult 매핑
    /// - 4xx(`requestErr`) 는 "미가입 유저" 로 간주해 회원가입 플로우로 보낸다.
    ///   (백엔드가 별도 코드/메시지로 구분한다면 여기서만 세분화하면 됨)
    private static func handleSocialLoginResponse(_ response: NetworkResult<Any>) -> SocialLoginResult {
        switch response {
        case .success(let data):
            guard let data = data as? SocialLoginResponse else {
                return .failure("응답 디코딩 실패")
            }
            if KeyChain.shared.addToken(token: data.xAuthToken) {
                return .success
            } else {
                return .failure("토큰 키체인 저장 실패")
            }
        case .requestErr(let message):
            print("Request Err: \(message)")
            return .needsSignUp
        case .pathErr:
            print("Path Err")
            return .failure("Path Err")
        case .serverErr(let message):
            let msg = "\(message)"
            print("Server Err: \(msg)")
            return .failure(msg)
        case .networkFail(let message):
            let msg = "\(message)"
            print("Network Err: \(msg)")
            return .failure(msg)
        case .unknown(let error):
            let msg = "\(error)"
            print("Unknown Err: \(msg)")
            return .failure(msg)
        }
    }
}
