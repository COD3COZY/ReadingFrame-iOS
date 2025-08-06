//
//  MainDetailMenuButton_ReadReview.swift
//  ReadingFrame
//
//  Created by 석민솔 on 7/9/25.
//

import SwiftUI

/// 리뷰 확인 화면(독서노트) 연결하는 메뉴 버튼
struct MainDetailMenuButton_ReadReview: View {
    // MARK: - Properties
    let isbn: String
    
    // MARK: - View
    var body: some View {
        NavigationLink {
            // 독서노트 화면(ReadingNote) 연결
            ReadingNote(isbn: self.isbn)
                .toolbarRole(.editor)
                .toolbar(.hidden, for: .tabBar)
        } label: {
            Label("리뷰 확인하기", systemImage: "bubble")
        }
    }
}
