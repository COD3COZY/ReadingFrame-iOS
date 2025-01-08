//
//  Memo.swift
//  ReadingFrame
//
//  Created by 이윤지 on 5/29/24.
//

import Foundation

/// 등록된 책(읽고 있는 책, 다 읽은 책)의 메모 모델
struct Memo: Codable {
    /// 메모 id
    var id: String
    
    /// 날짜
    var date: Date
    
    /// 메모하고 싶은 페이지
    var markPage: Int
    
    /// 읽은 퍼센트
    var markPercent: Int
    
    /// 메모
    var memo: String
}
