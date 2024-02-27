//
//  MainPageReadingBookRow.swift
//  ReadingFrame
//
//  Created by 이윤지 on 2/21/24.
//

import SwiftUI

/// 홈 화면의 읽고 있는 책 리스트
struct MainPageReadingBookRow: View {
    
    /// 읽고 있는 책 리스트
    var readingBooksList: [RegisteredBook]
    
    /// 숨김 처리 하지 않은 읽고 있는 책 리스트
    var items: [RegisteredBook] {
        readingBooksList.filter { !$0.isHidden }
    }
    
    /// 총 읽고 있는 책 개수
    //var totalReadingBooksCount: Int = 0
    
    /// 현재 보이는 페이지 index
    @State var selectedPageIndex: Int = 0
    
    var body: some View {
        HStack {
            Text("읽고 있는 책 \(readingBooksList.count)")
                .font(.thirdTitle)
                .foregroundStyle(.black0)
            
            Spacer()
            
            // MARK: 읽고 있는 책 상세 페이지로 이동
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
        
        ZStack(alignment: .top) {
            TabView(selection: $selectedPageIndex) {
                
                ForEach(Array(items.prefix(10).enumerated()), id: \.offset) { index, book in
                    MainPageReadingBookItem(book: book) // 책 뷰 띄우기
                        .tag(index)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never)) // indicator를 page 단위로 설정
            .indexViewStyle(.page(backgroundDisplayMode: .never)) // 기존 indicator 숨기기
            .onAppear() {
                setTabViewIndicator()
            }
            
            // Page Indicator
            PageIndicator(numberOfPages: min(10, items.count), currentPage: $selectedPageIndex)
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
    MainPageReadingBookRow(readingBooksList: [RegisteredBook()])
}
