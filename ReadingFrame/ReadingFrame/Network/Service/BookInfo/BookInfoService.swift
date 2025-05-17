//
//  BookInfoService.swift
//  ReadingFrame
//
//  Created by 석민솔 on 5/3/25.
//

import Foundation
import Alamofire

/// 도서정보 화면 Router
enum BookInfoService {
    /// 도서정보 초기조회 API
    case getBookInfo(String)
    /// 책등록 API
    case postRegisterBook(String, RegisterBookRequest)
    /// 읽고싶은 책 등록 API
    case postWantToRead(String, WantToReadRegisterRequest)
    /// 읽고싶은 책 취소 API
    case cancelWantToRead(String, ChangeReadingStatusRequest)
}

extension BookInfoService: TargetType {
    var method: HTTPMethod {
        switch self {
        case .getBookInfo:
            return .get
        case .postRegisterBook:
            return .post
        case .postWantToRead:
            return .post
        case .cancelWantToRead:
            return .patch
        }
    }
    
    var endPoint: String {
        switch self {
        case .getBookInfo:
            return APIConstants.bookCommonURL
        case .postRegisterBook:
            return APIConstants.bookCommonURL
        case .postWantToRead:
            return APIConstants.bookCommonURL
        case .cancelWantToRead:
            return APIConstants.bookCommonURL
        }
    }
    
    var parameters: RequestParams {
        switch self {
        case .getBookInfo(let isbn):
            return .path(isbn + "/info")
        case .postRegisterBook(let isbn, let request):
            return .pathBody(isbn, body: request)
        case .postWantToRead(let isbn, let request):
            return .pathBody(isbn + "/want-to-read", body: request)
        case .cancelWantToRead(let isbn, let request):
            return .pathBody(isbn + "/reading-status", body: request)
        }
    }
}
