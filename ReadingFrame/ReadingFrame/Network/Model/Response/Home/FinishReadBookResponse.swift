//
//  FinishReadBooksResponse.swift
//  ReadingFrame
//
//  Created by 이윤지 on 11/13/24.
//

import Foundation

/// 홈 화면의 다 읽은 책 Response 모델
struct FinishReadBookResponse: Decodable {
    var isbn: String
    var cover: String
    var title: String
    var author: String
    var category: Int
    var bookType: Int
    var isMine: Bool
    var isWriteReview: Bool
}
