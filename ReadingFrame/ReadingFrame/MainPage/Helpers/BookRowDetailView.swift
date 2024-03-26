//
//  BookRowDetailView.swift
//  ReadingFrame
//
//  Created by 이윤지 on 3/17/24.
//

import SwiftUI

/// 읽고 있는 책, 읽고 싶은 책, 다 읽은 책 상세 페이지의 리스트 뷰
struct BookRowDetailView: View {
    var readingStatus: ReadingStatus // 독서 상태 여부
    @State var bookList: [RegisteredBook] // 각 책 리스트(추후 api연동 시 삭제될 변수)
    @State private var selectedItem: String? // 사용자가 삭제하려고 하는 책 아이템
    
    // 독서 상태가 바뀌지 않은 책 리스트
    var tempBookList: [RegisteredBook] {
        bookList.filter { $0.book.readingStatus == readingStatus }
    }
    
    // 홈 화면에서 숨긴 책 리스트
    var hideBookList: [RegisteredBook] {
        bookList.filter { $0.isHidden == true && $0.book.readingStatus == readingStatus}
    }
    
    // 홈 화면에서 숨기지 않은 책 리스트
    var notHideBookList: [RegisteredBook] {
        bookList.filter { $0.isHidden == false && $0.book.readingStatus == readingStatus }
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
            .padding([.leading, .trailing], 16)
            .padding(.bottom, 10)
            
            List {
                // MARK: 타이틀 및 책 개수
                HStack {
                    title()
                        .font(.thirdTitle)
                        .foregroundStyle(.black0)
                    
                    // 읽고 있는 책이라면
                    if (readingStatus == .reading) {
                        Text("\(notHideBookList.count)")
                            .font(.thirdTitle)
                            .foregroundStyle(.black0)
                    }
                    // 다 읽은 책, 읽고 있는 책이라면
                    else {
                        Text("\(tempBookList.count)")
                            .font(.thirdTitle)
                            .foregroundStyle(.black0)
                    }
                    
                    Spacer()
                }
                .padding(.top, 10)
                
                // MARK: 책 리스트
                // 읽고 있는 책이라면, 숨기지 않은 책 띄우기
                if (readingStatus == .reading) {
                    ForEach(notHideBookList, id: \.id) { book in
                        // 독서 상태가 안 바뀐 것만 리스트로 띄우기
                        BookItemDetailView(book: book, readingStatus: readingStatus)
                            .swipeActions(edge: .trailing) {
                                Button(role: .destructive) {
                                    if let tempIndex = bookList.firstIndex(where: { $0.id == book.id }) {
                                        bookList.remove(at: tempIndex)
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
                // 다 읽은 책, 읽고 싶은 책이라면
                else {
                    ForEach(Array(bookList.enumerated()), id: \.offset) { index, book in
                        // 독서 상태가 안 바뀐 것만 리스트로 띄우기
                        if (book.book.readingStatus == readingStatus) {
                            BookItemDetailView(book: book, readingStatus: readingStatus)
                                .swipeActions(edge: .trailing) {
                                    Button(role: .destructive) {
                                        bookList.remove(at: index)
                                    } label: {
                                        Image(systemName: "trash.fill")
                                    }
                                    .tint(.red0)
                                }
                        }
                    }
                    .listRowSeparator(.hidden) // list 구분선 제거
                    .listRowInsets(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                }
                
                // MARK: 홈 화면에서 숨긴 책 및 책 개수
                if (!hideBookList.isEmpty && readingStatus == .reading) {
                    HStack {
                        Text("홈 화면에서 숨긴 책")
                            .font(.thirdTitle)
                            .foregroundStyle(.black0)
                        
                        Text("\(hideBookList.count)")
                            .font(.thirdTitle)
                            .foregroundStyle(.black0)
                        
                        Spacer()
                    }
                    .padding(.top, 40)
                    
                    // MARK: 홈 화면에서 숨긴 책 리스트
                    ForEach(hideBookList, id: \.id) { book in
                        // 숨기기 상태가 안 바뀐 것만 리스트로 띄우기
                        BookItemDetailView(book: book, readingStatus: readingStatus)
                            .swipeActions(edge: .trailing) {
                                Button(role: .destructive) {
                                    if let tempIndex = bookList.firstIndex(where: { $0.id == book.id }) {
                                        bookList.remove(at: tempIndex)
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
    func title() -> Text {
        if (readingStatus == .reading) {
            return Text("읽고 있는 책")
        }
        else if (readingStatus == .wantToRead) {
            return Text("읽고 싶은 책")
        }
        else {
            return Text("다 읽은 책")
        }
    }
    
    // 리스트 책 아이템 삭제 함수
    func deleteBookItem(indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        bookList.remove(at: index)
        selectedItem = nil
    }
}

#Preview {
    BookRowDetailView(readingStatus: .reading, bookList: [RegisteredBook(), RegisteredBook(), RegisteredBook()])
}
