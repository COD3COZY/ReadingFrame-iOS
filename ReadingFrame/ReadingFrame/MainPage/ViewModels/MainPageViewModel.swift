//
//  MainPageViewModel.swift
//  ReadingFrame
//
//  Created by 이윤지 on 10/2/24.
//

import Foundation

/// 홈 화면의 뷰모델
final class MainPageViewModel: ObservableObject {
    /// 읽고 있는 책 개수
    @Published var readingBooksCount: Int = 0
    
    /// 읽고 싶은 책 개수
    @Published var wantToReadBooksCount: Int = 0
    
    /// 다 읽은 책 개수
    @Published var finishReadBooksCount: Int = 0
    
    /// 읽고 있는 책 리스트
    @Published var homeReadingBooks: [HomeBookModel]? = []
    
    /// 읽고 싶은 책 리스트
    @Published var homeWantToReadBooks: [HomeBookModel]? = []
    
    /// 다 읽은 책 리스트
    @Published var homeFinishReadBooks: [HomeBookModel]? = []
    
    init() {
        getHome { isSuccess in
            if !isSuccess {
                // TODO: 실패 로직 작성
                print("홈 조회 실패")
            }
        }
    }
    
    /// 숨김 처리 하지 않은 읽고 있는 책 리스트
    func notHiddenReadingBooksList() -> [HomeBookModel] {
        homeReadingBooks?.filter { !($0.isHidden ?? false) } ?? []
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
                        let homeBooksList = tempList.map { list in
                            HomeBookModel(
                                readingStatus: self.convertReadingStatus(from: list.readingStatus),
                                isbn: list.isbn,
                                cover: list.cover,
                                title: list.title,
                                author: list.author,
                                readingPercent: list.readingPercent ?? 0,
                                totalPage: list.totalPage ?? 0,
                                readPage: list.readPage ?? 0,
                                isHidden: false,
                                isMine: list.isMine ?? false,
                                isWriteReview: list.isWriteReview ?? false,
                                bookType: BookType(rawValue: list.bookType ?? -1)
                            )
                        }
                        
                        self.homeReadingBooks = homeBooksList.filter { $0.readingStatus == .reading }
                        self.homeWantToReadBooks = homeBooksList.filter { $0.readingStatus == .wantToRead }
                        self.homeFinishReadBooks = homeBooksList.filter { $0.readingStatus == .finishRead }
                        
                        self.readingBooksCount = data.readingBooksCount
                        self.wantToReadBooksCount = data.wantToReadBooksCount
                        self.finishReadBooksCount = self.homeFinishReadBooks?.count ?? 0
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
