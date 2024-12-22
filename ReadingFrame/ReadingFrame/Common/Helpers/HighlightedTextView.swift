//
//  HighlightedText.swift
//  ReadingFrame
//
//  Created by 이윤지 on 12/23/24.
//

import SwiftUI

/// 키워드와 일치하는 부분 텍스트 bold처리하는 뷰
struct HighlightedTextView: View {
    /// 원본 텍스트
    let text: String
    
    /// 키워드
    let keyword: String
    
    var body: some View {
        highlightedText()
    }
    
    private func highlightedText() -> some View {
        let components = text.components(separatedBy: keyword)
        var views: [Text] = []

        // 텍스트 나누기
        for (index, component) in components.enumerated() {
            views.append(Text(component)) // 텍스트 추가

            // 키워드를 추가
            if index < components.count - 1 {
                views.append(Text(keyword).bold()) // 키워드 bold 처리
            }
        }

        // 하나의 Text로 반환
        return views.reduce(Text(""), +) // Text("")부터 시작해 조각을 결합
    }
}

#Preview {
    HighlightedTextView(text: "천개의 파랑", keyword: "파랑")
}
