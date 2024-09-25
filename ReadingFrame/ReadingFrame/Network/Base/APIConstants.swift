//
//  APIConstants.swift
//  ReadingFrame
//
//  Created by 이윤지 on 8/20/24.
//

import Foundation

/// BaseURL, Endpoint를 모아두는 파일
struct APIConstants {
    /// 서버 URL
    static let baseURL = devURL
    
    /// 실서버 URL
    static let prodURL = Bundle.main.object(forInfoDictionaryKey: "BASE_URL") as! String
    
    /// 테스트 서버 URL
    static let devURL = "http://127.0.0.1:8080"
    
    /// 닉네임 중복 검사 API
    static let validateNicknameURL = "/nickname/"
    
    /// 카카오 회원가입 API
    static let signUpKakaoURL = "/sign-up/kakao"
    
    /// 카카오 로그인 API
    static let loginKakaoURL = "/sign-in/kakao"
}

/// 한글 인코딩
/// url에 한글을 넣기 위함
extension String {
    /// 인코딩
    func encodeURL() -> String? {
        return self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    }
    
    /// 디코딩
    func decodeURL() -> String? {
        return self.removingPercentEncoding
    }
}
