//
//  TabReadingNoteViewModel.swift
//  ReadingFrame
//
//  Created by 석민솔 on 12/22/24.
//

import Foundation

class TabReadingNoteViewModel: ObservableObject {
    // - MARK: Properties
    /// 선택된 탭이 뭔지
    /// - 따로 입력하지 않으면 기본은 책갈피
    @Published var selectedTab: readingNoteTab = .bookmark
    
    /// 책갈피 전체조회로 불러올 책갈피 데이터 모델
    @Published var bookmarkData: [Bookmark]?
    
    /// 메모 전체조회로 불러올 책갈피 데이터 모델
    @Published var memoData: [Memo]?
    
    /// 인물사전 전체조회로 불러올 책갈피 데이터 모델
    @Published var characterData: [Character]?
    
    // MARK: - init
    init(selectedTab: readingNoteTab = .bookmark) {
        switch selectedTab {
        case .bookmark:
            fetchBookmarkData()
        case .memo:
            fetchMemoData()
        case .character:
            fetchCharacterData()
        }
    }
    
    // MARK: - Methods
    /// 책갈피 데이터 불러오기
    func fetchBookmarkData() {
        // TODO: 책갈피 전체조회 API 호출하기
        
        // FIXME: 아래쪽 더미 데이터 지우기
        self.bookmarkData = [
            Bookmark(id: "", date: Date(), markPage: 35, markPercent: 1, location: "위치"),
            Bookmark(id: "", date: Date(), markPage: 35, markPercent: 2, location: "위치"),
            Bookmark(id: "", date: Date(), markPage: 35, markPercent: 3, location: "위치"),
            Bookmark(id: "", date: Date(), markPage: 35, markPercent: 4, location: "위치"),
            Bookmark(id: "", date: Date(), markPage: 35, markPercent: 5, location: "위치"),
            Bookmark(id: "", date: Date(), markPage: 35, markPercent: 6, location: "위치"),
            Bookmark(id: "", date: Date(), markPage: 35, markPercent: 7, location: "위치"),
            Bookmark(id: "", date: Date(), markPage: 35, markPercent: 8, location: "위치"),
            Bookmark(id: "", date: Date(), markPage: 35, markPercent: 9, location: "위치"),
            Bookmark(id: "", date: Date(), markPage: 35, markPercent: 0, location: "위치")
        ]
    }
    
    /// 메모 데이터 불러오기
    func fetchMemoData() {
        // TODO: 메모 전체조회 API 호출하기
        
        // FIXME: 아래쪽 더미 데이터 지우기
        self.memoData = [
            Memo(id: "0", date: Date(), markPage: 10, markPercent: 10, memo: "hello"),
            Memo(id: "1", date: Date(), markPage: 10, markPercent: 10, memo: "hello"),
            Memo(id: "2", date: Date(), markPage: 10, markPercent: 10, memo: "hello"),
            Memo(id: "3", date: Date(), markPage: 10, markPercent: 10, memo: "hello"),
            Memo(id: "4", date: Date(), markPage: 10, markPercent: 10, memo: "hello"),
            Memo(id: "5", date: Date(), markPage: 10, markPercent: 10, memo: "hello"),
            Memo(id: "6", date: Date(), markPage: 10, markPercent: 10, memo: "hello"),
        ]
    }
    
    /// 인물사전 데이터 불러오기
    func fetchCharacterData() {
        // TODO: 인물사전 전체조회 API 호출하기
        
        // FIXME: 아래쪽 더미 데이터 지우기
        self.characterData = [
            Character(emoji: 129401, name: "얼굴", preview: "어쩌구저쩌구라고 합니다 하지만 슬픈 얼굴이지요 너무 슬퍼서 울고 있는 얼굴입니다 하지만", description: "어쩌구룰루"),
            Character(emoji: 129401, name: "얼굴", preview: "어쩌구", description: "어쩌구룰루"),
            Character(emoji: 129401, name: "얼굴", preview: "어쩌구", description: "어쩌구룰루"),
            Character(emoji: 129401, name: "얼굴", preview: "어쩌구", description: "어쩌구룰루"),
            Character(emoji: 129401, name: "얼굴", preview: "어쩌구", description: "어쩌구룰루"),
            Character(emoji: 129401, name: "얼굴", preview: "어쩌구", description: "어쩌구룰루"),
            Character(emoji: 129401, name: "얼굴", preview: "어쩌구", description: "어쩌구룰루"),
            Character(emoji: 129401, name: "얼굴", preview: "어쩌구", description: "어쩌구룰루"),
            Character(emoji: 129401, name: "얼굴", preview: "어쩌구", description: "어쩌구룰루")
        ]
    }
}
