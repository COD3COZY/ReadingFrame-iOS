//
//  SearchView.swift
//  ReadingFrame
//
//  Created by 이윤지 on 2/13/24.
//

import SwiftUI

/// 검색 창 화면
struct SearchView: View {
    
    /// 사용자가 입력한 검색어
    @State private var searchText: String = ""
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView() {
                VStack {
                    SearchBar(searchText: $searchText, placeholder: "제목, 작가를 입력하세요")
                    
                    searchResults(searchText: $searchText)
                }
                .frame(minHeight: geometry.size.height)

            }
            .frame(width: geometry.size.width)
        }
        .padding(.top, 8)
        .padding([.leading, .trailing], 16)
        .frame(maxWidth: .infinity) // 화면 전체 스크롤 가능하도록 설정
        .navigationTitle("검색하기")
        .navigationBarTitleDisplayMode(.inline)
    }
}

/// 검색어 입력에 따른 뷰 처리
struct searchResults: View {
    /// 사용자가 입력한 검색어
    @Binding var searchText: String
    
    var body: some View {
        // 검색어를 안 입력했다면
        if (searchText.isEmpty) {
            GreyLogoAndTextView(text: "찾고 있는 책을 검색해 보세요.")            
        }
        // 검색어를 입력했다면
        else {
            // TODO: 입력된 검색어에 따른 로직 처리 필요
        }
    }
}


#Preview {
    SearchView()
}
