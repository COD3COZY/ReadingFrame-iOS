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
    }
    
    // MARK: - Methods
    /// 책갈피 데이터 불러오기
    func fetchBookmarkData(completion: @escaping (Bool) -> (Void)) {
        TabReadingNoteAPI.shared.fetchAllBookmark(isbn: book.isbn) { response in
            switch response {
            case .success(let data):
                if let bookmarks = data as? [BookmarkTapResponse] {
                    self.bookmarkData = bookmarks.map {
                        Bookmark(
                            id: $0.uuid,
                            date: DateUtils.stringToDate($0.date),
                            markPage: $0.markPage,
                            markPercent: $0.markPercent
                        )
                    }
                }
                completion(true)
                
            case .requestErr(let message):
                print("Request Err: \(message)")
                completion(false)
            case .pathErr:
                print("Path Err")
                completion(false)
            case .serverErr(let message):
                print("Server Err: \(message)")
                completion(false)
            case .networkFail(let message):
                print("Network Err: \(message)")
                completion(false)
            case .unknown(let error):
                print("Unknown Err: \(error)")
                completion(false)
            }
        }
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
