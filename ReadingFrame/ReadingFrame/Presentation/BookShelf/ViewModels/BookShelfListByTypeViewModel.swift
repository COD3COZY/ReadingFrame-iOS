//
//  BookShelfListByTypeViewModel.swift
//  ReadingFrame
//
//  Created by 석민솔 on 6/23/25.
//

import Combine
import Foundation
import Alamofire

class BookShelfListByTypeViewModel: ObservableObject {
    // MARK: - Properties
    /// 서가 종류
    let bookshelfSubtype: BookEnum
    
    // TODO: API 입력받기
    // 현재는 임시데이터
    /// API에서 입력받은 해당 서가의 모든 책정보
    @Published var allBooks: [BookShelfRowInfo] = []
    
    /// 검색어
    @Published var searchQuery = ""
    
    /// 표시할 책들의 정보
    @Published var filteredBooks: [BookShelfRowInfo] = []
    
    /// UserDefault에 저장된 책장 테마색상
    var bookshelfColor: ThemeColor {
        if let themeColor = UserDefaults.standard.string(forKey: "ThemeColor") {
            ThemeColor(rawValue: themeColor) ?? .main
        } else {
            .main
        }
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - init
    init(bookshelfSubtype: BookEnum, searchQuery: String = "") {
        self.bookshelfSubtype = bookshelfSubtype
        
        
        // combine 등록
        searchAsQueryChanges()
    }
    
    // MARK: - Methods
    /// 검색어 변하면 다시 검색시키기
    func searchAsQueryChanges() {
        $searchQuery
            .removeDuplicates()
            .sink { text in
                self.search(query: text)
            }
            .store(in: &cancellables)
    }
    
    /// 제목과 저자로 검색하기
    func search(query: String) {
        if query.isEmpty {
            filteredBooks = allBooks
        } else {
            filteredBooks = allBooks.filter { book in
                book.title.localizedCaseInsensitiveContains(query) ||
                book.author.localizedCaseInsensitiveContains(query)
            }
        }
    }
}
