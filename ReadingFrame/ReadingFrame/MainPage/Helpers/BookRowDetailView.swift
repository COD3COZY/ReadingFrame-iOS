//
//  BookRowDetailView.swift
//  ReadingFrame
//
//  Created by 이윤지 on 3/17/24.
//

import SwiftUI

/// 읽고 있는 책, 읽고 싶은 책, 다 읽은 책 상세 페이지의 리스트 뷰
struct BookRowDetailView: View {
    /// 독서 상태 여부
    var readingStatus: ReadingStatus
    
    /// 읽고 있는 책, 읽고 싶은 책, 다 읽은 책 뷰모델
    @StateObject var viewModel: DetailBookViewModel
    
    init(readingStatus: ReadingStatus) {
        self.readingStatus = readingStatus
        _viewModel = StateObject(wrappedValue: DetailBookViewModel(readingStatus: readingStatus))
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // MARK: 검색 바
            NavigationLink {
                // 검색 바 클릭 시 검색 화면으로 이동
                SearchView()
                    .toolbarRole(.editor) // back 텍스트 표시X
            } label: {
                HStack {
                    Image(systemName: "magnifyingglass")
                    
                    Text("제목, 작가를 입력하세요")
                    
                    Spacer()
                }
                .padding(EdgeInsets(top: 8, leading: 7, bottom: 8, trailing: 7))
                .foregroundStyle(.greyText)
                .background(Color(.grey1))
                .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 10)
            
            List {
                // MARK: 타이틀 및 책 개수
                HStack {
                    Text(title())
                    
                    // 읽고 있는 책이라면
                    if (readingStatus == .reading) {
                        Text("\(viewModel.notHideBookList().count)")
                            .fontDesign(.rounded)
                    }
                    // 다 읽은 책이라면
                    else if (readingStatus == .finishRead) {
                        Text("\(viewModel.finishReadBooks.count)")
                            .fontDesign(.rounded)
                    }
                    // 읽고 싶은 책이라면
                    else if (readingStatus == .wantToRead) {
                        Text("\(viewModel.wantToReadBooks.count)")
                            .fontDesign(.rounded)
                    }
                    
                    Spacer()
                }
                .font(.thirdTitle)
                .foregroundStyle(.black0)
                .padding(.top, 10)
                
                // MARK: 책 리스트
                // 읽고 있는 책이라면, 숨기지 않은 책 띄우기
                if (readingStatus == .reading) {
                    ForEach(Array(viewModel.notHideBookList().enumerated()), id: \.offset) { index, book in
                        BookItemDetailView(viewModel: viewModel, bookIndex: index, bookIsbn: book.isbn, readingStatus: readingStatus)
                            .swipeActions(edge: .trailing) {
                                Button(role: .destructive) {
                                    // 책 삭제 API 호출
                                    viewModel.deleteBook(isbn: book.isbn) { success in
                                        if success {
                                            viewModel.deleteBookInList(isbn: book.isbn)
                                        }
                                    }
                                } label: {
                                    Image(systemName: "trash.fill")
                                }
                                .tint(.red0)
                            }
                            .listRowSeparator(.hidden) // list 구분선 제거
                            .listRowInsets(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                    }
                }
                // 읽고 싶은 책이라면
                else if (readingStatus == .wantToRead) {
                    ForEach(Array(viewModel.wantToReadBooks.enumerated()), id: \.offset) { index, book in
                        BookItemDetailView(viewModel: viewModel, bookIndex: index, bookIsbn: book.isbn, readingStatus: readingStatus)
                            .swipeActions(edge: .trailing) {
                                Button(role: .destructive) {
                                    // 책 삭제 API 호출
                                    viewModel.deleteBook(isbn: book.isbn) { success in
                                        if success {
                                            viewModel.wantToReadBooks.remove(at: index)
                                        }
                                    }
                                } label: {
                                    Image(systemName: "trash.fill")
                                }
                                .tint(.red0)
                            }
                    }
                    .listRowSeparator(.hidden) // list 구분선 제거
                    .listRowInsets(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                }
                // 다 읽은 책이라면
                else {
                    ForEach(Array(viewModel.finishReadBooks.enumerated()), id: \.offset) { index, book in
                        BookItemDetailView(viewModel: viewModel, bookIndex: index, bookIsbn: book.isbn, readingStatus: readingStatus)
                            .swipeActions(edge: .trailing) {
                                Button(role: .destructive) {
                                    // 책 삭제 API 호출
                                    viewModel.deleteBook(isbn: book.isbn) { success in
                                        if success {
                                            viewModel.finishReadBooks.remove(at: index)
                                        }
                                    }
                                } label: {
                                    Image(systemName: "trash.fill")
                                }
                                .tint(.red0)
                            }
                    }
                    .listRowSeparator(.hidden) // list 구분선 제거
                    .listRowInsets(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                }
                
                // MARK: 홈 화면에서 숨긴 책 및 책 개수
                if (!viewModel.hideBookList().isEmpty && readingStatus == .reading) {
                    HStack {
                        Text("홈 화면에서 숨긴 책")
                            .font(.thirdTitle)
                            .foregroundStyle(.black0)
                        
                        Text("\(viewModel.hideBookList().count)")
                            .font(.thirdTitle)
                            .fontDesign(.rounded)
                            .foregroundStyle(.black0)
                        
                        Spacer()
                    }
                    .padding(.top, 40)
                    
                    // MARK: 홈 화면에서 숨긴 책 리스트
                    ForEach(Array(viewModel.hideBookList().enumerated()), id: \.offset) { index, book in
                        BookItemDetailView(viewModel: viewModel, bookIndex: index, bookIsbn: book.isbn, readingStatus: readingStatus)
                            .swipeActions(edge: .trailing) {
                                Button(role: .destructive) {
                                    // 책 삭제 API 호출
                                    viewModel.deleteBook(isbn: book.isbn) { success in
                                        if success {
                                            viewModel.deleteBookInList(isbn: book.isbn)
                                        }
                                    }
                                } label: {
                                    Image(systemName: "trash.fill")
                                }
                                .tint(.red0)
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
        // MARK: 네비게이션 타이틀 바
        .navigationTitle(title())
        .navigationBarTitleDisplayMode(.inline)
    }
    
    // 네비게이션 바 제목 설정하는 함수
    func title() -> String {
        if (readingStatus == .reading) {
            return "읽고 있는 책"
        }
        else if (readingStatus == .wantToRead) {
            return "읽고 싶은 책"
        }
        else {
            return "다 읽은 책"
        }
    }
}

#Preview {
    BookRowDetailView(readingStatus: .reading)
}
