//
//  BadgeRowView.swift
//  ReadingFrame
//
//  Created by 이윤지 on 8/19/24.
//

import SwiftUI

struct BadgeRowView: View {
    /// 배지 제목
    var badgeTitle: String
    
    /// 배지 설명
    var badgeInfo: String?
    
    /// 배지 제목 상단 여백
    var titlePadding: CGFloat
    
    /// 배지 상단 여백
    var topPadding: CGFloat
    
    /// 배지 하단 여백
    var bottomPadding: CGFloat
    
    /// 배지 리스트
    var badges: [Badge]
    
    // 그리드 뷰를 위한 컬럼
    var columns: [GridItem] = Array(repeating: .init(.flexible(), spacing: 13), count: 2)
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // 배지 제목
            Text(badgeTitle)
                .font(.thirdTitle)
                .foregroundStyle(.black0)
                .padding(.top, titlePadding)
                .padding(.horizontal, 27)
            
            // 배지 설명
            if let badgeText = badgeInfo {
                Text(badgeText)
                    .font(.system(size: 10, weight: .regular))
                    .foregroundStyle(.greyText)
                    .padding(.top, 2)
                    .padding(.horizontal, 27)
            }
            
            // 배지 리스트
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(badges.indices, id: \.self) { index in
                    BadgeView(badge: badges[index], topPadding: topPadding, bottomPadding: bottomPadding)
                }
            }
            .padding(.top, 22)
            .padding(.horizontal, 25)
        }
    }
}

#Preview {
    BadgeRowView(
        badgeTitle: "서재에 등록한 책",
        titlePadding: 32,
        topPadding: 12,
        bottomPadding: 12,
        badges:
            [Badge(badgeCode: 0, isGotBadge: true, date: "2024.08.08"),
             Badge(badgeCode: 1, isGotBadge: true, date: "2024.08.08"),
             Badge(badgeCode: 2, isGotBadge: true, date: "2024.08.08"),
             Badge(badgeCode: 3, isGotBadge: true, date: "2024.08.08"),
             Badge(badgeCode: 4, isGotBadge: false, date: "2024.08.08"),
             Badge(badgeCode: 5, isGotBadge: false, date: "2024.08.08")]
    )
}
