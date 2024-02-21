//
//  ReadingPercentBar.swift
//  ReadingFrame
//
//  Created by 이윤지 on 2/21/24.
//

import SwiftUI

/// 읽고 있는 책의 막대 그래프 및 퍼센트 정보 뷰
struct ReadingPercentBar: View {
    /// 책 객제
    @Bindable var book: RegisteredBook
    
    /// 막대 그래프 너비
    var width: Int = 0
    
    var body: some View {
        // MARK: 막대 그래프
        ZStack(alignment: .leading) {
            // 배경
            RoundedRectangle(cornerRadius: 10)
                .frame(width: CGFloat(width), height: 9)
                .foregroundStyle(.grey2)
                .opacity(0.25)
            
            // 퍼센트
            RoundedRectangle(cornerRadius: 10)
                .frame(width: floor(Double(book.readingPercent ?? 0)) * Double((width / 100)), height: 9)
                .foregroundStyle(.black0)
        }
        .padding(.top, 19)
        
        HStack(spacing: 0) {
            // MARK: 읽은 퍼센트
            Text("\(String(format: "%d", book.readingPercent ?? 0))%")
                .font(.caption)
            
            Spacer()
            
            // MARK: 읽은 페이지와 전체 페이지
            Text("\(String(format: "%d", book.readPage ?? 0))/")
                .font(.caption)
            Text("\(String(format: "%d", book.book.totalPage))")
                .font(.caption)
        }
        .foregroundStyle(.black0)
        .frame(width: CGFloat(width))
        .padding(.top, 6)
    }
}

#Preview {
    ReadingPercentBar(book: RegisteredBook())
}
