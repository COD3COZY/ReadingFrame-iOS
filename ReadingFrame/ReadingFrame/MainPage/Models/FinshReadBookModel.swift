//
//  FinshReadBookModel.swift
//  ReadingFrame
//
//  Created by 이윤지 on 11/13/24.
//

import Foundation

/// [Entity] 다 읽은 책 모델
struct FinishReadBookModel {
    var readingStatus: ReadingStatus = .finishRead
    var isbn: String
    var cover: String
    var title: String
    var author: String
    var category: CategoryName // 카테고리
    var bookType: BookType // 책 유형(종이책, 전자책, 오디오북)
    var isMine: Bool // 소장 여부
    var isWriteReview: Bool // 리뷰 작성 여부
}
