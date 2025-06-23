//
//  BookShelfListByTypeSearchBox.swift
//  ReadingFrame
//
//  Created by 석민솔 on 6/23/25.
//

import SwiftUI

struct BookShelfListByTypeSearchBox: View {
    // MARK: - Properties
    @Binding var searchQuery: String
    
    // MARK: - View
    var body: some View {
        HStack(alignment: .center, spacing: 6) {
            Image(systemName: "magnifyingglass")
                .resizable()
                .scaledToFit()
                .frame(width: 15)
                .foregroundStyle(Color.greyText)
            
            TextField("제목, 작가를 입력하세요", text: $searchQuery)
                .textFieldStyle(.plain)
        }
        .padding(.vertical, 7)
        .padding(.horizontal, 8)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(Color.grey1)
        )
    }
}
