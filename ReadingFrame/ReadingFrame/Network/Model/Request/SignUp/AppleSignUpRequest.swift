//
//  AppleSignUpRequest.swift
//  ReadingFrame
//
//  Created by 석민솔 on 3/5/25.
//

import Foundation

/// 애플 회원가입 Request 모델
struct AppleSignUpRequest: Encodable {
    let userIdentifier: String
    let idToken: String
    let nickname: String
    let profileImageCode: String
}
