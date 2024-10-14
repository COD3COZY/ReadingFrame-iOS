//
//  MainPageViewModel.swift
//  ReadingFrame
//
//  Created by 이윤지 on 10/2/24.
//

import Foundation

/// 홈 화면의 뷰모델
final class MainPageViewModel: ObservableObject {
    /// 다 읽은 책 개수
    @Published var finishReadBooksCount: Int = 0
    
    /// 읽고 싶은 책 개수
    @Published var wantToReadBooksCount: Int = 0
    
    /// 읽고 있는 책 개수
    @Published var readingBooksCount: Int = 0
    
    /// 전체 책 리스트
    @Published var homeBooksList: [RegisteredBook] = []
    
    /// 읽고 있는 책 리스트
    @Published var homeReadingBooks: [RegisteredBook] = []
    
    /// 읽고 싶은 책 리스트
    @Published var homeWantToReadBooks: [RegisteredBook] = []
    
    /// 다 읽은 책 리스트
    @Published var homeFinishReadBooks: [RegisteredBook] = []
    
    init() {
        getHome { isSuccess in
            // 실패했을 경우
            if !isSuccess {
                
            }
        }
    }
    
    /// 숨김 처리 하지 않은 읽고 있는 책 리스트
    func notHiddenReadingBooksList() -> [RegisteredBook] {
        homeReadingBooks.filter { !$0.isHidden }
    }
    
    // 독서 상태가 바뀌지 않은 책 리스트
    var tempBookList(readingStatus: ReadingStatus) -> [RegisteredBook] {
        bookList.filter { $0.book.readingStatus == readingStatus }
    }
    
    // 홈 화면에서 숨긴 책 리스트
    var hideBookList: [RegisteredBook] {
        bookList.filter { $0.isHidden == true && $0.book.readingStatus == readingStatus}
    }
    
    // 홈 화면에서 숨기지 않은 책 리스트
    var notHideBookList: [RegisteredBook] {
        bookList.filter { $0.isHidden == false && $0.book.readingStatus == readingStatus }
    }
    
    /// ReadingStatus값 변환 함수
    private func convertReadingStatus(from status: Int) -> ReadingStatus {
        return ReadingStatus(rawValue: status) ?? .unregistered
    }
    
    /// 홈 조회
    private func getHome(completion: @escaping (Bool) -> (Void)) {
        HomeAPI.shared.getHome { response in
            switch response {
            case .success(let data):
                if let data = data as? HomeResponse {
                    if let tempList = data.booksList {
                        self.homeBooksList = tempList.map { list in
                            RegisteredBook(
                                book: InitialBook(
                                    ISBN: list.isbn,
                                    cover: list.cover,
                                    title: list.title,
                                    author: list.author,
                                    totalPage: list.totalPage ?? 0,
                                    readingStatus: self.convertReadingStatus(from: list.readingStatus)
                                ),
                                isMine: list.isMine ?? false,
                                readingPercent: list.readingPercent ?? 0,
                                readPage: list.readPage ?? 0
                            )
                        }
                    }
                    
                    self.homeReadingBooks = self.homeBooksList.filter { $0.book.readingStatus == .reading }
                    self.homeWantToReadBooks = self.homeBooksList.filter { $0.book.readingStatus == .wantToRead }
                    self.homeFinishReadBooks = self.homeBooksList.filter { $0.book.readingStatus == .finishRead }
                    
                    self.readingBooksCount = data.readingBooksCount
                    self.wantToReadBooksCount = data.wantToReadBooksCount
                    self.finishReadBooksCount = self.homeFinishReadBooks.count
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
            }
        }
    }
}
