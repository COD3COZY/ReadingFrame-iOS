//
//  ReadingNoteResponse.swift
//  ReadingFrame
//
//  Created by 석민솔 on 8/6/25.
//

import Foundation

/// 책별 독서노트 조회 API의 응답을 가져오기 위한 DTO
struct ReadingNoteResponse: Decodable {
    let cover: String
    let title: String
    let author: String
    let categoryName: String
    let totalPage: Int
    var readPage: Int
    var readingPercent: Int
    var firstReviewDate: String?
    var keywordReview: String?
    var commentReview: String?
    var selectReview: [Int]?
    var isMine: Bool
    var bookType: Int
    var readingStatus: Int
    var mainLocation: String?
    var startDate: String
    var recentDate: String?
    var bookmarks: [BookmarkDTO]?
    var memos: [MemoDTO]?
    var characters: [CharacterDTO]?
}

struct BookmarkDTO: Decodable {
    let date: String
    let markPage: Int
    let markPercent: Int
    let loaction: String?
    let uuid: String
}

struct MemoDTO: Decodable {
    let date: String
    let markPage: Int?
    let markPercent: Int?
    let memoText: String
    let uuid: String
}

struct CharacterDTO: Decodable {
    let emoji: Int
    let name: String
    let preview: String?
}


extension ReadingNoteResponse {
    /// ReadingNoteResponse DTO -> ReadingNoteModel Entity
    func toEntity() -> ReadingNoteModel {
        return ReadingNoteModel(
            cover: self.cover,
            title: self.title,
            author: self.author,
            categoryName: CategoryName.toCategoryName(self.categoryName),
            totalPage: self.totalPage,
            readPage: self.readPage,
            readingPercent: self.readingPercent,
            firstReviewDate: self.firstReviewDate != nil ? DateUtils.stringToDate(self.firstReviewDate!) : nil,
            keywordReview: self.keywordReview,
            commentReview: self.commentReview,
            selectReview: self.selectReview?.compactMap { SelectReviewCode(rawValue: $0) },
            isMine: self.isMine,
            bookType: BookType(rawValue: self.bookType) ?? .paperbook,
            readingStatus: ReadingStatus(rawValue: self.readingStatus) ?? .unregistered,
            mainLocation: self.mainLocation,
            startDate: DateUtils.stringToDate(self.startDate),
            recentDate: DateUtils.stringToDate(self.recentDate ?? self.startDate),
            bookmarks: self.toBookmarks(from: self.bookmarks),
            memos: self.toMemos(from: self.memos),
            characters: self.toCharacters(from: self.characters)
        )
    }
    
    func toBookmarks(from bookmarkDTOs: [BookmarkDTO]?) -> [Bookmark]? {
        guard let bookmarkDTOs else { return nil }
        
        let bookmarkEntities = bookmarkDTOs.map {
            Bookmark(
                id: $0.uuid,
                date: DateUtils.stringToDate($0.date),
                markPage: $0.markPage,
                markPercent: $0.markPercent,
                location: nil
            )
        }
        
        return bookmarkEntities
    }
    
    func toMemos(from memoDTOs: [MemoDTO]?) -> [Memo]? {
        guard let memoDTOs else { return nil }
        
        var memoEntities: [Memo] = []
        
        for memoDTO in memoDTOs {
            memoEntities.append(.init(
                id: memoDTO.uuid,
                date: DateUtils.stringToDate(memoDTO.date) ,
                markPage: memoDTO.markPage,
                markPercent: memoDTO.markPercent,
                memo: memoDTO.memoText
            ))
        }
        
        return memoEntities
    }
    
    func toCharacters(from characterDTOs: [CharacterDTO]?) -> [Character]? {
        guard let characterDTOs else { return nil }
        
        var characterEntities: [Character] = []
        
        for characterDTO in characterDTOs {
            characterEntities.append(.init(
                emoji: characterDTO.emoji,
                name: characterDTO.name,
                preview: characterDTO.preview,
                description: nil
            ))
        }
        
        return characterEntities
    }
}
