//
//  TabReadingNoteService.swift
//  ReadingFrame
//
//  Created by 석민솔 on 8/16/25.
//

import Foundation
import Alamofire

enum TabReadingNoteService {
    /// 책갈피 전체조회 API
    case fetchAllBookmark(String)
}

extension TabReadingNoteService: TargetType {
    var method: HTTPMethod {
        switch self {
        case .fetchAllBookmark:
            return .get
        }
    }
    
    var endPoint: String {
        switch self {
        case .fetchAllBookmark:
            return APIConstants.bookCommonURL
        }
    }
    
    var parameters: RequestParams {
        switch self {
        case .fetchAllBookmark(let isbn):
            return .path(isbn + "/bookmark")
        }
    }
}
