//
//  HomeReadingChipButton.swift
//  ReadingFrame
//
//  Created by 이윤지 on 2/21/24.
//

import SwiftUI

/// 홈 화면의 읽고 싶은 책 책갈피와 독서노트 버튼
struct ReadingChipButton: View {
    /// 버튼 이름
    var label: String = "책갈피"
    
    /// 버튼 이미지
    var image: String = "bookmark"
    
    var body: some View {
        // MARK: 책갈피 및 독서노트 버튼
        NavigationLink {
            if (label == "책갈피") {
                // TODO: 책갈피 추가 sheet 띄우기
            }
            else {
                // TODO: 독서노트 화면으로 이동
            }
        } label: {
            Label(label, systemImage: image)
                .foregroundStyle(.black0)
                .padding(EdgeInsets(top: 6, leading: 14.5, bottom: 6, trailing: 14.5))
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .shadow(color: Color(white: 0, opacity: 0.15), radius: 4)
        }
    }
}

#Preview {
    ReadingChipButton()
}
