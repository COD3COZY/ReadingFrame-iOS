//
//  KakaoLoginResponse.swift
//  ReadingFrame
//
//  Created by 이윤지 on 8/20/24.
//

import Foundation

/// 카카오 로그인 Response 모델
struct KakaoLoginResponse: Codable {
    let xAuthToken: String
    
    enum CodingKeys: String, CodingKey {
        case xAuthToken = "xAuthToken"
    }
}
