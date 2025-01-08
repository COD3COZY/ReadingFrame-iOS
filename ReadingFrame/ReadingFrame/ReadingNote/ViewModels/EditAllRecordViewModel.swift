//
//  EditAllRecordViewModel.swift
//  ReadingFrame
//
//  Created by 석민솔 on 12/23/24.
//

import Foundation
import MapKit

class EditAllRecordViewModel: ObservableObject {
    // MARK: - Properties
    /// 책 객체
    @Published var book: EditRecordBookModel

    /// 책갈피 / 메모 / 인물사전 결정하는 탭
    @Published var selectedTab: String = "책갈피"
    
    /// 선택한 날짜
    @Published var selectedDate = Date()
    
    /// 날짜 범위
    var dateRange: ClosedRange<Date> {
        DateRange().dateRange(date: selectedDate)
    }
    
    // MARK: 책갈피 관련
    /// 선택된 위치
    @Published var pickedPlace: MKPlacemark? = nil
    
    /// 사용자가 입력한 책갈피 페이지
    @Published var bookMarkPage: String = ""
    
    // MARK: 메모 관련
    /// 사용자가 입력한 메모
    @Published var inputMemo = ""
    
    // MARK: 인물사전 관련
    /// 사용자가 선택한 인물 이모지
    @Published var characterEmoji: String = "😀"
    
    /// 사용자가 입력한 인물 이름
    @Published var characterName: String = ""
    
    /// 사용자가 입력한 한줄 소개
    @Published var characterPreview: String = ""
    
    /// 사용자가 입력한 인물사전 메모
    @Published var characterDescription: String = ""
    
    // MARK: - init
    init(book: EditRecordBookModel,
         selectedTab: String = "책갈피",
         selectedDate: Date = Date(),
         pickedPlace: MKPlacemark? = nil,
         bookMarkPage: String = "",
         inputMemo: String = "",
         characterEmoji: String = "😀",
         characterName: String = "",
         characterPreview: String = "",
         characterDescription: String = "") {
        self.book = book
        self.selectedTab = selectedTab
        self.selectedDate = selectedDate
        self.pickedPlace = pickedPlace
        self.bookMarkPage = bookMarkPage
        self.inputMemo = inputMemo
        self.characterEmoji = characterEmoji
        self.characterName = characterName
        self.characterPreview = characterPreview
        self.characterDescription = characterDescription
    }
    
    // MARK: Methods
    /// 탭이 바뀔 경우, 기존에 입력된 정보 초기화시키기
    func changeTab() {
        self.selectedDate = Date()
        self.bookMarkPage = ""
        self.inputMemo = ""
        self.characterName = ""
        self.characterPreview = ""
        self.characterDescription = ""
    }
}
