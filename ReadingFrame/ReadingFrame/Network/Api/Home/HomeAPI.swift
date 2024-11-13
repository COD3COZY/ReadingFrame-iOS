//
//  HomeAPI.swift
//  ReadingFrame
//
//  Created by 이윤지 on 10/2/24.
//

import Foundation
import Alamofire

/// 홈 화면 API
class HomeAPI: BaseAPI {
    static let shared = HomeAPI()
    
    private override init() {
        super.init()
    }
    
    /// 홈 조회
    func getHome(completion: @escaping (NetworkResult<Any>) -> (Void)) {
        AFManager.request(HomeService.getHome, interceptor: MyRequestInterceptor()).responseData { (response) in
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
                completion(self.judgeData(by: statusCode, data, HomeResponse.self))
            case .failure(let err):
                completion(.networkFail(err.localizedDescription))
            }
        }
    }
    
    /// 읽고 있는 책 조회
    func getReadingBooks(completion: @escaping (NetworkResult<Any>) -> (Void)) {
        AFManager.request(HomeService.getReadingBooks, interceptor: MyRequestInterceptor()).responseData { (response) in
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
                completion(self.judgeData(by: statusCode, data, [ReadingBookResponse].self))
            case .failure(let err):
                completion(.networkFail(err.localizedDescription))
            }
        }
    }
    
    /// 읽고 싶은 책 조회
    func getWantToReadBooks(completion: @escaping (NetworkResult<Any>) -> (Void)) {
        AFManager.request(HomeService.getWantToReadBooks, interceptor: MyRequestInterceptor()).responseData { (response) in
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
                completion(self.judgeData(by: statusCode, data, [WantToReadBookResponse].self))
            case .failure(let error):
                completion(.networkFail(error.localizedDescription))
            }
        }
    }
    
    /// 다 읽은 책 조회
    func getFinishReadBooks(completion: @escaping (NetworkResult<Any>) -> (Void)) {
        AFManager.request(HomeService.getWantToReadBooks, interceptor: MyRequestInterceptor()).responseData { (response) in
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
                completion(self.judgeData(by: statusCode, data, [FinishReadBookResponse].self))
            case .failure(let error):
                completion(.networkFail(error.localizedDescription))
            }
        }
    }
    
    /// 책 삭제 API
    func deleteBook(isbn: String, completion: @escaping (NetworkResult<Any>) -> (Void)) {
        AFManager.request(HomeService.deleteBook(isbn), interceptor: MyRequestInterceptor()).responseData { (response) in
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
            case .failure(let error):
                completion(.networkFail(error.localizedDescription))
            }
        }
    }
    
    /// 읽고 있는 책 숨기기&꺼내기 API
    func hiddenReadBook(isbn: String, request: HiddenReadBookRequest, completion: @escaping (NetworkResult<Any>) -> (Void)) {
        AFManager.request(HomeService.hiddenReadBook(isbn, request), interceptor: MyRequestInterceptor()).responseData { (response) in
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
            case .failure(let error):
                completion(.networkFail(error.localizedDescription))
            }
        }
    }
    
    /// 독서 상태 변경 API
    func changeReadingStatus(isbn: String, request: ChangeReadingStatusRequest, completion: @escaping (NetworkResult<Any>) -> (Void)) {
        AFManager.request(HomeService.changeReadingStatus(isbn, request), interceptor: MyRequestInterceptor()).responseData { (response) in
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
            case .failure(let error):
                completion(.networkFail(error.localizedDescription))
            }
        }
    }
    
    /// 소장 여부 변경 API
    func changeIsMine(isbn: String, request: ChangeIsMineRequest, completion: @escaping (NetworkResult<Any>) -> (Void)) {
        AFManager.request(HomeService.changeIsMine(isbn, request), interceptor: MyRequestInterceptor()).responseData { (response) in
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
            case .failure(let error):
                completion(.networkFail(error.localizedDescription))
            }
        }
    }
}
