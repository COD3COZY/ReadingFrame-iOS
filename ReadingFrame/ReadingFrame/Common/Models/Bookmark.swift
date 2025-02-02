//
//  Bookmark.swift
//  ReadingFrame
//
//  Created by 이윤지 on 5/8/24.
//

import Foundation

/// 등록된 책(읽고 있는 책, 다 읽은 책)의 책갈피 모델
struct Bookmark: Identifiable, Codable {
    /// 책갈피 id
    let id: String
    
    /// 날짜
    var date: Date
    
    /// 마지막으로 읽은 페이지
    var markPage: Int
    
    /// 읽은 퍼센트
    var markPercent: Int
    
    // 위치 관련
    /// 위치 이름
    var location: PlaceInfo?
}
