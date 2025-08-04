//
//  BookInfoViewModel.swift
//  ReadingFrame
//
//  Created by 석민솔 on 3/24/25.
//

import Foundation

class BookInfoViewModel: ObservableObject {
    // MARK: - Properties
    /// 독서상태
    @Published var readingStatus: ReadingStatus
    
    /// 독서상태 제외한 책정보
    @Published var bookInfo: BookInfoModel?
    
    /// 선택리뷰
    var selectReviews: [SelectReviewCode] {
        return bookInfo?.selectedReviewList ?? []
    }
    
    /// 한줄평덜
    var comments: [CompactComment] {
        return bookInfo?.commentList ?? []
    }
    
    /// readingStatus값 따라서 독서노트 있는지 아닌지 알려주는 변수
    ///
    /// - 미등록, 읽고싶은 : 하트 버튼, 내서재 추가하기 조합
    /// - 읽는중, 다읽음: 독서노트로 이동하기버튼이냐
    var haveReadingNote: Bool {
        switch readingStatus {
        case .unregistered, .wantToRead:    // 독서노트 없음
            return false
        case .reading, .finishRead:         // 독서노트 있음
            return true
        }
    }

    
    // MARK: - init
    init(isbn: String) {
        self.readingStatus = .unregistered
        fetchBookInfoData(isbn: isbn) { isSuccess in
            if !isSuccess {
                print("도서정보 조회 실패")
            }
        }
    }
    
    // MARK: - Methods
    /// 도서정보 초기조회 API 호출
    func fetchBookInfoData(isbn: String, completion: @escaping (Bool) -> (Void)) {
//        self.bookInfo = BookInfoModel(isbn: isbn, cover: "이미지", title: "제목", author: "작가", categoryName: .art, publisher: "출판사", publicationDate: "25.5.2", totalPage: 130, description: "히가시노 게이고의 가장 경이로운 대표작", commentCount: 0, selectedReviewList: [], commentList: [])
        
        // isbn을 이용해서 도서정보 초기조회 API 호출하기
        BookInfoAPI.shared.getBookInfo(isbn: isbn) { response in
            switch response {
            case .success(let data):
                if let data = data as? BookInfoResponse {
                    self.bookInfo = data.toEntity(isbn: isbn)
                    self.readingStatus = ReadingStatus(rawValue: data.readingStatus) ?? .unregistered
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
    
    /// 읽고싶은 책 등록 API 호출
    func postWantToRead() {
        if let bookInfo = self.bookInfo {
            let isbn = bookInfo.isbn
            
            let request = WantToReadRegisterRequest(
                cover: bookInfo.cover,
                title: bookInfo.title,
                author: bookInfo.author,
                categoryName: bookInfo.categoryName.name,
                totalPage: bookInfo.totalPage,
                publisher: bookInfo.publisher,
                publicationDate: bookInfo.publicationDate
            )
            
            // isbn을 이용해서 읽고싶은 책 등록 API 호출하기
            BookInfoAPI.shared.postWantToRead(isbn: isbn, request: request) { response in
                switch response {
                case .success(let data):
                    print("읽고싶은 책 등록 성공 \(data)")
                    self.readingStatus = .wantToRead
                    
                case .requestErr(let message):
                    print("Request Err: \(message)")
                case .pathErr:
                    print("Path Err")
                case .serverErr(let message):
                    print("Server Err: \(message)")
                case .networkFail(let message):
                    print("Network Err: \(message)")
                case .unknown(let error):
                    print("Unknown Err: \(error)")
                }
            }
        }
        else {
            print("책정보 없어서 API 호출 불가넝")
        }
    }
    
    /// 읽고싶은 책 취소 API 호출
    func cancelWantToRead() {
        if let bookInfo = self.bookInfo {
            BookInfoAPI.shared.cancelWantToRead(
                isbn: bookInfo.isbn,
                request: ChangeReadingStatusRequest(
                    readingStatus: ReadingStatus.unregistered.rawValue
                )
            ) { response in
                    switch response {
                    case .success(let data):
                        print("읽고싶은 책 취소 성공 \(data)")
                        self.readingStatus = .unregistered
                        
                    case .requestErr(let message):
                        print("Request Err: \(message)")
                    case .pathErr:
                        print("Path Err")
                    case .serverErr(let message):
                        print("Server Err: \(message)")
                    case .networkFail(let message):
                        print("Network Err: \(message)")
                    case .unknown(let error):
                        print("Unknown Err: \(error)")
                    }
                }
        }
        else {
            print("책정보 없어서 API 호출 불가넝")
        }
    }
}
