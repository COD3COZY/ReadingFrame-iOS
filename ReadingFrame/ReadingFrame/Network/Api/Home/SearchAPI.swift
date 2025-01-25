//
//  SearchAPI.swift
//  ReadingFrame
//
//  Created by 이윤지 on 12/22/24.
//

import Foundation
import Alamofire

/// 검색 화면 API
class SearchAPI: BaseAPI {
    static let shared = SearchAPI()
    
    private override init() {
        super.init()
    }
    
    /// 책 검색
    func searchBooks(searchText: String, completion: @escaping (NetworkResult<Any>) -> (Void)) {
        AFManager.request(SearchService.searchBooks(searchText), interceptor: MyRequestInterceptor()).responseData { (response) in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode
                else {
                    return
                }
                guard let data = response.data
                else {
                    return
                }
                completion(self.judgeData(by: statusCode, data, SearchResponse.self))
            case .failure(let err):
                completion(.networkFail(err.localizedDescription))
            }
        }
    }
}
