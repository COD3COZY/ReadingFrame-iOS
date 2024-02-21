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
    @State var items: [RegisteredBook]
    
    /// 현재 보이는 페이지 index
    @State var selectedPageIndex: Int = 0
    
    var body: some View {
        HStack {
            Text("읽고 있는 책")
                .font(.thirdTitle)
                .foregroundStyle(.black0)
            Text("\(items.count)")
                .font(.thirdTitle)
                .foregroundStyle(.black0)
            
            Spacer()
            
            // MARK: 세부 페이지 이동 버튼
            Button {
                // TODO: 읽고 있는 책 상세 페이지로 이동
                
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
                ForEach(Array(items.enumerated()), id: \.offset) { index, book in
                    MainPageReadingBookItem(book: book) // 책 뷰 띄우기
                        .tag(index)
                }
            }
            .frame(width: .infinity, height: 420)
            .tabViewStyle(.page(indexDisplayMode: .never)) // indicator를 page 단위로 설정
            .indexViewStyle(.page(backgroundDisplayMode: .never)) // 기존 indicator 숨기기
            .onAppear() {
                setTabViewIndicator()
            }
            
            // Page Indicator
            PageIndicator(numberOfPages: items.count, currentPage: $selectedPageIndex)
        }
        .padding(.bottom, 55)
    }
}

/// Indicator 색상 설정
func setTabViewIndicator() {
    UIPageControl.appearance().currentPageIndicatorTintColor = .black0
    UIPageControl.appearance().pageIndicatorTintColor = .greyText
}

#Preview {
    MainPageReadingBookRow(items: [
        RegisteredBook(), RegisteredBook(), RegisteredBook()
    ])
}
