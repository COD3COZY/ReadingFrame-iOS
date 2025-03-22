//
//  BookInfo_ReviewModel.swift
//  ReadingFrame
//
//  Created by 석민솔 on 2/27/24.
//

import Foundation
import Observation

@Observable
class BookInfo_ReviewModel {
    /// 한줄평 데이터들
    var comments: [Comment]
    
    init(comments: [Comment]) {
        self.comments = comments
    }
    
}

/// 정렬 방식
enum OrderType {
    /// 반응순
    case reaction
    /// 최신순
    case latest
}
