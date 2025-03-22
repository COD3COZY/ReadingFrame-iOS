//
//  ReadingNoteViewModel.swift
//  ReadingFrame
//
//  Created by 석민솔 on 10/31/24.
//

import Foundation
import Alamofire
import SwiftUI
import MapKit

/// 독서노트의 뷰모델
class ReadingNoteViewModel: ObservableObject {
    // MARK: - Properties
    @Published var book: ReadingNoteModel?
    
    /// 해당 책의 isbn값
    var isbn: String
    
    /// 시작 날짜: 옵셔널 book을 위한 커스텀 Binding 생성
    var startDateBinding: Binding<Date> {
        Binding<Date>(
            get: { self.book?.startDate ?? Date() },
            set: { self.book?.startDate = $0 }
        )
    }
    
    /// 최근 날짜: 옵셔널 book을 위한 커스텀 Binding 생성
    var recentDateBinding: Binding<Date> {
        Binding<Date>(
            get: { self.book?.recentDate ?? Date() },
            set: { self.book?.recentDate = $0 }
        )
    }
    
    // MARK: - init()
    init(isbn: String) {
        self.isbn = isbn
        fetchData()
    }
    
    
    // MARK: - Methods
    
    /// 서버에서 데이터 가져오기
    // TODO: 서버에서 데이터 가져오는 방식으로 바꾸기
    // 지금은 일단 객체 초기화로
    func fetchData() {
        // 더미 키워드리뷰
        let dummykeywordReview: String? = nil
        // 더미 한줄평
        let dummycommentReview: String? = "베스트셀러 도서라고 언급이 많길래 한 번 읽어 봤는데 정말 재미있었습니다. 왜 베스트셀러인지 알 것 같았어요. 한 번쯤 꼭 보시길 추천합니다!"
        // 더미 선택리뷰
        let dummyselectReview: [selectReviewCode]? = [.comforting, .easyToRead]
        
        // 더미 책갈피
        let dummyBookmark: [Bookmark]? = [
            Bookmark(id: "", date: Date(), markPage: 10, markPercent: 14)
        ]
        
        // 더미 메모
        let dummyMemo: [Memo]? = nil /*[
            Memo(id: "1", date: Date(), markPage: 32, markPercent: 10, memo: "메모")
        ]*/
        
        // 더미 인물
        let dummyCharacter: [Character]? = [
            Character(emoji: 129401, name: "얼굴", preview: "슬픈 얼굴이지요 너무 슬퍼서 울고 있는 얼굴입니다", description: "어쩌구룰루"),
            Character(emoji: 129401, name: "얼굴", preview: "슬픈 얼굴이지요 너무 슬퍼서 울고 있는 얼굴입니다", description: "어쩌구룰루"),
            Character(emoji: 129401, name: "얼굴", preview: "슬픈 얼굴이지요 너무 슬퍼서 울고 있는 얼굴입니다", description: "어쩌구룰루"),
        ]
        
        // 하루 전 날짜 가져오기
        let calendar = Calendar.current
        let weekBefore = calendar.date(byAdding: .day, value: -7, to: Date())   // 일주일전
        let yesterday = calendar.date(byAdding: .day, value: -1, to: Date())    // 어제
        
        self.book = ReadingNoteModel(cover: "https://image.yes24.com/goods/96565175/XL",
                                     title: "사이보그가 되다",
                                     author: "김초엽, 김원영",
                                     categoryName: .humanSocial,
                                     totalPage: 380, readPage: 38,
                                     readingPercent: 10,
                                     firstReviewDate: Date(),
                                     keywordReview: dummykeywordReview,
                                     commentReview: dummycommentReview,
                                     selectReview: dummyselectReview,
                                     isMine: false,
                                     bookType: .paperbook,
                                     readingStatus: .reading,
                                     mainLocation: nil,
                                     startDate: weekBefore!,
                                     recentDate: yesterday!,
                                     bookmarks: dummyBookmark,
                                     memos: dummyMemo,
                                     characters: dummyCharacter)
    }
    
    /// 소장여부 바꾸기: 소장 <-> 비소장
    func toggleIsMine() {
        book?.isMine.toggle()
    }
    
    /// 리뷰 수정을 위한 리뷰 객체 리턴
    func getReview() -> Review {
        let review = Review()
        
        if let selectReview = book?.selectReview {
            review.selectReviews = selectReview
        }
        
        if let reviewDate = book?.firstReviewDate {
            review.reviewDate = reviewDate
        }
        
        review.keyword = book?.keywordReview
        review.comment = book?.commentReview
        
        return review
    }
    
    // MARK: 위치 변경 관련
    /// 위치 변경 처리
    func modifyLocation(isRegistering: Bool, place: MKPlacemark) {
        print("modifyLocation 호출")
        
        // 위치 등록 API 호출(POST)
        if isRegistering {
            postMainLocation()
        }
        // 위치 변경 API 호출(PATCH)
        else {
            patchMainLocation()
        }
        
        // 독서노트 UI에도 위치명 보이도록
        self.book?.mainLocation = place.name
    }
    
    // TODO: 아래 대표위치 API 호출 코드 채워넣기
    /// 책별대표위치 등록 API 호출
    func postMainLocation() {
        print("책별대표위치 등록")
    }
    
    /// 책별대표위치 수정/변경 API 호출
    func patchMainLocation() {
        print("책별대표위치 수정/변경")
    }
    
    
    // MARK: 독서상태(reading status) 변경 관련
    /// 책 다읽음 상태로 바꾸기
    func turnToFinishRead() {
        // readingStatus = finishRead
        book?.readingStatus = .finishRead
        
        // 마지막 읽은 날짜 버튼 누르는 당일로 수정
        book?.recentDate = Date()
        
        // readingPercent 100%로 수정
        book?.readingPercent = 100
        
        // readPage도 전체 페이지 수와 동일하게 처리
        if let totalPage = book?.totalPage {
            book?.readPage = totalPage
        }
        
        // 버튼 누르는 당일 시간으로 100% 책갈피 하나 추가
        let newBookmark = Bookmark(id: UUID().uuidString, date: Date(), markPage: book!.totalPage, markPercent: 100)
        
        book?.bookmarks?.append(newBookmark)
        
        // TODO: 독서상태 변경 API 호출하기
    }
    
    /// 책 읽는중 상태로 바꾸기
    func turnToReading(p: Int?) {
        // TODO: 독서상태 변경 API 호출하기

        // readingStatus = reading
        book?.readingStatus = .reading
        
        // 마지막 읽은 날짜 버튼 누르는 당일로 수정
        book?.recentDate = Date()
        
        
        // 입력한 페이지 수 있으면 그 페이지로 책갈피 추가, 독서 진행률 적용
        if let page = p {
            // 독서 진행률 변경
            let readingPercent: Int = page * 100 / book!.totalPage
            
            book?.readingPercent = readingPercent
            book?.readPage = page
            
            // 책갈피 추가
            let newBookmark = Bookmark(id: UUID().uuidString, date: Date(), markPage: page, markPercent: readingPercent)
            
            book?.bookmarks?.append(newBookmark)
            
            // TODO: 책갈피 추가 API 호출하기
            
        // 따로 입력한 페이지 수 없으면 0페이지로 돌아가기
        } else {
            book?.readingPercent = 0
            book?.readPage = 0
        }
        
    }
    
    // MARK: 책유형 관련
    /// 책 유형 변경하기
    func changeBookType(to bookType: BookType) {
        // 화면상에서 바꾸기
        self.book?.bookType = bookType
        
        // TODO: 책유형 변경 API 호출하기
    }
    
}

