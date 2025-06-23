//
//  BookShelf.swift
//  ReadingFrame
//
//  Created by 석민솔 on 7/24/24.
//

import SwiftUI

struct BookShelf: View {
    // MARK: - Properties & init
    /// 뷰모델
    @StateObject var vm: BookShelfViewModel
    
    /// 서재 정렬 타입
    /// - Home에서 @Binding으로 받아오는 데이터
    @Binding var bookshelfSort: BookshelfSort
    
    init(bookshelfSort: Binding<BookshelfSort>) {
        self._bookshelfSort = bookshelfSort
        _vm = StateObject(wrappedValue: BookShelfViewModel(bookshelfSort.wrappedValue))
    }
    
    // MARK: - View
    var body: some View {
        // 페이지 데이터가 있을 때
        if vm.totalPages != nil {
            ScrollView {
                let pageData: [[Int]] = vm.totalPages!
                ForEach(Array(vm.bookshelfType.enumerated()), id: \.offset) { index, type in
                    BookShelfSectionView(
                        bookshelfType: type,
                        bookCount: pageData[index].count,
                        shelfColor: vm.bookshelfColor,
                        totalPages: pageData[index]
                    )
                    .padding(.bottom, 25)
                }
            }
            .onChange(of: bookshelfSort) { oldValue, newValue in
                // bookshelfSort가 변경되면 ViewModel에 전달
                vm.updateBookshelfSort(newValue)
            }
        }
        // 페이지 데이터가 없을 때 로딩불가 페이지 보여주기
        else {
            ProgressView()
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
    }
}

#Preview {
    BookShelf(bookshelfSort: .constant(.genre))
}
