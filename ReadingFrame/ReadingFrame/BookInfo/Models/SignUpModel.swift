//
//  LoginModel.swift
//  ReadingFrame
//
//  Created by 석민솔 on 8/28/24.
//

import Foundation


/// 회원가입을 위한 필수정보
protocol SignUpInfo {
    /// 소셜 로그인 종류
    var socialLoginType: SocialLoginType { get set }
    
    /// 유저가 입력한 닉네임
    var nickname: String { get set }
    
    /// 유저가 선택한 프로필이미지
    var profileImageCode: String { get set }
}

/// 회원가입 유형(카카오 or 애플)
enum SocialLoginType {
    case kakao
    case apple
}

/// 카카오 소셜로그인을 이용해서 회원가입을 할 때 백엔드에 넘겨줄 정보들
class KakaoSignUpInfo: SignUpInfo, ObservableObject {
    
    // 카카오 전달 정보
    /// 카카오 측에서 전달해준 이메일
    var email: String
    
    // 앱 내에서 입력하는 정보들
    /// 소셜 로그인 정보: 카카오
    var socialLoginType: SocialLoginType
    
    /// 유저가 입력한 닉네임
    @Published var nickname: String
    
    /// 유저가 선택한 프로필이미지
    @Published var profileImageCode: String
    
    /// 생성자
    init(email: String) {
        self.email = email
        self.socialLoginType = .kakao
        self.nickname = ""
        self.profileImageCode = ""
    }
}

/// 애플 소셜로그인을 이용해서 회원가입을 할 때 백엔드에 넘겨줄 정보들
class AppleSignUpInfo: SignUpInfo, ObservableObject {
    
    // 애플 전달 정보
    /// 애플 측에서 전달해준 UserIdentifier
    var userIdentifier: String
    
    /// 애플 측에서 전달해준 토큰
    var idToken: String
    
    
    // 앱 내에서 입력하는 정보들
    /// 소셜 로그인 정보: 애플
    var socialLoginType: SocialLoginType
    
    /// 유저가 입력한 닉네임
    @Published var nickname: String
    
    /// 유저가 선택한 프로필이미지
    @Published var profileImageCode: String
    
    /// 생성자
    init(userIdentifier: String, idToken: String) {
        self.userIdentifier = userIdentifier
        self.idToken = idToken
        self.socialLoginType = .apple
        self.nickname = ""
        self.profileImageCode = ""
    }
}
