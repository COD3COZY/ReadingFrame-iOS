//
//  SearchResponse.swift
//  ReadingFrame
//
//  Created by 이윤지 on 12/22/24.
//

import Foundation

/// 검색 Response 모델
struct SearchResponse: Decodable {
    var totalCount: Int // 총 검색 결과
    var searchList: [SearchBookResponse] // 검색 결과 리스트
}

/// 검색어에 따른 책 검색 결과 리스트 Response 모델
struct SearchBookResponse: Decodable {
    let isbn: String // ISBN
    let cover: String // 책 표지 URL
    let title: String // 책 제목
    let author: String // 저자
    let publisher: String // 출판사
    let publicationDate: String // 발행일
}
