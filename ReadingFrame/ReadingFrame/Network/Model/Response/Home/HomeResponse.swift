//
//  HomeResponse.swift
//  ReadingFrame
//
//  Created by 이윤지 on 10/2/24.
//

import Foundation

/// 홈 조회 Response 모델
struct HomeResponse: Codable {
    var booksList: [HomeBooks]? // 전체 책 리스트
    let wantToReadBooksCount: Int // 읽고 싶은 책 개수
    let readingBooksCount: Int // 읽고 있는 책 개수
}

/// 홈 조회 전체 책 리스트 Response 모델
struct HomeBooks: Codable {
    var readingStatus: Int // 독서 상태
    var isbn: String // ISBN
    var cover: String // 표지 이미지 URL
    var title: String // 제목
    var author: String // 저자
    var readingPercent: Int? // 읽은 퍼센트
    var totalPage: Int? // 전체 페이지
    var readPage: Int? // 읽은 페이지
    var isMine: Bool? // 소장 여부
}
