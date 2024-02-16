//
//  SearchBar.swift
//  ReadingFrame
//
//  Created by 이윤지 on 2/13/24.
//

import SwiftUI

/// 홈 화면 및 책 상세 화면에서 사용되는 검색 바
struct SearchBar: View {
    
    /// 사용자가 입력한 검색어
    @Binding var searchText: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
            
            TextField("제목, 작가를 입력하세요", text: $searchText)
            
            // 검색어가 있다면
            if (!searchText.isEmpty) {
                // 취소 버튼 클릭 시, 입력된 검색어 지우기
                Button(action: {
                    self.searchText = ""
                }) {
                    // 취소 버튼 띄우기
                    Image(systemName: "xmark.circle.fill")
                }
            }
        }
        .padding(EdgeInsets(top: 8, leading: 7, bottom: 8, trailing: 7))
        .foregroundStyle(.greyText)
        .background(Color(.grey1))
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    SearchBar(searchText: .constant(""))
}
