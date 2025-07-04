//
//  DetailBookListHeaderView.swift
//  ReadingFrame
//
//  Created by 석민솔 on 7/2/25.
//

import SwiftUI

/// 타이틀 및 책 개수를 보여주는 리스트의 헤더뷰
struct DetailBookListHeaderView: View {
    // MARK: - Propeties
    let title: String
    let count: Int
    
    // MARK: - View
    var body: some View {
        HStack(spacing: 5) {
            Text(title)
                .font(.thirdTitle)
            
            Text("\(count)")
                .font(.thirdTitle)
                .fontDesign(.rounded)
            
            Spacer()
        }
        .padding(.vertical, 10)
        .font(.thirdTitle)
        .foregroundStyle(.black0)
    }
}
