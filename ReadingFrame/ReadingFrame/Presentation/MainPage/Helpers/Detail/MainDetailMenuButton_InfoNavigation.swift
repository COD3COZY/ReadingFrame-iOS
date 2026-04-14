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
    @EnvironmentObject private var coordinator: Coordinator

    let isbn: String

    // MARK: - View
    var body: some View {
        Button {
            coordinator.push(.bookInfo(isbn: self.isbn))
        } label: {
            Label("정보", systemImage: "info.circle")
        }
    }
}
