//
//  MainDetailFinishReadMenuView.swift
//  ReadingFrame
//
//  Created by 석민솔 on 7/2/25.
//

import SwiftUI

/// 다읽은 책  리스트 row일 때 메뉴
struct MainDetailFinishReadMenuView: View {
    // MARK: - Properties
    let bookInfo: FinishReadBookModel
    let changeIsMine: (String) -> Void
    let showAlreadyMineAlert: () -> Void
    
    // MARK: - View
    var body: some View {
        // 정보 버튼
        MainDetailMenuButton_InfoNavigation(isbn: self.bookInfo.isbn)
        
        // 소장 버튼
        Button {
            if bookInfo.isMine {
                showAlreadyMineAlert()
            } else {
                changeIsMine(bookInfo.isbn)
            }
        } label: {
            Label("소장", systemImage: "square.and.arrow.down")
        }
        
        // 리뷰 남기기 or 확인하기 버튼
        if self.bookInfo.isWriteReview {
            MainDetailMenuButton_ReadReview(isbn: self.bookInfo.isbn)
        }
        else {
            MainDetailMenuButton_WriteReview()
        }
    }
}
