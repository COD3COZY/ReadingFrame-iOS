//
//  BookshelfAPI.swift
//  ReadingFrame
//
//  Created by 석민솔 on 3/22/25.
//

import Foundation

/// 홈 화면 API
class BookshelfAPI: BaseAPI {
    static let shared = BookshelfAPI()
    
    private override init() {
        super.init()
    }
    
    /// 책장 기본 조회
    func getBookshelf(type: String, completion: @escaping (NetworkResult<Any>) -> (Void)) {
        AFManager.request(BookshelfService.getBookshelf(type), interceptor: MyRequestInterceptor()).responseData { (response) in
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
                completion(self.judgeData(by: statusCode, data, [BookshelfCategoryResponse].self))
            case .failure(let err):
                completion(.networkFail(err.localizedDescription))
            }
        }
    }
}
