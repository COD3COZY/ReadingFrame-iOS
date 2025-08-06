//
//  BookShelfListTitleView.swift
//  ReadingFrame
//
//  Created by 석민솔 on 6/24/25.
//

import SwiftUI

/// 책장뷰에서 책장 하나의 구역별 제목바를 그리는 서브뷰
struct BookShelfListTitleView: View {
    // MARK: - Properties
    /// 책장 유형
    let bookshelfType: BookEnum
    /// 책장에 책이 몇 권 있는지
    let bookCount: Int
    
    // MARK: - View
    var body: some View {
        HStack {
            // 책장이름
            Text(bookshelfType.name)
            
            // 해당 책 개수
            Text(String(bookCount))
                .fontDesign(.rounded)
                .fontWeight(.bold)
            
            Spacer()
            
            // 버튼-화면연결 chevron
            NavigationLink {
                BookShelfListByType(vm: .init(bookshelfSubtype: bookshelfType))
                    .toolbarRole(.editor) // back 텍스트 표시X
                    .toolbar(.hidden, for: .tabBar)
            } label: {
                Image(systemName: "chevron.right")
                    .foregroundStyle(Color.black0)
                    .fontWeight(.semibold)
            }
        }
    }
}

#Preview {
    BookShelfListTitleView(bookshelfType: BookType.audioBook, bookCount: 10)
}
