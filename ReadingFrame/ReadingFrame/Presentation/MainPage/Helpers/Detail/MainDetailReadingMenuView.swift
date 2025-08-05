//
//  MainDetailReadingMenuView.swift
//  ReadingFrame
//
//  Created by 석민솔 on 7/2/25.
//

import SwiftUI

/// 읽고있는 책 리스트 row일 때  메뉴
struct MainDetailReadingMenuView: View {
    // MARK: - Properties
    let bookInfo: ReadingBookModel
    
    // actions
    /// 다읽은 책으로 변경하기 API 호출
    let changeToFinishReadBook: (String) -> Void
    /// 소장여부 변경 API 호출
    let changeIsMine: (String) -> Void
    /// 읽고 있는 책 꺼내기 & 숨기기 API 호출
    let toggleHiddenReadingBook: (Bool, String) -> Void
    /// 이미 소장한 책 Alert 표시
    let showAlreadyMineAlert: () -> Void
    /// 다읽은 책으로 표시할지 Alert 표시
    let showFinishReadAlert: () -> Void
    /// 홈화면에서 숨기기 Alert 표시
    let showHideBookAlert: () -> Void

    // MARK: - View
    var body: some View {
        // MARK: 다 읽음 버튼: 다읽은 책으로 표시할지 Alert 띄우기
        Button {
            showFinishReadAlert()
        } label: {
            Label("다 읽음", systemImage: "book.closed")
        }

        // MARK: 정보 버튼
        MainDetailMenuButton_InfoNavigation(isbn: self.bookInfo.isbn)

        // MARK: 리뷰 남기기 or 확인하기 버튼
        if self.bookInfo.isWriteReview {
            // 리뷰 확인하기: 독서노트 화면 연결
            MainDetailMenuButton_ReadReview(isbn: self.bookInfo.isbn)
        } else {
            // 리뷰 남기기: 리뷰 생성 화면으로 Navigate
            MainDetailMenuButton_WriteReview()
        }

        // MARK: 소장 버튼
        Button {
            if bookInfo.isMine {
                showAlreadyMineAlert()
            } else {
                changeIsMine(bookInfo.isbn)
            }
        } label: {
            Label("소장", systemImage: "square.and.arrow.down")
        }

        // MARK: 꺼내기 or 홈 화면에서 숨기기 버튼
        if bookInfo.isHidden {
            Button {
                // 읽고 있는 책 꺼내기 API 호출
                toggleHiddenReadingBook(false, bookInfo.isbn)
                
            } label: {
                Label("꺼내기", systemImage: "tray.and.arrow.up")
            }
        } else {
            Button {
                showHideBookAlert()
            } label: {
                Label("홈 화면에서 숨기기", systemImage: "eye.slash")
            }
        }        
    }
}
