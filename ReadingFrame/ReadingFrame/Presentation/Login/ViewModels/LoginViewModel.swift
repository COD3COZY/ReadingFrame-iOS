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

    /// 백엔드가 404 로 내려주는 메시지 분기
    /// - "해당 사용자가 존재하지 않습니다." → 미가입(회원가입 필요)
    /// - "ID 토큰이 유효하지 않습니다." → 인증 실패
    private enum ServerMessage {
        static let userNotFound = "해당 사용자가 존재하지 않습니다."
        static let invalidIdToken = "ID 토큰이 유효하지 않습니다."
    }

    /// 소셜 로그인 응답 → SocialLoginResult 매핑
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
            let msg = (message as? String) ?? "\(message)"
            print("Request Err: \(msg)")
            switch msg {
            case ServerMessage.userNotFound:
                return .needsSignUp
            case ServerMessage.invalidIdToken:
                return .failure(msg)
            default:
                return .failure(msg)
            }
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
