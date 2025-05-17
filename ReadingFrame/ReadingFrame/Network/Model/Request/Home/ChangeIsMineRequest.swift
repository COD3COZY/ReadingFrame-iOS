//
//  ChangeIsMineRequest.swift
//  ReadingFrame
//
//  Created by 이윤지 on 11/14/24.
//

import Foundation

/// 소장 여부 변경 Request 모델
struct ChangeIsMineRequest: Encodable {
    let isMine: Bool
}
