//
//  MainPageBookRow.swift
//  ReadingFrame
//
//  Created by 이윤지 on 2/14/24.
//

import SwiftUI

/// 홈 화면의 읽고 싶은 책, 다 읽은 책 리스트
struct MainPageBookRow: View {
    @State var items: [RegisteredBook]
    
    var body: some View {
        // 세로 스크롤 뷰
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack {
                ForEach(items) { book in
                    MainPageBookItem(book: book) // 책 뷰 띄우기
                }
            }
            .padding(.leading, 16)
            .padding(.trailing, 4)
        }
        .padding(.bottom, 55)
    }
}

#Preview {
    MainPageBookRow(items: [
        RegisteredBook()
    ])
}
