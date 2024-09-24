//
//  KakaoLoginService.swift
//  ReadingFrame
//
//  Created by 이윤지 on 8/21/24.
//

import Foundation
import Alamofire

/// 카카오 로그인 Router
enum KakaoLoginService {
    // 카카오 로그인 API
    case loginKakao(KakaoLoginRequest)
}

extension KakaoLoginService: TargetType {
    var method: HTTPMethod {
        switch self {
        case .loginKakao:
            return .post
        }
    }
    
    var path: String {
        switch self {
        case .loginKakao:
            return APIConstants.loginKakaoURL
        }
    }
    
    var parameters: RequestParams {
        switch self {
        case .loginKakao(let request):
            return .requestBody(request)
        }
    }
}
