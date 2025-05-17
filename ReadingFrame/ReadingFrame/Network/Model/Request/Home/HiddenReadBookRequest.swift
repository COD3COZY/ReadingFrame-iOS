//
//  HiddenReadBookRequest.swift
//  ReadingFrame
//
//  Created by 이윤지 on 11/14/24.
//

import Foundation

/// 읽고 있는 책 숨기기&꺼내기 Request 모델
struct HiddenReadBookRequest: Encodable {
    let isHidden: Bool
}
