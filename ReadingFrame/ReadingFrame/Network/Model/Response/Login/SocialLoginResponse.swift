//
//  SocialLoginResponse.swift
//  ReadingFrame
//
//  Created by 이윤지 on 8/20/24.
//

import Foundation

/// 소셜로그인 Response 모델
/// - 카카오, 애플 둘 다 해당
struct SocialLoginResponse: Codable {
    let xAuthToken: String
    
    enum CodingKeys: String, CodingKey {
        case xAuthToken = "xAuthToken"
    }
}
