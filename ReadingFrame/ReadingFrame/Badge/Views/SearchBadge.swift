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
            VStack(alignment: .leading) {
                // MARK: 서재에 등록한 책
                BadgeRowView(badgeTitle: "서재에 등록한 책", titlePadding: 32, topPadding: 12, bottomPadding: 12, badges: Array(badges[0...5]))
                
                // MARK: 완독가
                BadgeRowView(badgeTitle: "완독가", titlePadding: 44, topPadding: 8, bottomPadding: 16, badges: Array(badges[6...9]))
                
                // MARK: 기록 MVP
                BadgeRowView(badgeTitle: "기록 MVP", badgeInfo: "*’첫 기록’은 책갈피, 인물사전, 메모를 모두 등록해야 합니다.", titlePadding: 44, topPadding: 12, bottomPadding: 12, badges: Array(badges[10...12]))
                
                // MARK: 리뷰 마스터
                BadgeRowView(badgeTitle: "리뷰 마스터", badgeInfo: "*’리뷰계의 라이징스타’는 키워드, 선택, 한줄평 모두 등록해야 합니다.", titlePadding: 44, topPadding: 30, bottomPadding: 30, badges: Array(badges[13...15]))
                
                // MARK: 장르 애호가
                BadgeRowView(badgeTitle: "장르 애호가", titlePadding: 44, topPadding: 12, bottomPadding: 12, badges: Array(badges[16...21]))
            }
        }
        // 네비게이션 바 설정
        .navigationTitle("배지")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    // MARK: - FUNCTION
}


// MARK: - PREVIEW
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
