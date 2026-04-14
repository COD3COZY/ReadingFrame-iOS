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
    @EnvironmentObject private var coordinator: Coordinator

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
            Button {
                if let subtype = BookshelfSubtype.from(bookshelfType) {
                    coordinator.push(.bookShelfListByType(bookshelfSubtype: subtype))
                }
            } label: {
                BookShelfView(
                    shelfColor: shelfColor,
                    totalPages: totalPages
                )
            }
        }
    }
}
