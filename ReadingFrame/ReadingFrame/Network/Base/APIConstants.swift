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
    static let prodURL = ""
    
    /// 테스트 서버 URL
    static let devURL = ""
    
    /// 카카오 회원가입 API
    static let signUpKakaoURL = "/sign-up/kakao"
    
    /// 카카오 로그인 API
    static let loginKakaoURL = "/sign-in/kakao"
}
