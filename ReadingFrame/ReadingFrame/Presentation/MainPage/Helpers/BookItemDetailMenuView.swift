//
//  BookItemDetailMenuView.swift
//  ReadingFrame
//
//  Created by 석민솔 on 7/2/25.
//

import SwiftUI

/// 독서상태에 맞는 메뉴 만들어주는 뷰
struct BookItemDetailMenuView: View {
    // MARK: - Properties
    let readingStatus: ReadingStatus
    
    // MARK: - View
    var body: some View {
        Menu {
            switch readingStatus {
            case .wantToRead:
                MainDetailWantToReadMenuView()
            case .reading:
                MainDetailReadingMenuView()
            case .finishRead:
                MainDetailFinishReadMenuView()
            case .unregistered:
                EmptyView()
            }
        } label: {
            Image(systemName: "ellipsis")
                .font(.subheadline)
                .foregroundStyle(.black0)
                .frame(minWidth: 32, minHeight: 32)
        }
        // 메뉴인식범위 넓게 해서 불편하지 않도록
        .frame(minWidth: 50, minHeight: 50, alignment: .topTrailing)
        .contentShape(Rectangle())
    }
}

#Preview {
    BookItemDetailMenuView(readingStatus: .reading)
}
