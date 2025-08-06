//
//  WantToBookResponse.swift
//  ReadingFrame
//
//  Created by 이윤지 on 11/13/24.
//

import Foundation

/// 읽고 싶은 책 Response 모델
struct WantToReadBookResponse: Decodable {
    var isbn: String
    var cover: String
    var title: String
    var author: String
    var category: Int
}
