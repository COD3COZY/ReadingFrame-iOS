//
//  EditAllRecordService.swift
//  ReadingFrame
//
//  Created by 석민솔 on 3/17/25.
//

import Foundation
import Alamofire

/// 독서기록 관련 API들을 위한 Router
enum EditAllRecordService {
    /// 책갈피 등록 API
    case postNewBookmark(String, PostNewBookmarkRequest)
}

extension EditAllRecordService: TargetType {
    var method: HTTPMethod {
        switch self {
        case .postNewBookmark:
            return .post
        }
    }
    
    var endPoint: String {
        switch self {
        case .postNewBookmark:
            return APIConstants.bookCommonURL
        }
    }
    
    var parameters: RequestParams {
        switch self {
        case .postNewBookmark(let isbn, let request):
            return .pathBody(isbn + "/bookmark", body: request)
        }
    }
}
