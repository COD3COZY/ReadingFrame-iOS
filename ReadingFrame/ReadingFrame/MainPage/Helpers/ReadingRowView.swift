//
//  MainPageReadingBookRow.swift
//  ReadingFrame
//
//  Created by 이윤지 on 2/21/24.
//

import SwiftUI

/// 홈 화면의 읽고 있는 책 리스트
struct ReadingRowView: View {
    /// 홈 화면 뷰모델
    @ObservedObject var viewModel: MainPageViewModel
    
    /// 현재 보이는 페이지 index
    @State var selectedPageIndex: Int = 0
    
    var body: some View {
        HStack {
            HStack(spacing: 5) {
                Text("읽고 있는 책")
                    .font(.thirdTitle)
                    .foregroundStyle(.black0)
                
                Text("\(viewModel.readingBooksCount)")
                    .font(.thirdTitle)
                    .fontDesign(.rounded)
                    .foregroundStyle(.black0)
            }
            
            Spacer()
            
            // MARK: 읽고 있는 책 상세 페이지로 이동
            NavigationLink {
                BookRowDetailView(readingStatus: .reading, viewModel: viewModel)
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
        
        ZStack(alignment: .top) {
            TabView(selection: $selectedPageIndex) {
                
                ForEach(Array(viewModel.notHiddenReadingBooksList().prefix(10).enumerated()), id: \.offset) { index, book in
                    ReadingItemView(book: book) // 책 뷰 띄우기
                        .tag(index)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never)) // indicator를 page 단위로 설정
            .indexViewStyle(.page(backgroundDisplayMode: .never)) // 기존 indicator 숨기기
            .onAppear() {
                setTabViewIndicator()
            }
            
            // Page Indicator
            PageIndicator(numberOfPages: min(10, viewModel.notHiddenReadingBooksList().count), currentPage: $selectedPageIndex)
        }
        .padding(.bottom, 55)
        .frame(height: 480)
    }
}

/// Indicator 색상 설정
func setTabViewIndicator() {
    UIPageControl.appearance().currentPageIndicatorTintColor = .black0
    UIPageControl.appearance().pageIndicatorTintColor = .greyText
}

#Preview {
    ReadingRowView(viewModel: MainPageViewModel())
}
