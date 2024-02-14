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
                    NavigationLink {
                        // 읽고 싶은 책이라면
                        if (book.readingStatus == .wantToRead) {
                            // TODO: 책 정보 화면으로 이동
                            
                        }
                        // 다 읽은 책 이라면
                        else {
                            // TODO: 독서 노트 화면으로 이동
                        }
                    } label: {
                        // 책을 누르면
                        MainPageBookItem(registeredBook: book)
                    }
                }
            }
            .padding(.leading, 16)
            .padding(.trailing, 4)
        }
    }
}

#Preview {
    MainPageBookRow(items: [
        RegisteredBook.defaultRegisteredBook,
        RegisteredBook.defaultRegisteredBook,
        RegisteredBook.defaultRegisteredBook,
        RegisteredBook.defaultRegisteredBook,
        RegisteredBook.defaultRegisteredBook,
    ])
}
