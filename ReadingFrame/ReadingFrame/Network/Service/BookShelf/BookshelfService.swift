//
//  BookshelfService.swift
//  ReadingFrame
//
//  Created by 석민솔 on 3/22/25.
//

import Foundation
import Alamofire

/// 책장 화면 Router
enum BookshelfService {
    /// 책장 초기조회 API
    case getBookshelf(String)
    case getDetailBookshelf(String)
}

extension BookshelfService: TargetType {
    var method: HTTPMethod {
        switch self {
        case .getBookshelf:
            return .get
        case .getDetailBookshelf:
            return .get
        }
    }
    
    var endPoint: String {
        switch self {
        case .getBookshelf:
            return APIConstants.bookshelfCommonURL
        case .getDetailBookshelf:
            return APIConstants.bookshelfCommonURL
        }
    }
    
    var parameters: RequestParams {
        switch self {
        case .getBookshelf(let type):
            return .path(type)
        case .getDetailBookshelf(let code):
            return .path(code + "/detail")
        }
    }
}
