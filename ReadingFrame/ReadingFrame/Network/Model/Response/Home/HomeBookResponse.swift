//
//  HomeBookResponse.swift
//  ReadingFrame
//
//  Created by 이윤지 on 11/13/24.
//

import Foundation

/// 홈 조회 전체 책 리스트 Response 모델
struct HomeBookResponse: Decodable {
    var readingStatus: Int // 독서 상태
    var isbn: String // ISBN
    var cover: String // 표지 이미지 URL
    var title: String // 제목
    var author: String // 저자
    var readingPercent: Int? // 읽은 퍼센트
    var totalPage: Int? // 전체 페이지
    var readPage: Int? // 읽은 페이지
    var isMine: Bool? // 소장 여부
    var isWriteReview: Bool? // 리뷰 작성 여부
    var bookType: Int? // 책의 종류
}
