//
//  BookInfoModel.swift
//  ReadingFrame
//
//  Created by 석민솔 on 2/19/24.
//

import Foundation
import Observation

@Observable
class BookInfoModel {
    /// 도서정보에서 조회할 책
    var book: InitialBook
    
    /// 선택리뷰 top 10
    var selectReviews: [selectReviewCode]
    
    /// 한줄평 최신순 5개
    var comments: [Comment]
    
    /// 더미 기본값
    init(book: InitialBook = InitialBook(),
         selectReviews: [selectReviewCode] = [.looksNice, .comforting],
         comments: [Comment] = [Comment(), Comment(), Comment(), Comment(), Comment()]) {
        self.book = book
        self.selectReviews = selectReviews
        self.comments = comments
    }
}
