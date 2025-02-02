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
    @Published var selectedTab: readingNoteTab
    
    /// 책갈피 전체조회로 불러올 책갈피 데이터 모델
    @Published var bookmarkData: [Bookmark]?
    
    /// 수정할 책갈피를 위한 정보 저장용
    @Published var pickedBookmark: Bookmark?
    
    /// 메모 전체조회로 불러올 책갈피 데이터 모델
    @Published var memoData: [Memo]?
    
    /// 수정할 메모를 위한 정보 저장용
    @Published var pickedMemo: Memo?
    
    /// 인물사전 전체조회로 불러올 책갈피 데이터 모델
    @Published var characterData: [Character]?
    
    /// 인물 검색했을 때 검색결과로 조회된 인물 배열
    @Published var filteredCharacter: [Character]?
    
    /// 수정/추가를 위해 필요한 책정보
    @Published var book: EditRecordBookModel
    
    // MARK: - init
    init(selectedTab: readingNoteTab, book: EditRecordBookModel) {
        self.book = book
        self.selectedTab = selectedTab
        
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
            Bookmark(id: "", date: Date(), markPage: 35, markPercent: 1, location: PlaceInfo(placeName: "원자력병원", address: "", latitude: 37.6287618, longitude: 127.08264)),
            Bookmark(id: "", date: Date(), markPage: 35, markPercent: 2),
            Bookmark(id: "", date: Date(), markPage: 35, markPercent: 3),
            Bookmark(id: "", date: Date(), markPage: 35, markPercent: 4),
            Bookmark(id: "", date: Date(), markPage: 35, markPercent: 5),
            Bookmark(id: "", date: Date(), markPage: 35, markPercent: 6),
            Bookmark(id: "", date: Date(), markPage: 35, markPercent: 7),
            Bookmark(id: "", date: Date(), markPage: 35, markPercent: 8),
            Bookmark(id: "", date: Date(), markPage: 35, markPercent: 9),
            Bookmark(id: "", date: Date(), markPage: 35, markPercent: 0)
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
            Character(emoji: 129401, name: "얼굴", preview: "슬픈 얼굴이지요 너무 슬퍼서 울고 있는 얼굴입니다", description: "어쩌구룰루"),
            Character(emoji: 129401, name: "얼굴", description: "어쩌구룰루"),
            Character(emoji: 129401, name: "얼굴", preview: "어쩌구", description: "어쩌구룰루"),
            Character(emoji: 129401, name: "얼굴", preview: "어쩌구", description: "어쩌구룰루"),
            Character(emoji: 129401, name: "얼굴", preview: "어쩌구", description: "어쩌구룰루"),
            Character(emoji: 129401, name: "얼굴", preview: "어쩌구", description: "어쩌구룰루"),
            Character(emoji: 129401, name: "얼굴", preview: "어쩌구", description: "어쩌구룰루"),
            Character(emoji: 129401, name: "얼굴", preview: "어쩌구", description: "어쩌구룰루"),
            Character(emoji: 129401, name: "얼굴", preview: "어쩌구", description: "어쩌구룰루")
        ]
        
        self.filteredCharacter = characterData
    }
    
    /// 인물사전 검색하기
    func searchCharacter(searchQuery: String) {
        if searchQuery.isEmpty {
            filteredCharacter = characterData
        } else {
            filteredCharacter = characterData?.filter { character in
                if let preview = character.preview {
                    character.name.localizedCaseInsensitiveContains(searchQuery)
                    || preview.localizedCaseInsensitiveContains(searchQuery)
                } else {
                    character.name.localizedCaseInsensitiveContains(searchQuery)
                }
            }
        }
    }
}
