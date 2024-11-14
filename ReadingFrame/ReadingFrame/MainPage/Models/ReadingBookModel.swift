//
//  ReadingBookModel.swift
//  ReadingFrame
//
//  Created by 이윤지 on 10/14/24.
//

import Foundation

/// [Entity] 읽고 있는 책 모델
struct ReadingBookModel {
    var readingStatus: ReadingStatus = .reading
    var isbn: String
    var cover: String
    var title: String
    var author: String
    var readingPercent: Int
    var totalPage: Int
    var readPage: Int
    var isHidden: Bool // 홈 화면에서 숨기기 여부
    var category: CategoryName // 카테고리
    var bookType: BookType // 책 유형(종이책, 전자책, 오디오북)
    var isMine: Bool // 소장 여부
    var isWriteReview: Bool // 리뷰 작성 여부
}
