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
    
    var body: some View {
        // MARK: 막대 그래프
        GeometryReader { geometry in
            VStack(spacing: 0) {
                ZStack(alignment: .leading) {
                    // 배경
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: geometry.size.width, height: 9)
                        .foregroundStyle(.grey2)
                        .opacity(0.25)
                    
                    // 퍼센트
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: CGFloat(floor(Double(book.readingPercent)) / 100 * Double(geometry.size.width)), height: 9)
                        .foregroundStyle(.black0)
                }
                .padding(.top, 19)
                
                HStack(spacing: 0) {
                    // MARK: 읽은 퍼센트
                    Text("\(String(format: "%d", book.readingPercent))%")
                        .font(.caption)
                    
                    Spacer()
                    
                    // MARK: 읽은 페이지와 전체 페이지
                    Text("\(String(format: "%d", book.readPage))/")
                        .font(.caption)
                    Text("\(String(format: "%d", book.book.totalPage))")
                        .font(.caption)
                }
                .foregroundStyle(.black0)
                .padding(.top, 6)
            }
        }
    }
}

#Preview {
    ReadingPercentBar(book: RegisteredBook())
}
