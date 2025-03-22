//
//  HomeReadingChipButton.swift
//  ReadingFrame
//
//  Created by 이윤지 on 2/21/24.
//

import SwiftUI

/// 홈 화면의 읽고 싶은 책 책갈피와 독서노트 버튼
struct ReadingLabel: View {
    /// 버튼 이름
    var label: String = "책갈피"
    
    /// 버튼 이미지
    var image: String = "bookmark"
    
    var body: some View {
        Label(label, systemImage: image)
            .font(.footnote)
            .foregroundStyle(.black0)
            .padding(EdgeInsets(top: 6, leading: 14.5, bottom: 6, trailing: 14.5))
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .shadow(color: Color(white: 0, opacity: 0.15), radius: 4)
    }
}

#Preview {
    ReadingLabel()
}
