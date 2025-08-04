//
//  BookItemDetailMenuView.swift
//  ReadingFrame
//
//  Created by 석민솔 on 7/2/25.
//

import SwiftUI

/// 독서상태에 맞는 메뉴 만들어주는 뷰
struct BookItemDetailMenuView: View {
    // MARK: - Properties
    let bookInfo: DetailBookModel
    
    @State var showAlreadyMineAlert: Bool = false
    @State var showFinishReadAlert: Bool = false
    @State var showHideBookAlert: Bool = false
        
    // actions
    let changeToFinishReadBook: (String) -> Void
    let changeIsMine: (String) -> Void
    let toggleHiddenReadingBook: (Bool, String) -> Void
    
    // MARK: - View
    var body: some View {
        Menu {
            switch bookInfo.readingStatus {
            case .wantToRead:
                MainDetailWantToReadMenuView(
                    isbn: self.bookInfo.isbn
                )
            case .reading:
                MainDetailReadingMenuView(
                    bookInfo: bookInfo as! ReadingBookModel,
                    changeToFinishReadBook: changeToFinishReadBook,
                    changeIsMine: changeIsMine,
                    toggleHiddenReadingBook: toggleHiddenReadingBook,
                    showAlreadyMineAlert: { showAlreadyMineAlert.toggle() },
                    showFinishReadAlert: { showFinishReadAlert.toggle() },
                    showHideBookAlert: { showHideBookAlert.toggle() }
                )
            case .finishRead:
                MainDetailFinishReadMenuView(
                    bookInfo: bookInfo as! FinishReadBookModel,
                    changeIsMine: changeIsMine,
                    showAlreadyMineAlert: {
                        showAlreadyMineAlert.toggle()
                    }
                )
            case .unregistered:
                EmptyView()
            }
        } label: {
            Image(systemName: "ellipsis")
                .font(.subheadline)
                .foregroundStyle(.black0)
                .frame(minWidth: 32, minHeight: 32)
        }
        // 메뉴인식범위 넓게 해서 불편하지 않도록
        .frame(minWidth: 50, minHeight: 50, alignment: .topTrailing)
        .contentShape(Rectangle())
        // alerts
        .alert("이미 소장된 책입니다", isPresented: $showAlreadyMineAlert) {
            Button("확인", role: .cancel) { }
        }
        .alert("책을 다 읽으셨나요?", isPresented: $showFinishReadAlert) {
            Button {
                // 다읽은 책으로 변경하기 API 호출
                changeToFinishReadBook(self.bookInfo.isbn)
            } label: {
                Text("확인")
            }

        } message: {
            Text("다 읽은 책으로 표시됩니다")
        }
        .alert("읽는 중인 책을 숨깁니다", isPresented: $showHideBookAlert) {
            Button("취소", role: .cancel) {}
            Button("확인", role: .cancel) {
                // 읽고 있는 책 숨기기 API 호출
                toggleHiddenReadingBook(true, bookInfo.isbn)
            }
        } message: {
            Text("읽는 중인 책 전체보기에서 확인하실 수 있습니다")
        }
    }
}
