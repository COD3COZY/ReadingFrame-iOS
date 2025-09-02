//
//  TabReadingNoteViewModel.swift
//  ReadingFrame
//
//  Created by 석민솔 on 12/22/24.
//

import Foundation
import Combine

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
    
    /// 인물사전 검색용 텍스트
    @Published var searchText: String = ""
    
    private var cancellables = Set<AnyCancellable>()
    
    /// 수정/추가를 위해 필요한 책정보
    @Published var book: EditRecordBookModel
    
    
    // MARK: - init
    init(selectedTab: readingNoteTab, book: EditRecordBookModel) {
        self.book = book
        self.selectedTab = selectedTab
        
        searchCharacterCombine()
    }
    
    // MARK: - Methods
    /// 책갈피 전체조회
    func fetchBookmarkData() {
        self.fetchBookmarkData { success in
            if !success {
                print("책갈피 데이터 로드 실패")
            }
        }
    }
    
    /// 책갈피 전체조회 API 호출
    private func fetchBookmarkData(completion: @escaping (Bool) -> (Void)) {
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
    
    /// 책갈피 삭제하고 뷰로직 처리
    func deleteBookmark(id: String) {
        deleteBookmark(id: id) { success in
            if success {
                self.bookmarkData?.removeAll {
                    $0.id == id
                }
            }
        }
    }
    
    /// 책갈피 삭제 API 호출
    private func deleteBookmark(id: String, completion: @escaping (Bool) -> (Void)) {
        TabReadingNoteAPI.shared.deleteBookmark(isbn: self.book.isbn, uuid: id) { response in
            switch response {
            case .success(let _):
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
    
    /// 메모 전체조회
    func fetchMemoData() {
        self.fetchMemoData(isbn: self.book.isbn) { success in
            if !success {
                print("메모 데이터 호출 실패")
            }
        }
    }
    
    /// 메모 전체조회 API 호출
    private func fetchMemoData(isbn: String, completion: @escaping (Bool) -> Void) {
        TabReadingNoteAPI.shared.fetchAllMemo(isbn: isbn) { response in
            switch response {
            case .success(let data):
                if let memos = data as? [MemoTapResponse] {
                    self.memoData = memos.map {
                        Memo(
                            id: $0.uuid,
                            date: DateUtils.stringToDate($0.date),
                            markPage: $0.markPage,
                            markPercent: $0.markPercent,
                            memo: $0.memoText
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
    
    /// 메모 삭제하고 뷰로직 처리
    func deleteMemo(id: String) {
        deleteMemo(id: id) { success in
            if success {
                self.memoData?.removeAll {
                    $0.id == id
                }
            }
        }
    }
    
    /// 메모 삭제 API 호출
    private func deleteMemo(id: String, completion: @escaping (Bool) -> (Void)) {
        TabReadingNoteAPI.shared.deleteMemo(isbn: self.book.isbn, uuid: id) { response in
            switch response {
            case .success(let _):
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
    
    /// 인물사전 데이터 불러오기
    func fetchCharacterData() {
        self.fetchCharacterData { success in
            if success {
                self.filteredCharacter = self.characterData
            } else {
                print("인물사전 데이터 불러오기 실패")
            }
        }
    }
    
    /// 인물사전 전체조회 API 호출
    private func fetchCharacterData(completion: @escaping(Bool) -> Void) {
        TabReadingNoteAPI.shared.fetchAllCharacter(isbn: self.book.isbn) { response in
            switch response {
            case .success(let data):
                if let characterList = data as? [CharacterTapResponse] {
                    self.characterData = characterList.map {
                        Character(
                            emoji: $0.emoji,
                            name: $0.name,
                            preview: $0.preview,
                            description: $0.description
                        )
                    }
                    
                    completion(true)
                }
                
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
    
    /// 인물사전 검색 combine 로직
    func searchCharacterCombine() {
        $searchText
            .removeDuplicates()
            .sink { query in
                self.searchCharacter(searchQuery: query)
            }
            .store(in: &cancellables)
    }
}
