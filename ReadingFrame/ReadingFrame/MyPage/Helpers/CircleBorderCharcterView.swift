//
//  CircleBorderCharcterView.swift
//  ReadingFrame
//
//  Created by 석민솔 on 2/12/25.
//

import SwiftUI

/// 원형 테두리가 있는 캐릭터 액자 뷰
struct CircleBorderCharcterView: View {
    /// 캐릭터 종류
    let profile: ProfileCharacter
    
    /// 크기 조절용 상수
    var baseSize: CGFloat = 140  // 기존 140에서 180으로 변경
    
    /// 입력된 크기에 따라 크기 비율 변경
    private var sizeRatio: CGFloat {
        baseSize / 140  // 크기 비율
    }
    
    /// 캐릭터 오프셋
    var offsetY: CGFloat {
        switch self.profile.character {
        case .R: return -20 * sizeRatio
        case .A: return -15 * sizeRatio
        case .M: return -20 * sizeRatio
        case .I: return -30 * sizeRatio
        case .P: return -20 * sizeRatio
        }
    }
    
    var offsetX: CGFloat {
        switch self.profile.character {
        case .R: return -4 * sizeRatio
        case .A: return 0
        case .M: return 0
        case .I: return 0
        case .P: return 0
        }
    }
    
    /// 캐릭터 크기
    var characterSize: CGFloat {
        switch self.profile.character {
        case .R: return 120 * sizeRatio
        case .A: return 130 * sizeRatio
        case .M: return 110 * sizeRatio
        case .I: return 150 * sizeRatio
        case .P: return 120 * sizeRatio
        }
    }

    var body: some View {
        VStack {
            let character = profile.character
            let color = profile.color
            
            if character == .R || character == .I || character == .P {
                Image(character.rawValue)
                    .resizable()
                    .renderingMode(.template)
                    .aspectRatio(contentMode: .fit)
                    .foregroundStyle(color.color)
                    .frame(width: characterSize, height: characterSize)
                    .mask(
                        Circle()
                            .frame(width: baseSize, height: baseSize)
                            .offset(x: offsetX, y: offsetY)
                    )
                    .overlay (
                        Circle()
                            .inset(by: (characterSize - baseSize) / 2)
                            .offset(x: offsetX, y: offsetY)
                            .stroke(.black0, lineWidth: 2)
                    )
            } else {
                Image(character.rawValue + "_" + color.name)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: characterSize, height: characterSize)
                    .mask(
                        Circle()
                            .frame(width: baseSize, height: baseSize)
                            .offset(x: offsetX, y: offsetY)
                    )
                    .overlay (
                        Circle()
                            .inset(by: (characterSize - baseSize) / 2)
                            .offset(x: offsetX, y: offsetY)
                            .stroke(.black0, lineWidth: 2)
                    )
            }
        }
        .frame(width: baseSize, height: baseSize)
        .padding(.top, -offsetY)
        .padding(.bottom, offsetY)
        .padding(.leading, -offsetX)
        .padding(.trailing, offsetX)
    }
}

#Preview {
    CircleBorderCharcterView(profile: ProfileCharacter(character: .R, color: .main))
}
