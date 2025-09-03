//
//  EditAllRecordAPI.swift
//  ReadingFrame
//
//  Created by 석민솔 on 3/17/25.
//

import Foundation

class EditAllRecordAPI: BaseAPI {
    static let shared = EditAllRecordAPI()
    
    private override init() {
        super.init()
    }
    
    // MARK: 책갈피
    /// 책갈피 등록 API
    func postNewBookmark(isbn: String, request: PostNewBookmarkRequest, completion: @escaping (NetworkResult<Any>) -> (Void)) {
        AFManager.request(EditAllRecordService.postNewBookmark(isbn, request), interceptor: MyRequestInterceptor()).responseData { (response) in
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
    
    /// 책갈피 수정 API
    func patchBookmark(isbn: String, request: PatchBookmarkRequest, completion: @escaping (NetworkResult<Any>) -> (Void)) {
        AFManager.request(EditAllRecordService.patchBookmark(isbn, request), interceptor: MyRequestInterceptor()).responseData { (response) in
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
    
    // MARK: 메모
    func postNewMemo(isbn: String, request: EditAllRecordMemoRequest, completion: @escaping (NetworkResult<Any>) -> (Void)) {
        AFManager.request(EditAllRecordService.postNewMemo(isbn, request), interceptor: MyRequestInterceptor()).responseData { (response) in
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
    
    /// 메모 수정 API
    func patchMemo(isbn: String, request: EditAllRecordMemoRequest, completion: @escaping (NetworkResult<Any>) -> (Void)) {
        AFManager.request(EditAllRecordService.patchMemo(isbn, request), interceptor: MyRequestInterceptor()).responseData { (response) in
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
    
    // MARK: 인물사전
    func postNewCharacter(isbn: String, request: EditAllRecordCharacterRequest, completion: @escaping (NetworkResult<Any>) -> (Void)) {
        AFManager.request(EditAllRecordService.postNewCharacter(isbn, request), interceptor: MyRequestInterceptor()).responseData { (response) in
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
}
