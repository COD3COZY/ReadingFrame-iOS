//
//  KakaoSignUpService.swift
//  ReadingFrame
//
//  Created by 이윤지 on 8/20/24.
//

import Foundation
import Alamofire

/// 회원가입 Router
enum SignUpService {
    // 카카오 회원가입 API
    case signUpKakako(KakaoSignUpRequest)
    
    // 애플 회원가입 API
}

extension SignUpService: TargetType {
    var method: HTTPMethod {
        switch self {
        case .signUpKakako:
            return .post
        }
    }
    
    var endPoint: String {
        switch self {
        case .signUpKakako:
            return APIConstants.signUpKakaoURL
        }
    }
    
    var parameters: RequestParams {
        switch self {
        case .signUpKakako(let request):
            return .requestBody(request)
        }
    }
}
