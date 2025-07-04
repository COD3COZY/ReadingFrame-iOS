//
//  ReadingBooksViewModel.swift
//  ReadingFrame
//
//  Created by 이윤지 on 10/14/24.
//

import Foundation

/// 읽고 있는 책, 다 읽은 책, 읽고 싶은 책 조회 뷰모델
final class DetailBookViewModel: ObservableObject {
    // MARK: - Properties
    /// 조회할 책 유형
    private var readingStatus: ReadingStatus
    
    /// 조회할 책 리스트
    @Published var books: [any DetailBookModel] = []
    
    /// 페이지 제목
    var title: String {
        if (readingStatus == .reading) {
            return "읽고 있는 책"
        }
        else if (readingStatus == .wantToRead) {
            return "읽고 싶은 책"
        }
        else {
            return "다 읽은 책"
        }
    }
    
    // MARK: - init
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
    
    // MARK: - Methods
    /// 숨긴 책 리스트(읽고 있는 책)
    func gethiddenBooks() -> [ReadingBookModel] {
        if readingStatus == .reading, let books = self.books as? [ReadingBookModel] {
            return books.filter { $0.isHidden == true }
        }
        
        return []
    }

    /// 숨기지 않은 책 리스트(읽고 있는 책)
    func getUnhiddenBooks() -> [DetailBookModel] {
        if readingStatus == .reading, let books = self.books as? [ReadingBookModel] {
            return books.filter { $0.isHidden == false }
        }
        
        return books
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
    func deleteBookInList(book: DetailBookModel) {
        books.removeAll {
            $0.isbn == book.isbn
        }
    }
    
    /// 읽고 있는 책 조회
    private func getReadingBooks(completion: @escaping (Bool) -> (Void)) {
        HomeAPI.shared.getReadingBooks { response in
            switch response {
            case .success(let data):
                if let books = data as? [ReadingBookResponse] {
                    self.books = books.map { book in
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
                    self.books = books.map { book in
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
                    self.books = books.map { book in
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
