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
}

extension BookInfoService: TargetType {
    var method: HTTPMethod {
        switch self {
        case .getBookInfo:
            return .get
        case .postRegisterBook:
            return .post
        }
    }
    
    var endPoint: String {
        switch self {
        case .getBookInfo:
            return APIConstants.bookCommonURL
        case .postRegisterBook:
            return APIConstants.bookCommonURL
        }
    }
    
    var parameters: RequestParams {
        switch self {
        case .getBookInfo(let isbn):
            return .path(isbn + "/info")
        case .postRegisterBook(let isbn, let request):
            return .pathBody(isbn, body: request)
        }
    }
}
