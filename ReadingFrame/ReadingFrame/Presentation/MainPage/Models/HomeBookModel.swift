//
//  HomeBookModel.swift
//  ReadingFrame
//
//  Created by 이윤지 on 11/13/24.
//

import Foundation

/// [Entity] 홈 화면 내의 모든 책 모델
struct HomeBookModel {
    var readingStatus: ReadingStatus
    var isbn: String
    var cover: String
    var title: String
    var author: String
    var readingPercent: Int?
    var totalPage: Int?
    var readPage: Int?
    
    /// 홈 화면에서 숨기기 여부(O: 숨김, X: 안 숨김)
    var isHidden: Bool?
    
    /// 소장 여부
    var isMine: Bool?
    
    /// 리뷰 작성 여부
    var isWriteReview: Bool?
    
    /// 책의 종류
    var bookType: BookType?
}
