//
//  BookShelfSectionView.swift
//  ReadingFrame
//
//  Created by 석민솔 on 6/24/25.
//

import SwiftUI

/// BookShelf에서 제목 바와 책장 UI가 그려지는 뷰
struct BookShelfSectionView: View {
    // MARK: - Properties
    let bookshelfType: BookEnum
    let bookCount: Int
    let shelfColor: ThemeColor
    let totalPages: [Int]
    
    // MARK: - View
    var body: some View {
        VStack {
            // MARK: 제목 바
            BookShelfListTitleView(
                bookshelfType: bookshelfType,
                bookCount: bookCount
            )
            .padding()
            
            // MARK: 책 꽃혀있는 책장 부분
            // 버튼-화면연결 chevron
            NavigationLink {
                BookShelfListByType(vm: .init(bookshelfSubtype: bookshelfType))
                    .toolbarRole(.editor) // back 텍스트 표시X
            } label: {
                BookShelfView(
                    shelfColor: shelfColor,
                    totalPages: totalPages
                )
            }
        }
    }
}
