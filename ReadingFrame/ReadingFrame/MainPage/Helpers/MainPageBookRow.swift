//
//  MainPageBookRow.swift
//  ReadingFrame
//
//  Created by 이윤지 on 2/14/24.
//

import SwiftUI

/// 홈 화면의 읽고 싶은 책, 다 읽은 책 리스트에 대한 파일
struct MainPageBookRow: View {
    var items: [RegisteredBook]
    
    var body: some View {
        // 세로 스크롤 뷰
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(items) { book in
                    MainPageBookItem(book: book) // 책 뷰 띄우기
                }
            }
            .padding(.leading, 16)
            .padding(.trailing, 4)
        }
    }
}

#Preview {
    MainPageBookRow(items: [
        RegisteredBook()
    ])
}
