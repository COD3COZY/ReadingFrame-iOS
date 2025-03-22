//
//  AnnotationView.swift
//  ReadingFrame
//
//  Created by 석민솔 on 6/30/24.
//

import SwiftUI

struct AnnotationView: View {
    /// 대표위치, 책갈피위치
    let type: LocationType
    /// 선택된 위치인지 알려주는 변수
    let isSelected: Bool
    
    var body: some View {
        switch type {
        // 책갈피 위치
        case .bookmark:
            if !isSelected {
                // 기본
                Image(systemName: "bookmark.circle.fill")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundStyle(.green)
                    .background(.white)
                    .clipShape(Circle())
                    .shadow(color: .black.opacity(0.3), radius: 1, x: 0, y: 1)
            } else {
                // 선택됨
                Image("Ic-bookMap-bookmark")
                    .padding(.bottom, 35)
            }
        // 메인 위치
        case .main:
            if !isSelected {
                // 기본
                Image(systemName: "book.circle.fill")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundStyle(.yellow)
                    .background(.white)
                    .clipShape(Circle())
                    .shadow(color: .black.opacity(0.3), radius: 1, x: 0, y: 1)
            } else {
                // 선택됨
                Image("Ic-bookMap-book")
                    .padding(.bottom, 35)
            }
        }
    }
}

