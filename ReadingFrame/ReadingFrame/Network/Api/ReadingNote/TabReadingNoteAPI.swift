//
//  TabReadingNoteAPI.swift
//  ReadingFrame
//
//  Created by 석민솔 on 8/16/25.
//

import Foundation

class TabReadingNoteAPI: BaseAPI {
    static let shared = TabReadingNoteAPI()
    
    private override init() {
        super.init()
    }
    
    /// 책갈피 전체조회 API
    func fetchAllBookmark(
        isbn: String,
        completion: @escaping (NetworkResult<Any>) -> (Void)
    ) {
        AFManager.request(TabReadingNoteService.fetchAllBookmark(isbn), interceptor: MyRequestInterceptor()).responseData { (response) in
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
                completion(self.judgeData(by: statusCode, data, [BookmarkTapResponse].self))
                
            case .failure(let err):
                completion(.networkFail(err.localizedDescription))
            }
        }
    }
    
    /// 책갈피 삭제 API
    func deleteBookmark(isbn: String, uuid: String, completion: @escaping (NetworkResult<Any>) -> (Void)) {
        let request = TabReadingNoteDeleteRequest(uuid: uuid)
        
        AFManager.request(TabReadingNoteService.deleteBookmark(isbn, request), interceptor: MyRequestInterceptor()).responseData { (response) in
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
                completion(self.judgeData(by: statusCode, data, String.self))
                
            case .failure(let err):
                completion(.networkFail(err.localizedDescription))
            }
        }
    }
    
    /// 메모 전체조회 API
    func fetchAllMemo(isbn: String, completion: @escaping (NetworkResult<Any>) -> (Void)) {
        AFManager.request(TabReadingNoteService.fetchAllMemo(isbn), interceptor: MyRequestInterceptor()).responseData { (response) in
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
                completion(self.judgeData(by: statusCode, data, [MemoTapResponse].self))
                
            case .failure(let err):
                completion(.networkFail(err.localizedDescription))
            }
        }
    }
    
    /// 인물사전 전체조회 API
    func fetchAllCharacter(isbn: String, completion: @escaping (NetworkResult<Any>) -> (Void)) {
        AFManager.request(TabReadingNoteService.fetchAllCharacter(isbn), interceptor: MyRequestInterceptor()).responseData { (response) in
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
                completion(self.judgeData(by: statusCode, data, [CharacterTapResponse].self))
                
            case .failure(let err):
                completion(.networkFail(err.localizedDescription))
            }
        }
    }
}
