//
//  HomeService.swift
//  ReadingFrame
//
//  Created by 이윤지 on 10/2/24.
//

import Foundation
import Alamofire

/// 홈 화면 Router
enum HomeService {
    /// 홈 조회 API
    case getHome
}

extension HomeService: TargetType {
    var method: HTTPMethod {
        switch self {
        case .getHome:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .getHome:
            return APIConstants.homeURL
        }
    }
    
    var parameters: RequestParams {
        switch self {
        case .getHome:
            return .requestPlain
        }
    }
}
