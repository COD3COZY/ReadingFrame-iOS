//
//  NicknameValidateService.swift
//  ReadingFrame
//
//  Created by 이윤지 on 9/24/24.
//

import Foundation
import Alamofire

/// 닉네임 중복검사 Router
enum NicknameValidateService {
    /// 닉네임 중복검사 API
    case validateNickname(String)
}

extension NicknameValidateService: TargetType {
    var method: HTTPMethod {
        switch self {
        case .validateNickname:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .validateNickname:
            return APIConstants.validateNicknameURL
        }
    }
    
    var parameters: RequestParams {
        switch self {
        case .validateNickname(let path):
            return .path(path)
        }
    }
}
