//
//  MainDetailWantToReadMenuView.swift
//  ReadingFrame
//
//  Created by 석민솔 on 7/2/25.
//

import SwiftUI

/// 읽고 싶은 책 리스트 row일 때 메뉴
struct MainDetailWantToReadMenuView: View {
    // MARK: - Properties
    
    // MARK: - View
    var body: some View {
        // MARK: 읽는 중 버튼
        // TODO: 버튼 클릭시 등록 sheet 띄우기
        Button {
            // isRegisterSheetAppear.toggle()
            // sheetReadingStatus = .reading
        } label: {
            Label("읽는 중", systemImage: "book")
        }
        // MARK: 다 읽음 버튼
        // TODO: 버튼 클릭시 등록 sheet 띄우기
        Button {
            // isRegisterSheetAppear.toggle()
            // sheetReadingStatus = .finishRead
        } label: {
            Label("다 읽음", systemImage: "book.closed")
        }
    }
}

#Preview {
    MainDetailWantToReadMenuView()
}
