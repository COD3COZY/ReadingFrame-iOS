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
    @State var isRegisterSheetAppear: Bool = false
    @State var sheetReadingStatus: ReadingStatus = .reading
    let isbn: String
    
    // MARK: - View
    var body: some View {
        VStack {
            // 읽는 중 버튼: 등록 sheet 띄우기
            Button {
                sheetReadingStatus = .reading
                isRegisterSheetAppear.toggle()
            } label: {
                Label("읽는 중", systemImage: "book")
            }
            // 다 읽음 버튼: 등록 sheet 띄우기
            Button {
                sheetReadingStatus = .finishRead
                isRegisterSheetAppear.toggle()
            } label: {
                Label("다 읽음", systemImage: "book.closed")
            }
        }
        .sheet(isPresented: $isRegisterSheetAppear) {
            RegisterBook(
                isSheetAppear: $isRegisterSheetAppear,
                readingStatus: $sheetReadingStatus,
                isbn: self.isbn
            )
        }
    }
}

#Preview {
    MainDetailWantToReadMenuView(isbn: "")
}
