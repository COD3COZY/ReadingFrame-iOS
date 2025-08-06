//
//  BookshelfListResponse.swift
//  ReadingFrame
//
//  Created by 석민솔 on 6/23/25.
//

import Foundation

/// 책장 리스트용 조회용 모델
struct BookshelfListResponse: Decodable {
    let ISBN: String
    let cover: String
    let title: String
    let author: String
    let bookType: Int?
    let category: Int
    let isMine: Bool?
    let totalPage: Int?
    let readPage: Int?
    let readingPercent: Int?
}

extension BookshelfListResponse {
    func toEntity() -> BookShelfRowInfo {
        return BookShelfRowInfo(
            ISBN: self.ISBN,
            cover: self.cover,
            title: self.title,
            author: self.author,
            bookType: self.bookType != nil ? BookType(rawValue: self.bookType!) : nil,
            category: CategoryName(rawValue: self.category) ?? .etc,
            isMine: self.isMine,
            totalPage: self.totalPage,
            readPage: self.readPage,
            readingPercent: self.readingPercent
        )
    }
}
