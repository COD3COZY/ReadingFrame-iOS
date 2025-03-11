//
//  LoginAPI.swift
//  ReadingFrame
//
//  Created by 이윤지 on 8/21/24.
//

import Foundation
import Alamofire

/// 카카오&애플 로그인 API
class LoginAPI: BaseAPI {
    static let shared = LoginAPI()
    
    private override init() {
        super.init()
    }
    
    /// 카카오 로그인 API
    func loginKakao(request: KakaoLoginRequest, completion: @escaping (NetworkResult<Any>) -> (Void)) {
        AFManager.request(LoginService.loginKakao(request), interceptor: MyRequestInterceptor()).responseData { (response) in
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
                completion(self.judgeData(by: statusCode, data, SocialLoginResponse.self))
            case .failure(let err):
                completion(.networkFail(err.localizedDescription))
            }
        }
    }
    
    /// 애플 로그인 API
    func loginApple(request: AppleLoginRequest, completion: @escaping (NetworkResult<Any>) -> (Void)) {
    AFManager.request(LoginService.loginApple(request), interceptor: MyRequestInterceptor()).responseData { (response) in
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
            completion(self.judgeData(by: statusCode, data, SocialLoginResponse.self))
            
        case .failure(let err):
            completion(.networkFail(err.localizedDescription))
        }
    }
}
}
