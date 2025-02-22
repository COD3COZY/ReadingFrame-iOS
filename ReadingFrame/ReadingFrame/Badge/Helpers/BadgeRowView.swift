//
//  BadgeRowView.swift
//  ReadingFrame
//
//  Created by 이윤지 on 8/19/24.
//

import SwiftUI

struct BadgeRowView: View {
    /// 배지 제목
    var badgeSection: BadgeSectionType
            
    /// 배지 리스트
    var badges: [Badge]
    
    // 그리드 뷰를 위한 컬럼
    var columns: [GridItem] = Array(repeating: .init(.flexible(), spacing: 13), count: 2)
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // 배지 제목
            Text(badgeSection.rawValue)
                .font(.thirdTitle)
                .foregroundStyle(.black0)
                .padding(.horizontal, 2)
            
            // 배지 설명
            if let badgeInfo = badgeSection.desc {
                Text(badgeInfo)
                    .font(.caption)
                    .foregroundStyle(.greyText)
                    .padding([.top, .horizontal], 2)
                    .padding(.bottom, -7)
            }
            
            Color.clear.frame(height: 22) // 여백용 사각형
            
            // 배지 리스트
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(badges.indices, id: \.self) { index in
                    BadgeView(badge: badges[index])
                }
            }
        }
        .padding(.horizontal, 25)
    }
}

#Preview {
    BadgeRowView(
        badgeSection: .bookCount,
        badges:
            [Badge(badgeCode: 0, isGotBadge: true, date: "2024.08.08"),
             Badge(badgeCode: 1, isGotBadge: true, date: "2024.08.08"),
             Badge(badgeCode: 2, isGotBadge: true, date: "2024.08.08"),
             Badge(badgeCode: 3, isGotBadge: true, date: "2024.08.08"),
             Badge(badgeCode: 4, isGotBadge: false, date: "2024.08.08"),
             Badge(badgeCode: 5, isGotBadge: false, date: "2024.08.08")]
    )
}
