//
//  SearchBarButtonView.swift
//  ReadingFrame
//
//  Created by 석민솔 on 7/3/25.
//

import SwiftUI

/// 누르면 SearchView로 이동하는 버튼 역할을 하는 뷰
struct SearchBarButtonView: View {
    var body: some View {
        NavigationLink {
            Search()
                .toolbarRole(.editor) // back 텍스트 표시X
                .toolbar(.hidden, for: .tabBar) // toolbar 숨기기
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
        .padding(.horizontal, 16)
    }
}

#Preview {
    SearchBarButtonView()
}
