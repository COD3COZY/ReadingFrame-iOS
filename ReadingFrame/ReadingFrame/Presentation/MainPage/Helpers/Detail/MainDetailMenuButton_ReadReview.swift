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
    @EnvironmentObject private var coordinator: Coordinator

    let isbn: String

    // MARK: - View
    var body: some View {
        Button {
            coordinator.push(.readingNote(isbn: self.isbn))
        } label: {
            Label("리뷰 확인하기", systemImage: "bubble")
        }
    }
}
