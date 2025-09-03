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
    /// 책갈피 수정 API
    case patchBookmark(String, PatchBookmarkRequest)
    /// 메모 등록 API
    case postNewMemo(String, EditAllRecordMemoRequest)
    /// 메모 수정 API
    case patchMemo(String, EditAllRecordMemoRequest)
    /// 인물사전 등록 API
    case postNewCharacter(String, EditAllRecordCharacterRequest)
}

extension EditAllRecordService: TargetType {
    var method: HTTPMethod {
        switch self {
        case .postNewBookmark, .postNewMemo, .postNewCharacter:
            return .post
        case .patchBookmark, .patchMemo:
            return .patch
        }
    }
    
    var endPoint: String {
        return APIConstants.bookCommonURL
    }
    
    var parameters: RequestParams {
        switch self {
        case .postNewBookmark(let isbn, let request):
            return .pathBody(isbn + "/bookmark", body: request)
        case .patchBookmark(let isbn, let request):
            return .pathBody(isbn + "/bookmark", body: request)
        case .postNewMemo(let isbn, let request), .patchMemo(let isbn, let request):
            return .pathBody(isbn + "/memo", body: request)
        case .postNewCharacter(let isbn, let request):
            return .pathBody(isbn + "/character-dictionary", body: request)
        }
    }
}
