//
//  Badge.swift
//  ReadingFrame
//
//  Created by 이윤지 on 8/7/24.
//

import SwiftUI

/// 배지 조회 화면
struct SearchBadge: View {
    // MARK: - PROPERTY
    var badges: [Badge] // 배지
    
    // MARK: - BODY
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 45) {
                // 구역별로 배지 보여주기
                ForEach(BadgeSectionType.allCases, id: \.rawValue) { sectionType in
                    BadgeRowView(
                        badgeSection: sectionType,
                        badges: Array(badges[sectionType.badgeArrayRange])
                    )
                }
            }
        }
        // 네비게이션 바 설정
        .navigationTitle("배지")
        .navigationBarTitleDisplayMode(.inline)
    }
}


#Preview("배지 조회") {
    SearchBadge(badges:
        [Badge(badgeCode: 0, isGotBadge: true, date: "2024.08.08"),
         Badge(badgeCode: 1, isGotBadge: true, date: "2024.08.08"),
         Badge(badgeCode: 2, isGotBadge: true, date: "2024.08.08"),
         Badge(badgeCode: 3, isGotBadge: true, date: "2024.08.08"),
         Badge(badgeCode: 4, isGotBadge: false, date: "2024.08.08"),
         Badge(badgeCode: 5, isGotBadge: false, date: "2024.08.08"),
         Badge(badgeCode: 10, isGotBadge: true, date: "2024.08.08"),
         Badge(badgeCode: 11, isGotBadge: false, date: "2024.08.08"),
         Badge(badgeCode: 12, isGotBadge: false, date: "2024.08.08"),
         Badge(badgeCode: 13, isGotBadge: true, date: "2024.08.08"),
         Badge(badgeCode: 20, isGotBadge: true, date: "2024.08.08"),
         Badge(badgeCode: 21, isGotBadge: false, date: "2024.08.08"),
         Badge(badgeCode: 22, isGotBadge: false, date: "2024.08.08"),
         Badge(badgeCode: 30, isGotBadge: true, date: "2024.08.08"),
         Badge(badgeCode: 31, isGotBadge: false, date: "2024.08.08"),
         Badge(badgeCode: 32, isGotBadge: false, date: "2024.08.08"),
         Badge(badgeCode: 40, isGotBadge: true, date: "2024.08.08"),
         Badge(badgeCode: 41, isGotBadge: true, date: "2024.08.08"),
         Badge(badgeCode: 42, isGotBadge: false, date: "2024.08.08"),
         Badge(badgeCode: 43, isGotBadge: false, date: "2024.08.08"),
         Badge(badgeCode: 44, isGotBadge: false, date: "2024.08.08"),
         Badge(badgeCode: 45, isGotBadge: false, date: "2024.08.08"),]
    )
}
