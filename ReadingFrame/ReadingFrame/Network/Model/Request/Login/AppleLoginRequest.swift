//
//  AppleLoginRequest.swift
//  ReadingFrame
//
//  Created by 석민솔 on 3/5/25.
//

import Foundation

/// 애플 로그인 Request 모델
struct AppleLoginRequest: Encodable {
    let userIdentifier: String
    let idToken: String
}
