//
//  BookInfoAPI.swift
//  ReadingFrame
//
//  Created by 석민솔 on 5/3/25.
//

import Foundation

/// 도서정보 화면 API
class BookInfoAPI: BaseAPI {
    static let shared = BookInfoAPI()
    
    private override init() {
        super.init()
    }
    
    /// 책장 기본 조회
    func getBookInfo(isbn: String, completion: @escaping (NetworkResult<Any>) -> (Void)) {
        AFManager.request(BookInfoService.getBookInfo(isbn), interceptor: MyRequestInterceptor()).responseData { (response) in
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
                completion(self.judgeData(by: statusCode, data, BookInfoResponse.self))
            case .failure(let err):
                completion(.networkFail(err.localizedDescription))
            }
        }
    }
    
    /// 책등록
    func postRegisterBook(isbn: String, request: RegisterBookRequest, completion: @escaping (NetworkResult<Any>) -> (Void)) {
        AFManager.request(BookInfoService.postRegisterBook(isbn, request), interceptor: MyRequestInterceptor()).responseData { (response) in
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
    
    /// 읽고싶은 책 등록
    func postWantToRead(isbn: String, request: WantToReadRegisterRequest, completion: @escaping (NetworkResult<Any>) -> (Void)) {
        AFManager.request(BookInfoService.postWantToRead(isbn, request), interceptor: MyRequestInterceptor()).responseData { (response) in
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
    
    /// 읽고싶은 책 취소
    func cancelWantToRead(isbn: String, request: ChangeReadingStatusRequest, completion: @escaping (NetworkResult<Any>) -> (Void)) {
        AFManager.request(BookInfoService.cancelWantToRead(isbn, request), interceptor: MyRequestInterceptor()).responseData { (response) in
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
