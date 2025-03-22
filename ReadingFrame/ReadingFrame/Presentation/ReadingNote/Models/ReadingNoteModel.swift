//
//  ReadingNoteModel.swift
//  ReadingFrame
//
//  Created by 석민솔 on 10/31/24.
//

import Foundation

/// 독서노트를 위한 모델
struct ReadingNoteModel: Codable {
    /// 표지 이미지 url
    let cover: String

    /// 책제목
    let title: String

    /// 저자
    let author: String

    /// 카테고리
    let categoryName: CategoryName

    /// 전체 페이지 수
    let totalPage: Int

    /// 읽은 페이지
    var readPage: Int

    /// 읽은 퍼센트
    /// - 12%면 정수로 12
    var readingPercent: Int
    
    /// 리뷰 최초 등록일
    var firstReviewDate: Date?

    /// 이 책을 기억하는 한가지 단어 키워드
    var keywordReview: String?

    /// 개인 한줄평
    var commentReview: String?

    /// 선택리뷰 리스트
    var selectReview: [selectReviewCode]?

    /// 소장여부
    var isMine: Bool

    /// 책유형
    var bookType: BookType

    /// 독서상태
    /// - 읽는중, 다읽음 중 하나
    var readingStatus: ReadingStatus

    /// 대표위치 장소명
    var mainLocation: String?

    /// 시작날짜
    var startDate: Date

    /// 마지막 날짜
    /// - 이 책에 대해 마지막으로 기록한 날짜
    var recentDate: Date

    /// 책갈피 list
    /// - 기본적으로 초기에는 3개만 보여줄 예정
    var bookmarks: [Bookmark]?

    /// 메모 list
    /// - 기본적으로 초기에는 3개만 보여줄 예정
    let memos: [Memo]?

    /// 인물사전 list
    /// - 기본적으로 초기에는 3개만 보여줄 예정
    let characters: [Character]?
}

/// 기록 타입: 책갈피, 메모, 인물사전
enum RecordType: String, CaseIterable {
    case bookmark = "책갈피"
    case memo = "메모"
    case character = "인물사전"
}
