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
    
    /// 읽고 있는 책 조회 API
    case getReadingBooks
    
    /// 읽고 싶은 책 조회 API
    case getWantToReadBooks
    
    /// 다 읽은 책 조회 API
    case getFinishReadBooks
}

extension HomeService: TargetType {
    var method: HTTPMethod {
        switch self {
        case .getHome, .getReadingBooks, .getWantToReadBooks, .getFinishReadBooks:
            return .get
        }
    }
    
    var endPoint: String {
        switch self {
        case .getHome:
            return APIConstants.homeURL
            
        case .getReadingBooks:
            return APIConstants.readingURL
            
        case .getWantToReadBooks:
            return APIConstants.wantToReadURL
            
        case .getFinishReadBooks:
            return APIConstants.finishedReadingURL
        }
    }
    
    var parameters: RequestParams {
        switch self {
        case .getHome, .getReadingBooks, .getWantToReadBooks, .getFinishReadBooks:
            return .requestPlain
        }
    }
}
