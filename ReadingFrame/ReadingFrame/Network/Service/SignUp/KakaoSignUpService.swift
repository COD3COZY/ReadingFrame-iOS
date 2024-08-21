//
//  KakaoSignUpService.swift
//  ReadingFrame
//
//  Created by 이윤지 on 8/20/24.
//

import Foundation
import Alamofire

/// 카카오 회원가입 Router
enum KakaoSignUpService {
    // 카카오 회원가입 API
    case signUpKakako(KakaoSignUpRequest)
}

extension KakaoSignUpService: TargetType {
    var method: HTTPMethod {
        switch self {
        case .signUpKakako:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .signUpKakako:
            return APIConstants.signUpKakaoURL
        }
    }
    
    var parameters: RequestParams {
        switch self {
        case .signUpKakako(let request):
            return .body(request)
        }
    }
}
