//
//  SignUpViewModels.swift
//  ReadingFrame
//
//  Created by 이윤지 on 9/24/24.
//

import Foundation

/// 회원가입 화면의 뷰모델
final class SignUpViewModel: ObservableObject {
    /// 닉네임 중복 검사
    func validateNickname(nickname: String, completion: @escaping(Bool) -> Void) {
        NicknameValidateAPI.shared.validateNickname(nickname: nickname) { response in
            switch response {
            case .success:
                completion(true)
            case .requestErr(let message):
                print("Request Err: \(message)")
                completion(false)
            case .pathErr:
                print("Path Err")
                completion(false)
            case .serverErr(let message):
                print("Server Err: \(message)")
                completion(false)
            case .networkFail(let message):
                print("Network Err: \(message)")
                completion(false)
            case .unknown(let error):
                print("Unknown Err: \(error)")
                completion(false)
            }
        }
    }
    
    /// 카카오 회원가입
    func signUpKakao(request: KakaoSignUpRequest, completion: @escaping(Bool) -> Void) {
        SignUpAPI.shared.signUpKakao(request: request) { response in
            switch response {
            case .success(let data):
                if let data = data as? KakaoSignUpResponse {
                    // KeyChain에 토큰 저장
                    if KeyChain.shared.addToken(token: data.xAuthToken) {
                        print("카카오 로그인 성공!! \(String(describing: KeyChain.shared.getToken()))")
                        completion(true)
                    }
                    else {
                        print("키체인에 토큰 저장 실패")
                        completion(false)
                    }
                        
                }
            case .requestErr(let message):
                print("Request Err: \(message)")
                completion(false)
            case .pathErr:
                print("Path Err")
                completion(false)
            case .serverErr(let message):
                print("Server Err: \(message)")
                completion(false)
            case .networkFail(let message):
                print("Network Err: \(message)")
                completion(false)
            case .unknown(let error):
                print("Unknown Err: \(error)")
                completion(false)
            }
        }
    }
}
