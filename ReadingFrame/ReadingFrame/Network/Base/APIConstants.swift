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
    static let validateNicknameURL = "/member/nickname/check"
    
    /// 카카오 회원가입 API
    static let signUpKakaoURL = "/member/sign-up/kakao"
    
    /// 애플 회원가입 API
    static let signUpAppleURL = "/member/sign-up/apple"
    
    /// 카카오 로그인 API
    static let loginKakaoURL = "/member/sign-in/kakao"
    
    /// 애플 로그인 API
    static let loginAppleURL = "/member/sign-in/apple"
    
    /// 메인 화면 조회 API
    static let homeURL = "/home"
    
    /// 검색 API
    static let searchURL = "/home/search/"
    
    /// 읽고 있는 책 조회 API
    static let readingURL = "/home/reading"
    
    /// 읽고 싶은 책 조회 API
    static let wantToReadURL = "/home/want-to-read"
    
    /// 다 읽은 책 조회 API
    static let finishedReadingURL = "/home/finish-read"
    
    /// 책 관련 API에서 사용되는 공통 URL
    static let bookCommonURL = "/book/"
    
    /// 홈화면 관련  API에서 사용되는 공통 URL
    static let homeCommonURL = "/home/"
    
    /// 책장 관련 API에서 사용되는 공통 URL
    static let bookshelfCommonURL = "/bookshelf/"
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
