//
//  ReadingItemDetailView.swift
//  ReadingFrame
//
//  Created by 이윤지 on 3/17/24.
//

import SwiftUI

// TODO: 책 정보랑 액션을 위한 클로저 전달하는 방식으로 수정하기
/// 모든 책 상세 페이지의 리스트에 들어갈 아이템 뷰
struct BookItemDetailView: View {
    // MARK: - Property
    @EnvironmentObject private var coordinator: Coordinator

    /// 받아오는 책정보
    let book: any DetailBookModel
    
    // MARK: - Actions
    // 독서 상태 변경 API 호출
    let changeToFinishReadBook: (String) -> Void
    
    // 소장 여부 변경 API 호출
    var changeIsMine: (String) -> Void
    
    // 읽고 있는 책 숨기기 & 꺼내기 API 호출
    var toggleHiddenReadingBook: (Bool, String) -> Void
    
    // MARK: - State
    @State private var showAlreadyMineAlert = false
    
    // MARK: - View
    var body: some View {
        // 기본 리스트 네비게이션 링크는 자동으로 chevron 추가됨 이슈로 ZStack으로 감싸서 구현
        ZStack(alignment: .topTrailing) {
            VStack(spacing: 0) {
                BookItemDetailContentView(book: book)
                    .padding(.vertical, 16)
                
                Rectangle()
                    .foregroundStyle(.grey2)
                    .frame(height: 1)
            }
            
            Button {
                if book.readingStatus == .wantToRead {
                    coordinator.push(.bookInfo(isbn: book.isbn))
                } else {
                    coordinator.push(.readingNote(isbn: book.isbn))
                }
            } label: {
                Color.clear
                    .contentShape(Rectangle())
            }
            
            // Menu
            BookItemDetailMenuView(
                bookInfo: self.book,
                changeToFinishReadBook: changeToFinishReadBook,
                changeIsMine: changeIsMine,
                toggleHiddenReadingBook: toggleHiddenReadingBook
            )

        }
    }
}

#Preview {
    BookItemDetailView(
        book: WantToReadBookModel(
            isbn: "",
            cover: "",
            title: "제목",
            author: "저자",
            category: .art
        ),
        changeToFinishReadBook: { _ in },
        changeIsMine: { _ in },
        toggleHiddenReadingBook: { _, _ in }
    )
}
