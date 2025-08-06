//
//  MainDetailMenuButton_InfoNavigation.swift
//  ReadingFrame
//
//  Created by 석민솔 on 7/9/25.
//

import SwiftUI

/// 정보 페이지로 넘겨주기 Navigation
struct MainDetailMenuButton_InfoNavigation: View {
    // MARK: - Properties
    let isbn: String
    
    // MARK: - View
    var body: some View {
        NavigationLink {
            // 책 정보 화면(BookInfo)으로 이동
            BookInfo(isbn: self.isbn)
                .toolbarRole(.editor)
                .toolbar(.hidden, for: .tabBar)
        } label: {
            Label("정보", systemImage: "info.circle")
        }
    }
}
