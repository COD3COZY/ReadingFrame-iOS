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
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                let status = items[0].book.readingStatus // 독서 상태 변수
                
                // 읽고 싶은 책이라면
                if (status == .wantToRead) {
                    Text("읽고 싶은 책")
                        .font(.thirdTitle)
                        .foregroundStyle(.black0)
                }
                // 다 읽은 책이라면
                else if (status == .finishRead) {
                    Text("다 읽은 책")
                        .font(.thirdTitle)
                        .foregroundStyle(.black0)
                }
                Text("\(items.count)")
                    .font(.thirdTitle)
                    .foregroundStyle(.black0)
                
                Spacer()
                
                // MARK: 각 세부 페이지 이동 버튼
                Button {
                    // 각 페이지로 이동
                    if (status == .wantToRead) {
                        // TODO: 읽고 싶은 책 상세 페이지로 이동
                    }
                    else if (status == .finishRead) {
                        // TODO: 다 읽은 책 상세 페이지로 이동
                    }
                } label: {
                    Image(systemName: "chevron.right")
                        .font(.title3)
                        .fontWeight(.medium)
                        .foregroundStyle(.black0)
                }
            }
            .padding(.trailing, 16)
            .padding(.bottom, 16)
            
            // 세로 스크롤 뷰
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    ForEach(items) { book in
                        MainPageBookItem(book: book) // 책 뷰 띄우기
                    }
                }
                .padding(.trailing, 4)
            }
        }
        .padding(.leading, 16)
        .padding(.bottom, 55)
    }
}

#Preview {
    MainPageBookRow(items: [
        RegisteredBook()
    ])
}
