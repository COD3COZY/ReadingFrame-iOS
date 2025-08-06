//
//  AppleSignUpResponse.swift
//  ReadingFrame
//
//  Created by 석민솔 on 3/5/25.
//

import Foundation

/// 애플 회원가입 Response 모델
struct AppleSignUpResponse: Decodable {
    let xAuthToken: String
    
    enum CodingKeys: String, CodingKey {
        case xAuthToken = "xAuthToken"
    }
}
