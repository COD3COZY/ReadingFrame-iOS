//
//  MainPageBookRow.swift
//  ReadingFrame
//
//  Created by 이윤지 on 2/14/24.
//

import SwiftUI

/// 홈 화면의 읽고 싶은 책 리스트
struct MainPageBookRow: View {
    
    /// 전체 책 리스트
    @Binding var items: [RegisteredBook]
    
    /// 읽고 싶은 책 리스트
    var wantToReadBooksList: [RegisteredBook] {
        items.filter { $0.book.readingStatus == .wantToRead }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text("읽고 싶은 책 \(wantToReadBooksList.count)")
                    .font(.thirdTitle)
                    .foregroundStyle(.black0)
                
                Spacer()
                
                // MARK: 읽고 싶은 책 상세 페이지로 이동
                Button {
                    
                } label: {
                    Image(systemName: "chevron.right")
                        .font(.title3)
                        .fontWeight(.medium)
                        .foregroundStyle(.black0)
                }
            }
            .padding([.leading, .trailing], 16)
            .padding(.bottom, 16)
            
            // 세로 스크롤 뷰
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    ForEach(Array(wantToReadBooksList.enumerated()), id: \.offset) { index, book in
                        // 읽고 싶은 책만 리스트로 띄우기
                        MainPageBookItem(book: book)
                    }
                }
                .padding(.leading, 16)
                .padding(.trailing, 4)
            }
        }
        .padding(.bottom, 55)
    }
}

#Preview {
    MainPageBookRow(items: .constant([RegisteredBook()]))
}
