//
//  NicknameValidateRequest.swift
//  ReadingFrame
//
//  Created by 이윤지 on 9/24/24.
//

import Foundation

/// 닉네임 중복 검사 Request 모델
struct NicknameValidateRequest: Encodable {
    let nickname: String
}
