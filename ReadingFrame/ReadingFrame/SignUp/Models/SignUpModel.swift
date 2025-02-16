//
//  LoginModel.swift
//  ReadingFrame
//
//  Created by 석민솔 on 8/28/24.
//

import Foundation


/// 회원가입을 위한 필수정보
class SignUpInfo: ObservableObject, Hashable {
    /// 소셜 로그인 종류
    var socialLoginType: SocialLoginType
    
    /// 유저가 입력한 닉네임
    @Published var nickname: String
    
    /// 유저가 선택한 프로필이미지
    @Published var profileImageCode: String
    
    init(socialLoginType: SocialLoginType) {
        self.socialLoginType = socialLoginType
        self.nickname = ""
        self.profileImageCode = ""
    }
    
    /// For hashable
    let id = UUID()

    static func == (lhs: SignUpInfo, rhs: SignUpInfo) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

/// 회원가입 유형(카카오 or 애플)
enum SocialLoginType {
    case kakao
    case apple
}
