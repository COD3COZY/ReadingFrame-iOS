//
//  KakaoLoginService.swift
//  ReadingFrame
//
//  Created by 이윤지 on 8/21/24.
//

import Foundation
import Alamofire

/// 로그인 Router
enum LoginService {
    // 카카오 로그인 API
    case loginKakao(KakaoLoginRequest)
    
    // 애플 로그인 API
    case loginApple(AppleLoginRequest)
}

extension LoginService: TargetType {
    var method: HTTPMethod {
        switch self {
        case .loginKakao:
            return .post
        case .loginApple:
            return .post
        }
    }
    
    var endPoint: String {
        switch self {
        case .loginKakao:
            return APIConstants.loginKakaoURL
        case .loginApple:
            return APIConstants.loginAppleURL
        }
    }
    
    var parameters: RequestParams {
        switch self {
        case .loginKakao(let request):
            return .requestBody(request)
        case .loginApple(let request):
            return .requestBody(request)
        }
    }
}
