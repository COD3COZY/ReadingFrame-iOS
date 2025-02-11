//
//  CircleBorderCharcterView.swift
//  ReadingFrame
//
//  Created by 석민솔 on 2/12/25.
//

import SwiftUI

/// 원형 테두리가 있는 캐릭터 액자 뷰
struct CircleBorderCharcterView: View {
    let profile: ProfileCharacter
    
    /// 캐릭터 오프셋
    var offsetY: CGFloat {
        switch self.profile.character {
        case .R: return -20
        case .A: return -15
        case .M: return -20
        case .I: return -30
        case .P: return -20
        }
    }
    
    var offsetX: CGFloat {
        switch self.profile.character {
        case .R: return -4
        case .A: return 0
        case .M: return 0
        case .I: return 0
        case .P: return 0
        }
    }
    
    /// 캐릭터 크기
    var characterSize: CGFloat {
        switch self.profile.character {
        case .R: return 120
        case .A: return 130
        case .M: return 110
        case .I: return 150
        case .P: return 120
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
                            .frame(width: 140, height: 140)
                            .offset(x: offsetX, y: offsetY)
                    )
                    .overlay (
                        Circle()
                            .inset(by: (characterSize - 140) / 2)
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
                            .frame(width: 140, height: 140)
                            .offset(x: offsetX, y: offsetY)
                    )
                    .overlay (
                        Circle()
                            .inset(by: (characterSize - 140) / 2)
                            .offset(x: offsetX, y: offsetY)
                            .stroke(.black0, lineWidth: 2)
                    )
            }
        }
        // 같은 위치와 크기로 조정
        .frame(width: 140, height: 140)
        .padding(.top, -offsetY)
        .padding(.bottom, offsetY)
        .padding(.leading, -offsetX)
        .padding(.trailing, offsetX)
    }
}

#Preview {
    CircleBorderCharcterView(profile: ProfileCharacter(character: .R, color: .main))
}
