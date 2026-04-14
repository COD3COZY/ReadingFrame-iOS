//
//  Path.swift
//  ReadingFrame
//
//  Created by 석민솔 on 2026/04/14.
//

import Foundation

/// Coordinator가 관리하는 push 목적지
enum Path: Hashable {
    // MARK: Home 탭
    case bookInfo(isbn: String)
    case readingNote(isbn: String)
    case bookInfoReview
    case bookRowDetail(readingStatus: ReadingStatus)
    case search
    case bookShelfListByType(bookshelfSubtype: BookshelfSubtype)

    // MARK: ReadingNote 내부에서 push되던 화면들
    case tabReadingNote(bookType: BookType, totalPage: Int, isbn: String, selectedTab: RecordType)
    case editReview(reviewID: String?)
    case characterDetail(characterID: String, isbn: String)

    // MARK: MyPage 탭
    case searchBadge
    case editProfile(character: ProfileCharacter, nickname: String)
    case editProfileCharacter
    case settings
    case support
}

/// `Path`에 실어 보내기 위한 BookEnum의 Hashable 래퍼
enum BookshelfSubtype: Hashable, BookEnum {
    case bookType(BookType)
    case readingStatus(ReadingStatus)
    case category(CategoryName)

    var name: String {
        switch self {
        case .bookType(let v): v.name
        case .readingStatus(let v): v.name
        case .category(let v): v.name
        }
    }

    var code: String {
        switch self {
        case .bookType(let v): v.code
        case .readingStatus(let v): v.code
        case .category(let v): v.code
        }
    }

    /// 임의의 BookEnum 인스턴스를 BookshelfSubtype으로 변환
    static func from(_ value: BookEnum) -> BookshelfSubtype? {
        if let v = value as? BookType { return .bookType(v) }
        if let v = value as? ReadingStatus { return .readingStatus(v) }
        if let v = value as? CategoryName { return .category(v) }
        return nil
    }
}
