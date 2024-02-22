//
//  Home.swift
//  ReadingFrame
//
//  Created by 이윤지 on 2/18/24.
//

import SwiftUI

struct Home: View {
    
    /// segmented control 변수
    @State var selection: String = "book.closed"
    
    var body: some View {
        NavigationStack {
            ScrollView() {
                VStack(alignment: .leading, spacing: 0) {
                    // 검색 바 및 전환 버튼
                    VStack(alignment: .trailing, spacing: 0) {
                        
                        // 검색바를 클릭한 경우
                        NavigationLink {
                            SearchView()
                                .toolbarRole(.editor) // back 텍스트 표시X
                        } label: {
                            // MARK: 검색 바
                            HStack {
                                Image(systemName: "magnifyingglass")
                                
                                Text("제목, 작가를 입력하세요")
                                
                                Spacer()
                            }
                            .padding(EdgeInsets(top: 8, leading: 7, bottom: 8, trailing: 7))
                            .foregroundStyle(.greyText)
                            .background(Color(.grey1))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                        .padding([.leading, .trailing], 16)
                        
                        // MARK: 홈 화면, 책장 화면 전환 버튼
                        HomeSegmentedControl(selection: $selection)
                            .frame(width: 118, height: 28)
                            .padding([.top, .trailing], 16)
                            .padding(.bottom, 29)
                        
                        if (selection == "book.closed") {
                            // MARK: 홈 화면 띄우기
                            MainPage()
                        }
                        else {
                            // TODO: 책장 화면 띄우기
                        }
                    }
                    .padding(.top, 10)
                }
                Spacer()
            }
            .scrollIndicators(.hidden)
            .frame(maxWidth: .infinity)
        }
        .tint(.black0) // accentcolor를 검정색으로(뒤로가기 버튼 색상 설정을 위함)
    } // 화면 전체 스크롤 가능하도록 설정
}

#Preview {
    Home()
}
