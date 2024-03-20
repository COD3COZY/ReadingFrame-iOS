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
            
            // MARK: 타이틀 및 책 개수
            HStack {
                title()
                    .font(.thirdTitle)
                    .foregroundStyle(.black0)
                
                Text("\(bookList.count)")
                    .font(.thirdTitle)
                    .foregroundStyle(.black0)
                
                Spacer()
            }
            .padding([.leading, .trailing], 16)
            .padding(.top, 19)
            
            // MARK: 책 리스트
            List {
                ForEach(bookList) { book in
                    // 읽고 있는 책 리스트로 띄우기
                    ReadingItemDetailView(book: book)
                        .listRowSeparator(.hidden) // list 구분선 제거
                        .listRowInsets(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                }
                .onDelete(perform: delete)
            }
            .listStyle(.plain)
            .padding(.top, 15)
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
    func delete(indexSet: IndexSet) {
        bookList.remove(atOffsets: indexSet)
    }
}

#Preview {
    BookRowDetailView(readingStatus: .reading, bookList: [RegisteredBook(), RegisteredBook(), RegisteredBook()])
}
