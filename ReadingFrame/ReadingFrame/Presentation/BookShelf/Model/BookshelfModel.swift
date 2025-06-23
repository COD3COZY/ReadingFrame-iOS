//
//  BookshelfModel.swift
//  ReadingFrame
//
//  Created by 석민솔 on 7/24/24.
//

import Foundation

/// 책장 분류 기준 종류들
enum BookshelfSort: Int, CaseIterable {
    /// 책 종류별
    case booktype
    /// 독서상태별
    case readingStatus
    /// 장르별
    case genre
    
    /// 디스플레이용 분류 기준 이름 String
    var name: String {
        switch self {
        case .booktype:
            "책 유형별"
        case .readingStatus:
            "독서상태별"
        case .genre:
            "장르별"
        }
    }
}

/// 리스트 서재(BookShelfListByType) Row에서 사용할 책정보
struct BookShelfRowInfo: Identifiable {
    var id: UUID = UUID()
    let ISBN: String
    let cover: String
    let title: String
    let author: String
    let bookType: BookType?
    let category: CategoryName
    let isMine: Bool?
    let totalPage: Int?
    let readPage: Int?
    let readingPercent: Int?
}
