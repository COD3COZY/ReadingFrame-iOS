//
//  ReadingNoteViewModel.swift
//  ReadingFrame
//
//  Created by 석민솔 on 10/31/24.
//

import Foundation
import Alamofire
import SwiftUI

/// 독서노트의 뷰모델
class ReadingNoteViewModel: ObservableObject {
    @Published var book: ReadingNoteModel?
    
    /// 해당 책의 isbn값
    var isbn: String
    
    // MARK: - Properties
    
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
        let dummycommentReview: String? = nil
        // 더미 선택리뷰
        let dummyselectReview: [selectReviewCode]? = nil
        
        // 더미 책갈피
        let dummyBookmark: [Bookmark]? = [
            Bookmark(id: "", date: Date(), markPage: 10, markPercent: 14, location: "집")
        ]
        
        // 더미 메모
        let dummyMemo: [Memo]? = nil /*[
            Memo(id: "1", date: Date(), markPage: 32, markPercent: 10, memo: "메모")
        ]*/
        
        // 더미 인물
        let dummyCharacter: [Character]? = nil
        
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
        let newBookmark = Bookmark(id: UUID().uuidString, date: Date(), markPage: book!.totalPage, markPercent: 100, location: "")
        
        book?.bookmarks?.append(newBookmark)
        
        // TODO: 독서상태 변경 API 호출하기
    }
    
    // TODO: 로직 확정하고 반영하기
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
            let newBookmark = Bookmark(id: UUID().uuidString, date: Date(), markPage: page, markPercent: readingPercent, location: "")
            
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

