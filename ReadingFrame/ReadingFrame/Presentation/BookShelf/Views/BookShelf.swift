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
            bookshelfView
        }
        // 페이지 데이터가 없을 때 로딩불가 페이지 보여주기
        else {
            ProgressView()
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
    }
}

extension BookShelf {
    var bookshelfView: some View {
        ScrollView {
            let pageData: [[Int]] = vm.totalPages!
            ForEach(vm.bookshelfType.indices, id: \.self) { index in
                
                let currentBookshelf = vm.bookshelfType[index]
                
                VStack {
                    // MARK: 제목 바
                    HStack {
                        // 책장이름
                        Text(currentBookshelf.name)
                        
                        // 해당 책 개수
                        Text(String(pageData[index].count))
                            .fontDesign(.rounded)
                            .fontWeight(.bold)
                        
                        Spacer()
                        
                        // 버튼-화면연결 chevron
                        NavigationLink {
                            BookShelfListByType(bookshelfSubtype: currentBookshelf)
                                .toolbarRole(.editor) // back 텍스트 표시X
                        } label: {
                            Image(systemName: "chevron.right")
                                .foregroundStyle(Color.black0)
                                .fontWeight(.semibold)
                            
                        }
                    }
                    .padding()
                    
                    // MARK: 책 꽃혀있는 책장 부분
                    // 버튼-화면연결 chevron
                    NavigationLink {
                        BookShelfListByType(bookshelfSubtype: currentBookshelf)
                            .toolbarRole(.editor) // back 텍스트 표시X
                    } label: {
                        BookShelfView(
                            shelfColor: vm.bookshelfColor,
                            totalPages: pageData[index]
                        )
                    }
                }
                .padding(.bottom, 25)
                
            }
            .onChange(of: bookshelfSort) { oldValue, newValue in
                // bookshelfSort가 변경되면 ViewModel에 전달
                vm.updateBookshelfSort(newValue)
            }
        }
    }
}

#Preview {
    BookShelf(bookshelfSort: .constant(.genre))
}
