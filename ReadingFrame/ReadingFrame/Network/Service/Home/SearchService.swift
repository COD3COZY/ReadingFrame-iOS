//
//  SearchService.swift
//  ReadingFrame
//
//  Created by 이윤지 on 12/22/24.
//

import Foundation
import Alamofire

/// 검색 화면 Router
enum SearchService {
    /// 검색 API
    case searchBooks(String)
}

extension SearchService: TargetType {
    var method: HTTPMethod {
        return .get
    }
    
    var endPoint: String {
        return APIConstants.searchURL
    }
    
    var parameters: RequestParams {
        switch self {
        case .searchBooks(let searchText):
            return .path(searchText)
        }
    }
}
