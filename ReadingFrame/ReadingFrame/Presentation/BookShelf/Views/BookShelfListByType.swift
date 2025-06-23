//
//  BookShelfListByType.swift
//  ReadingFrame
//
//  Created by 석민솔 on 7/24/24.
//

import SwiftUI

/// 서재 리스트로 보기 뷰
struct BookShelfListByType: View {
    // MARK: - Properties
    @StateObject var vm: BookShelfListByTypeViewModel
    
    // MARK: - View
    var body: some View {
        VStack(spacing: 0) {
            // MARK: 검색박스
            BookShelfListByTypeSearchBox(searchQuery: $vm.searchQuery)
                .padding(.bottom, 20)
            
            // MARK: 서재 title
            // bookshelfSubtype, 몇 권 있는지
            HStack(spacing: 0) {
                Text(vm.bookshelfSubtype.name)
                    .font(.firstTitle)
                    .padding(.trailing, 6)
                
                Text(String(vm.allBooks.count))
                    .font(.firstTitle)
                    .fontDesign(.rounded)
                
                Spacer()
            }
            .padding(.bottom, 15)
            
            ScrollView {
                // MARK: BookshelfView
                BookShelfView(
                    shelfColor: vm.bookshelfColor,
                    totalPages: vm.filteredBooks.compactMap {
                        $0.totalPage
                    }
                )
                .padding(.bottom, 20)
                
                // MARK: List
                ForEach(vm.filteredBooks) { book in
                    BookShelfListRowView(bookInfo: book)
                }
            }
            .padding(.horizontal, -16) // 스크롤은 화면 끝에 뜨도록 상쇄시키기
        }
        .padding(.horizontal, 16)
        .navigationTitle("책장")
    }
}

#Preview {
    BookShelfListByType(vm: .init(bookshelfSubtype: BookType.audioBook))
}
