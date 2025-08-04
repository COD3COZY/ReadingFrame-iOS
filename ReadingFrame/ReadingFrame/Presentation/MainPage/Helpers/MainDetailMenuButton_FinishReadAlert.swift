//
//  MainDetailMenuButton_FinishReadAlert.swift
//  ReadingFrame
//
//  Created by 석민솔 on 7/9/25.
//

import SwiftUI

/// 다읽음 alert
struct MainDetailMenuButton_FinishReadAlert: View {
    // MARK: - Properties
    let isbn: String
    /// 다읽은 책으로 표시할지 Alert 띄우기
    let showFinishReadAlert: () -> Void
    /// 다읽은 책으로 변경하기 API 호출
    let changeToFinishReadBook: (String) -> Void
    
    // MARK: - View
    var body: some View {
        Button {
            showFinishReadAlert()
        } label: {
            Label("다 읽음", systemImage: "book.closed")
        }
    }
}
