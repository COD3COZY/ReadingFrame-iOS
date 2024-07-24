//
//  CharacterView.swift
//  ReadingFrame
//
//  Created by 이윤지 on 7/7/24.
//

import SwiftUI

/// 독서노트 화면에서 사용되는 개별 인물사전 뷰
struct CharacterView: View {
    var character: Character
    
    var body: some View {
        VStack(spacing: 0) {
            // MARK: 이모지
            Text(String(UnicodeScalar(character.emoji)!))
                .font(.system(size: 60))
                .frame(width: 60, height: 60)
            
            // MARK: 인물 이름
            Text(character.name)
                .font(.system(size: 15, weight: .bold))
                .foregroundStyle(.black0)
                .padding(.top, 6)
                .padding(.bottom, 10)
            
            // MARK: 한줄소개
            Text(character.preview)
                .font(.footnote)
                .foregroundStyle(.black0)
                .lineLimit(3)
                .frame(height: 54, alignment: .top)
        }
        .padding(.vertical, 15)
        .padding(.horizontal, 10)
        .frame(width: 126, height: 180)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(.white)
        )
    }
}

#Preview {
    CharacterView(character: Character(emoji: Int("🍎".unicodeScalars.first!.value), name: "사과", preview: "사과입니다.", description: "맛있는 사과"))
}
