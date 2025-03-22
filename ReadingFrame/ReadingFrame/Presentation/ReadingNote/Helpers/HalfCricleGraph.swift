//
//  HalfCricleGraph.swift
//  ReadingFrame
//
//  Created by 이윤지 on 5/1/24.
//

import SwiftUI
import Charts

struct HalfCricleGraph: View {
    var progress: CGFloat // 0.0 ~ 1.0 사이의 값
        
    var body: some View {
        ZStack {
            // 배경 반원
            Circle()
                .trim(from: 0.0, to: 0.5) // 상단 반원만 표시
                .stroke(Color.grey1, style: StrokeStyle(lineWidth: 10, lineCap: .round))
            
            // 진행 표시 반원
            Circle()
                .trim(from: 0.0, to: 0.5 * progress) // 진행 상황에 맞게 반원 조절
                .stroke(Color.main, style: StrokeStyle(lineWidth: 10, lineCap: .round))
                .animation(.linear, value: progress) // 진행 상태 변경에 따른 애니메이션
        }
        .rotationEffect(.degrees(180))
    }
}

#Preview {
    HalfCricleGraph(progress: 0.4)
        .background(
            Color.gray
        )
}
