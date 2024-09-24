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
        AFManager.request(SignUpService.signUpKakako(request), interceptor: MyRequestInterceptor()).responseData { (response) in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode
                else {
                    return
                }
                guard let data = response.value
                else {
                    return
                }
                completion(self.judgeData(status: statusCode, data: data))
            case .failure(let err):
                completion(.networkFail(err))
            }
        }
    }
    
    /// 카카오 회원가입 응답 분기 처리
    private func judgeData(status: Int, data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(CommonResponse<KakaoSignUpResponse>.self, from: data)
        else {
            return .pathErr // 디코딩 오류
        }
        
        switch status {
        // 회원가입 성공
        case 200:
            print(decodedData.message)
            return .success(decodedData.data ?? decodedData.message)
        case 400..<500:
            return .requestErr(decodedData.message)
        case 500:
            return .serverErr(decodedData.message)
        default:
            return .networkFail(decodedData.message)
        }
    }
}
