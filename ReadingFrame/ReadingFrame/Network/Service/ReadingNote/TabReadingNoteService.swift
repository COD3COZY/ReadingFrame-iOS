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
    /// 메모 전체조회 API
    case fetchAllMemo(String)
}

extension TabReadingNoteService: TargetType {
    var method: HTTPMethod {
        switch self {
        case .fetchAllBookmark:
            return .get
        case .fetchAllMemo:
            return .get
        }
    }
    
    var endPoint: String {
        switch self {
        case .fetchAllBookmark, .fetchAllMemo:
            return APIConstants.bookCommonURL
        }
    }
    
    var parameters: RequestParams {
        switch self {
        case .fetchAllBookmark(let isbn):
            return .path(isbn + "/bookmark")
        case .fetchAllMemo(let isbn):
            return .path(isbn + "/memo")
        }
    }
}
