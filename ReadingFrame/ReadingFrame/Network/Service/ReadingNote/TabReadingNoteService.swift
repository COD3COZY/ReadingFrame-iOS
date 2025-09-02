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
    /// 책갈피 삭제 API
    case deleteBookmark(String, TabReadingNoteDeleteRequest)
    /// 메모 전체조회 API
    case fetchAllMemo(String)
    /// 메모 삭제 API
    case deleteMemo(String, TabReadingNoteDeleteRequest)
    /// 인물사전 전체조회 API
    case fetchAllCharacter(String)
}

extension TabReadingNoteService: TargetType {
    var method: HTTPMethod {
        switch self {
        case .fetchAllBookmark, .fetchAllMemo, .fetchAllCharacter:
            return .get
        case .deleteBookmark, .deleteMemo:
            return .delete
        }
    }
    
    var endPoint: String {
        return APIConstants.bookCommonURL
    }
    
    var parameters: RequestParams {
        switch self {
        case .fetchAllBookmark(let isbn):
            return .path(isbn + "/bookmark")
        case .deleteBookmark(let isbn, let request):
            return .pathBody(isbn + "/bookmark", body: request)
        case .fetchAllMemo(let isbn):
            return .path(isbn + "/memo")
        case .deleteMemo(let isbn, let request):
            return .pathBody(isbn + "/memo", body: request)
        case .fetchAllCharacter(let isbn):
            return .path(isbn + "/character-dictionary")
        }
    }
}
