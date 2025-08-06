//
//  HomeResponse.swift
//  ReadingFrame
//
//  Created by 이윤지 on 10/2/24.
//

import Foundation

/// 홈 조회 Response 모델
struct HomeResponse: Decodable {
    var booksList: [HomeBookResponse]? // 전체 책 리스트
    let wantToReadBooksCount: Int // 읽고 싶은 책 개수
    let readingBooksCount: Int // 읽고 있는 책 개수
}
