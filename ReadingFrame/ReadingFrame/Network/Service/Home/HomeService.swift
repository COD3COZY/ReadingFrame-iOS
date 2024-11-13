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
    
    /// 책 삭제 API
    case deleteBook(String)
    
    /// 읽고 있는 책 숨기기&꺼내기 API
    case hiddenReadBook(String, HiddenReadBookRequest)
    
    /// 독서 상태 변경 API
    case changeReadingStatus(String, ChangeReadingStatusRequest)
    
    /// 소장 여부 변경 API
    case changeIsMine(String, ChangeIsMineRequest)
}

extension HomeService: TargetType {
    var method: HTTPMethod {
        switch self {
        case .getHome, .getReadingBooks, .getWantToReadBooks, .getFinishReadBooks:
            return .get
        case .deleteBook:
            return .delete
        case .hiddenReadBook, .changeReadingStatus, .changeIsMine:
            return .patch
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
            
        case .deleteBook:
            return APIConstants.deleteBookURL
            
        case .hiddenReadBook:
            return APIConstants.hiddenReadBookURL
            
        case .changeReadingStatus:
            return APIConstants.changeReadingStatusURL
        
        case .changeIsMine:
            return APIConstants.changeIsMineURL
        }
    }
    
    var parameters: RequestParams {
        switch self {
        case .getHome, .getReadingBooks, .getWantToReadBooks, .getFinishReadBooks:
            return .requestPlain
        case .deleteBook(let isbn):
            return .path(isbn)
        case .hiddenReadBook(let isbn, let request):
            return .pathBody(isbn, body: request)
        case .changeReadingStatus(let isbn, let request):
            return .pathBody(isbn, body: request)
        case .changeIsMine(let isbn, let request):
            return .pathBody(isbn, body: request)
        }
    }
}
