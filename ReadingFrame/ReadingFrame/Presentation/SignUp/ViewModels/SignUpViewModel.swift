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
    
    
    /// 애플 회원가입 API 호출
    func signUpApple(request: AppleSignUpRequest, completion: @escaping(Bool) -> Void) {
        SignUpAPI.shared.signUpApple(request: request) { response in
            switch response {
            case .success(let data):
                if let data = data as? AppleSignUpResponse {
                    // KeyChain에 토큰 저장
                    if KeyChain.shared.addToken(token: data.xAuthToken) {
                        print("애플 로그인 성공!! \(String(describing: KeyChain.shared.getToken()))")
                        completion(true)
                    }
                    else {
                        print("키체인에 토큰 저장 실패")
                        completion(false)
                    }
                        
                }
            case .requestErr(let message):
                print("Request Err: \(message)")
                
                if message as! String == "ID 토큰이 유효하지 않습니다." {
                    // TODO: 로그인 화면으로 다시 돌아가서 애플한테 토큰 다시 받기
                } else if message as! String == "이미 가입한 회원입니다." {
                    // ????? 이럴 수가 있나...?
                }
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
