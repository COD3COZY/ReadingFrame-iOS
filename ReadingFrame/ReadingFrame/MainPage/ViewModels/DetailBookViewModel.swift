//
//  ReadingBooksViewModel.swift
//  ReadingFrame
//
//  Created by 이윤지 on 10/14/24.
//

import Foundation

/// 읽고 있는 책, 다 읽은 책, 읽고 싶은 책 조회 뷰모델
final class DetailBookViewModel: ObservableObject {
    /// 조회할 책 유형
    private var readingStatus: ReadingStatus
    
    /// 읽고 있는 책 리스트
    @Published var readingBooks: [ReadingBookModel] = []
    
    /// 읽고 싶은 책 리스트
    @Published var wantToReadBooks: [WantToReadBookModel] = []
    
    /// 다 읽은 책 리스트
    @Published var finishReadBooks: [FinishReadBookModel] = []
    
    init(readingStatus: ReadingStatus) {
        self.readingStatus = readingStatus
        
        // 값에 따른 상세 책 조회 API 호출
        switch readingStatus {
        case .reading:
            getReadingBooks { isSuccess in
                if !isSuccess {
                    // TODO: 실패 로직 작성
                    print("읽고있는 책 조회 실패")
                }
            }
        case .wantToRead:
            getWantToReadBooks { isSuccess in
                if !isSuccess {
                    // TODO: 실패 로직 작성
                    print("읽고 싶은 책 조회 실패")
                }
            }
        case .finishRead:
            getFinishReadBooks { isSuccess in
                if !isSuccess {
                    // TODO: 실패 로직 작성
                    print("다 읽은 책 조회 실패")
                }
            }
        case .unregistered: break
        }
    }
    
    /// 독서 상태가 바뀌지 않은 책 리스트
    func tempBookList(books: [RegisteredBook], readingStatus: ReadingStatus) -> [RegisteredBook] {
        books.filter { $0.book.readingStatus == readingStatus }
    }

    /// 숨긴 책 리스트(읽고 있는 책)
    func hideBookList() -> [ReadingBookModel] {
        readingBooks.filter { $0.isHidden == true }
    }

    /// 숨기지 않은 책 리스트(읽고 있는 책)
    func notHideBookList() -> [ReadingBookModel] {
        readingBooks.filter { $0.isHidden == false }
    }
    
    /// CategoryName값 변환 함수
    private func convertCategoryName(from category: Int) -> CategoryName {
        return CategoryName(rawValue: category) ?? .etc
    }
    
    /// BookType값 변환 함수
    private func convertBookType(from type: Int) -> BookType {
        return BookType(rawValue: type) ?? .paperbook
    }
    
    /// 읽고 있는 책 리스트 내의 책을 삭제하는 함수
    func deleteBookInList(isbn: String) {
        if let index = readingBooks.firstIndex(where: { $0.isbn == isbn }) {
            readingBooks.remove(at: index)
        }
    }
    
    /// 책 유형에 따른 책 기본 정보 반환 함수
    func getBookInfo(_ readingStatus: ReadingStatus, _ bookIndex: Int) -> (String, String, String) {
        if readingStatus == .reading {
            let book = readingBooks[bookIndex]
            return (book.cover, book.title, book.author)
        }
        else if readingStatus == .wantToRead {
            let book = wantToReadBooks[bookIndex]
            return (book.cover, book.title, book.author)
        }
        else {
            let book = finishReadBooks[bookIndex]
            return (book.cover, book.title, book.author)
        }
    }
    
    /// 책 유형에 다른 배지 정보 반환 함수
    func getBookBadge(readingStatus: ReadingStatus, bookIndex: Int) -> (BookType?, CategoryName, Bool) {
        if readingStatus == .reading {
            let book = readingBooks[bookIndex]
            return (book.bookType, book.category, book.isMine)
        }
        else if readingStatus == .wantToRead {
            return (nil, wantToReadBooks[bookIndex].category, false)
        }
        else {
            let book = finishReadBooks[bookIndex]
            return (book.bookType, book.category, book.isMine)
        }
    }
    
    /// 읽고 있는 책 조회
    private func getReadingBooks(completion: @escaping (Bool) -> (Void)) {
        HomeAPI.shared.getReadingBooks { response in
            switch response {
            case .success(let data):
                if let books = data as? [ReadingBookResponse] {
                    self.readingBooks = books.map { book in
                        ReadingBookModel(
                            isbn: book.isbn,
                            cover: book.cover,
                            title: book.title,
                            author: book.author,
                            readingPercent: book.readingPercent,
                            totalPage: book.totalPage,
                            readPage: book.readPage,
                            isHidden: book.isHidden,
                            category: self.convertCategoryName(from: book.category),
                            bookType: self.convertBookType(from: book.bookType),
                            isMine: book.isMine,
                            isWriteReview: book.isWriteReview
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
    
    /// 읽고 싶은 책 조회
    private func getWantToReadBooks(completion: @escaping (Bool) -> (Void)) {
        HomeAPI.shared.getWantToReadBooks { response in
            switch response {
            case .success(let data):
                if let books = data as? [WantToReadBookResponse] {
                    self.wantToReadBooks = books.map { book in
                        WantToReadBookModel(
                            isbn: book.isbn,
                            cover: book.cover,
                            title: book.title,
                            author: book.author,
                            category: self.convertCategoryName(from: book.category)
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
    
    /// 다 읽은 책 조회
    private func getFinishReadBooks(completion: @escaping (Bool) -> (Void)) {
        HomeAPI.shared.getFinishReadBooks { response in
            switch response {
            case .success(let data):
                if let books = data as? [FinishReadBookResponse] {
                    self.finishReadBooks = books.map { book in
                        FinishReadBookModel(
                            isbn: book.isbn,
                            cover: book.cover,
                            title: book.title,
                            author: book.author,
                            category: self.convertCategoryName(from: book.category),
                            bookType: self.convertBookType(from: book.bookType),
                            isMine: book.isMine,
                            isWriteReview: book.isWriteReview
                        )
                    }
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
    
    /// 책 삭제
    func deleteBook(isbn: String, completion: @escaping (Bool) -> (Void)) {
        HomeAPI.shared.deleteBook(isbn: isbn) { response in
            switch response {
            case .success(let data):
                print("책 삭제 성공 \(data)")
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
    
    /// 읽고 있는 책 숨기기&꺼내기
    func hiddenReadBook(isbn: String, request: HiddenReadBookRequest, completion: @escaping (Bool) -> (Void)) {
        HomeAPI.shared.hiddenReadBook(isbn: isbn, request: request) { response in
            switch response {
            case .success(let data):
                print("읽고 있는 책 숨김 여부 변경 성공 \(data)")
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
    
    /// 독서 상태 변경
    func changeReadingStatus(isbn: String, request: ChangeReadingStatusRequest, completion: @escaping (Bool) -> (Void)) {
        HomeAPI.shared.changeReadingStatus(isbn: isbn, request: request) { response in
            switch response {
            case .success(let data):
                print("독서 상태 변경 성공 \(data)")
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
    
    /// 소장 여부 변경
    func changeIsMine(isbn: String, request: ChangeIsMineRequest, completion: @escaping (Bool) -> (Void)) {
        HomeAPI.shared.changeIsMine(isbn: isbn, request: request) { response in
            switch response {
            case .success(let data):
                print("소장 여부 변경 성공 \(data)")
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
}
