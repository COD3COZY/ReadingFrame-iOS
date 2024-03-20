//
//  FinishReadBookRow.swift
//  ReadingFrame
//
//  Created by 이윤지 on 2/27/24.
//

import SwiftUI

/// 홈 화면의 다 읽은 책 리스트
struct FinishReadRowView: View {
    
    /// 다 읽은 책 리스트
    var finishReadBooksList: [RegisteredBook]
    
    /// 그리드 아이템
    var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text("다 읽은 책 \(finishReadBooksList.count)")
                    .font(.thirdTitle)
                    .foregroundStyle(.black0)
                
                Spacer()
                
                // MARK: 다 읽은 책 상세 페이지로 이동
                NavigationLink {
                    BookRowDetailView(readingStatus: .finishRead, bookList: finishReadBooksList)
                        .toolbarRole(.editor)
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
            ScrollView(showsIndicators: false) {
                LazyVGrid(columns: columns) {
                    ForEach(Array(finishReadBooksList.enumerated()), id: \.offset) { index, book in
                        // 다 읽은 책 리스트로 띄우기
                        BookItemView(book: book)
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
    FinishReadRowView(finishReadBooksList: [RegisteredBook()])
}
