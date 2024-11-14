//
//  NicknameValidateAPI.swift
//  ReadingFrame
//
//  Created by 이윤지 on 9/24/24.
//

import Foundation
import Alamofire

/// 닉네임 중복 검사 API
class NicknameValidateAPI: BaseAPI {
    static let shared = NicknameValidateAPI()
    
    private override init() {
        super.init()
    }
    
    /// 닉네임 중복검사 API
    func validateNickname(nickname: String, completion: @escaping (NetworkResult<Any>) -> (Void)) {
        AFManager.request(NicknameValidateService.validateNickname(nickname)).responseData { (response) in
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
