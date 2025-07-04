//
//  WantToReadBookModel.swift
//  ReadingFrame
//
//  Created by 이윤지 on 11/13/24.
//

import Foundation

/// [Entity] 읽고 싶은 책 모델
struct WantToReadBookModel: DetailBookModel {
    var readingStatus: ReadingStatus = .wantToRead
    var isbn: String
    var cover: String
    var title: String
    var author: String
    var category: CategoryName // 카테고리
}
