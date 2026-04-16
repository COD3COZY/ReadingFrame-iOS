//
//  MainDetailMenuButton_WriteReview.swift
//  ReadingFrame
//
//  Created by 석민솔 on 7/9/25.
//

import SwiftUI

/// 리뷰 남기기 화면 연결하는 메뉴 버튼
struct MainDetailMenuButton_WriteReview: View {
    @EnvironmentObject private var coordinator: Coordinator

    var body: some View {
        Button {
            coordinator.push(.editReview(review: nil))
        } label: {
            Label("리뷰 남기기", systemImage: "bubble")
        }
    }
}
