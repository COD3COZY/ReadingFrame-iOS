//
//  KakaoSignUpAPI.swift
//  ReadingFrame
//
//  Created by 이윤지 on 8/20/24.
//

import Foundation
import Alamofire

/// 카카오&애플 회원가입 API
class SignUpAPI: BaseAPI {
    static let shared = SignUpAPI()
    
    private override init() {
        super.init()
    }
    
    /// 카카오 회원가입 API
    func signUpKakao(request: KakaoSignUpRequest, completion: @escaping (NetworkResult<Any>) -> (Void)) {
        AFManager.request(SignUpService.signUpKakako(request)).responseData { (response) in
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
                completion(self.judgeData(by: statusCode, data, KakaoSignUpResponse.self))
            case .failure(let err):
                completion(.networkFail(err.localizedDescription))
            }
        }
    }
    
    /// 애플 회원가입 API
    func signUpApple(request: AppleSignUpRequest, completion: @escaping (NetworkResult<Any>) -> (Void)) {
        AFManager.request(SignUpService.signUpApple(request)).responseData { (response) in
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
            completion(self.judgeData(by: statusCode, data, AppleSignUpResponse.self))
        case .failure(let err):
            completion(.networkFail(err.localizedDescription))
        }
        }
    }
}
