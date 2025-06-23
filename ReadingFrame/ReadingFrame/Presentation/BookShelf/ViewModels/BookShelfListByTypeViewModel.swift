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
        
        // 정보 조회 API 호출
        fetchBookshelfListData(type: bookshelfSubtype) { isSuccess in
            if !isSuccess {
                print("책장리스트 데이터 조회 실패")
            }
        }
        
        // combine 등록
        searchAsQueryChanges()
    }
    
    // MARK: - Methods
    /// 책장 리스트용 조회 API 호출
    func fetchBookshelfListData(type: BookEnum, completion: @escaping (Bool) -> (Void)) {
        let bookshelfType: String = String(type.code)
        
        BookshelfAPI.shared.getBookshelfListByType(code: bookshelfType) { response in
            switch response {
            case .success(let data):
                if let dtoData = data as? [BookshelfListResponse] {
                    self.allBooks = dtoData.map { data in
                        data.toEntity()
                    }
                    self.filteredBooks = self.allBooks
                    completion(true)
                }
                else {
                    print("데이터 처리과정 이상")
                    completion(false)
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
