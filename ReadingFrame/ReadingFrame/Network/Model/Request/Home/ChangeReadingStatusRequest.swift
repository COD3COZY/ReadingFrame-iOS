//
//  ChangeReadingStatusRequest.swift
//  ReadingFrame
//
//  Created by 이윤지 on 11/14/24.
//

import Foundation

/// 독서 상태 변경 Request 모델
struct ChangeReadingStatusRequest: Encodable {
    let readingStatus: Int
}
