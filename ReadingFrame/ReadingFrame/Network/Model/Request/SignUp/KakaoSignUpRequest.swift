//
//  KakaoSignUpRequest.swift
//  ReadingFrame
//
//  Created by 이윤지 on 8/20/24.
//

import Foundation

/// 카카오 회원가입 Request 모델
struct KakaoSignUpRequest: Encodable {
    let nickname: String
    let profileImageCode: String
    let email: String
}
