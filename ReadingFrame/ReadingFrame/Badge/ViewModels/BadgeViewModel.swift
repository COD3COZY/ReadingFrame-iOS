//
//  BadgeViewModel.swift
//  ReadingFrame
//
//  Created by 석민솔 on 2/24/25.
//

import Foundation

class BadgeViewModel: ObservableObject {
    @Published var badges: [Badge]?
    
    init() {
        fetchBadges()
    }
    
    func fetchBadges() {
        // TODO: 배지 조회 API 호출하는 걸로 바꾸기. 임시로 더미 데이터 넣어둠
        self.badges = [
            Badge(badgeCode: 0, isGotBadge: true,   date: "2024.08.08"),
            Badge(badgeCode: 1, isGotBadge: true,   date: "2024.08.08"),
            Badge(badgeCode: 2, isGotBadge: true,   date: "2024.08.08"),
            Badge(badgeCode: 3, isGotBadge: true,   date: "2024.08.08"),
            Badge(badgeCode: 4, isGotBadge: false,  date: "2024.08.08"),
            Badge(badgeCode: 5, isGotBadge: false,  date: "2024.08.08"),
            Badge(badgeCode: 10, isGotBadge: true,  date: "2024.08.08"),
            Badge(badgeCode: 11, isGotBadge: false, date: "2024.08.08"),
            Badge(badgeCode: 12, isGotBadge: false, date: "2024.08.08"),
            Badge(badgeCode: 13, isGotBadge: true,  date: "2024.08.08"),
            Badge(badgeCode: 20, isGotBadge: true,  date: "2024.08.08"),
            Badge(badgeCode: 21, isGotBadge: false, date: "2024.08.08"),
            Badge(badgeCode: 22, isGotBadge: false, date: "2024.08.08"),
            Badge(badgeCode: 30, isGotBadge: true,  date: "2024.08.08"),
            Badge(badgeCode: 31, isGotBadge: false, date: "2024.08.08"),
            Badge(badgeCode: 32, isGotBadge: false, date: "2024.08.08"),
            Badge(badgeCode: 40, isGotBadge: true,  date: "2024.08.08"),
            Badge(badgeCode: 41, isGotBadge: true,  date: "2024.08.08"),
            Badge(badgeCode: 42, isGotBadge: false, date: "2024.08.08"),
            Badge(badgeCode: 43, isGotBadge: false, date: "2024.08.08"),
            Badge(badgeCode: 44, isGotBadge: false, date: "2024.08.08"),
            Badge(badgeCode: 45, isGotBadge: false, date: "2024.08.08")
        ]
    }
}
