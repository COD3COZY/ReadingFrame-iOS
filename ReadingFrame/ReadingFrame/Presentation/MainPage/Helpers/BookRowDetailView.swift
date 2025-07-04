//
//  BookRowDetailView.swift
//  ReadingFrame
//
//  Created by 이윤지 on 3/17/24.
//

import SwiftUI

/// 읽고 있는 책, 읽고 싶은 책, 다 읽은 책 상세 페이지의 리스트 뷰
struct BookRowDetailView: View {
    // MARK: - Properties
    /// 독서 상태 여부
    var readingStatus: ReadingStatus
    
    /// 읽고 있는 책, 읽고 싶은 책, 다 읽은 책 뷰모델
    @StateObject var viewModel: DetailBookViewModel
    
    // MARK: - init
    init(readingStatus: ReadingStatus) {
        self.readingStatus = readingStatus
        _viewModel = StateObject(wrappedValue: DetailBookViewModel(readingStatus: readingStatus))
    }
    
    // MARK: - View
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // 검색 바
            SearchBarButtonView()
            .padding(.bottom, 10)
            
            // 타이틀 및 책 개수
            List {
                DetailBookListHeaderView(
                    title: viewModel.title,
                    count: readingStatus == .reading
                    ? viewModel.getUnhiddenBooks().count
                    : viewModel.books.count
                )
                .listRowInsets(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                
                // 책 리스트
                ForEach(viewModel.getUnhiddenBooks(), id: \.isbn) { book in
                    BookItemDetailView(book: book)
                        .swipeActions(edge: .trailing) {
                            deleteBookButton(book: book)
                        }
                        .listRowSeparator(.hidden) // list 구분선 제거
                        .listRowInsets(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                }
                
                
                // 읽는 책일 때) 숨긴 책 섹션
                if (!viewModel.gethiddenBooks().isEmpty && readingStatus == .reading) {
                    // 타이틀
                    DetailBookListHeaderView(
                        title: "홈 화면에서 숨긴 책",
                        count: viewModel.gethiddenBooks().count
                    )
                    .listRowInsets(EdgeInsets(top: 30, leading: 16, bottom: 0, trailing: 16))
                    
                    // 홈 화면에서 숨긴 책 리스트
                    ForEach(viewModel.gethiddenBooks(), id: \.isbn) { book in
                        BookItemDetailView(book: book)
                            .swipeActions(edge: .trailing) {
                                deleteBookButton(book: book)
                            }
                    }
                    .listRowSeparator(.hidden) // list 구분선 제거
                    .listRowInsets(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                }
            }
            .listStyle(.plain)
            .listRowSeparator(.hidden) // list 구분선 제거
            .listRowInsets(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
        }
        // 네비게이션 타이틀 바
        .navigationTitle(viewModel.title)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    
}

extension BookRowDetailView {
    @ViewBuilder
    func deleteBookButton(book: DetailBookModel) -> some View {
        Button(role: .destructive) {
            // 책 삭제 API 호출
            viewModel.deleteBook(isbn: book.isbn) { success in
                if success {
                    viewModel.deleteBookInList(book: book)
                }
            }
        } label: {
            Image(systemName: "trash.fill")
        }
        .tint(.red0)
    }
}
