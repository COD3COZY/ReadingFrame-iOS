//
//  ReadingBookResponse.swift
//  ReadingFrame
//
//  Created by 이윤지 on 10/14/24.
//

import Foundation

/// 읽고 있는 책 조회 Response 모델
struct ReadingBookResponse: Decodable {
    var isbn: String
    var cover: String
    var title: String
    var author: String
    var readingPercent: Int
    var totalPage: Int
    var readPage: Int
    var isHidden: Bool
    var category: Int
    var bookType: Int
    var isMine: Bool
    var isWriteReview: Bool
}
