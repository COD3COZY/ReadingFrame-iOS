//
//  MainPageBookRow.swift
//  ReadingFrame
//
//  Created by 이윤지 on 2/14/24.
//

import SwiftUI

/// 홈 화면의 읽고 싶은 책 리스트
struct WantToReadRowView: View {
    /// 홈 화면 뷰모델
    @ObservedObject var viewModel: MainPageViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                HStack(spacing: 5) {
                    Text("읽고 싶은 책")
                        .font(.thirdTitle)
                        .foregroundStyle(.black0)
                    
                    Text("\(viewModel.wantToReadBooksCount)")
                        .font(.thirdTitle)
                        .fontDesign(.rounded)
                        .foregroundStyle(.black0)
                }
                
                Spacer()
                
                // MARK: 읽고 싶은 책 상세 페이지로 이동
                NavigationLink {
                    BookRowDetailView(readingStatus: .wantToRead, viewModel: viewModel)
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
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    ForEach(Array(viewModel.homeWantToReadBooks.prefix(10)), id: \.id) { book in
                        // 읽고 싶은 책만 리스트로 띄우기
                        BookItemView(book: book)
                    }
                }
                .padding(.leading, 16)
                .padding(.trailing, 4)
            }
        }
        .padding(.bottom, 35)
    }
}

#Preview {
    WantToReadRowView(viewModel: MainPageViewModel())
}
