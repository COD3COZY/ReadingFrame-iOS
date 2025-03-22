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
    @ObservedObject var vm = BadgeViewModel()
    
    // MARK: - BODY
    var body: some View {
        if let badges = vm.badges {
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
                .padding(.vertical, 32)
            }
            // 네비게이션 바 설정
            .navigationTitle("배지")
            .navigationBarTitleDisplayMode(.inline)
            
        } else {
            ProgressView()
        }
    }
}


#Preview("배지 조회") {
    SearchBadge()
}
