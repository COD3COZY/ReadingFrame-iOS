//
//  ReadingNoteService.swift
//  ReadingFrame
//
//  Created by 석민솔 on 8/6/25.
//

import Foundation
import Alamofire

/// 독서노트 관련 API들을 위한 Router
enum ReadingNoteService {
    /// 책별 독서노트 조회 API
    case getReadingNote(String)
}

extension ReadingNoteService: TargetType {
    var method: HTTPMethod {
        switch self {
        case .getReadingNote:
            return .get
        }
    }
    
    var endPoint: String {
        switch self {
        case .getReadingNote:
            return APIConstants.bookCommonURL
        }
    }
    
    var parameters: RequestParams {
        switch self {
        case .getReadingNote(let isbn):
            return .path(isbn)
        }
    }
}
