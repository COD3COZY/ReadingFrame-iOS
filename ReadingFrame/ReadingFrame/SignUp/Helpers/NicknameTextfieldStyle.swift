//
//  NicknameTextfieldStyle.swift
//  ReadingFrame
//
//  Created by 석민솔 on 8/24/24.
//
import SwiftUI

/// 텍스트필드 커스텀용 스타일
struct NicknameTextfieldStyle: TextFieldStyle {
    
    /// 닉네임 길이를 바탕으로 빨간 박스 stroke 만들어줄 변수
    var showNicknameLengthWarning: Bool
    
    func _body(configuration: TextField<Self._Label>) -> some View {
        
        ZStack(alignment: .leading) {
            Rectangle()
                .foregroundColor(.white)
                .frame(height: 50)
                .cornerRadius(10)
                .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 0)
                .overlay(
                    // 빨간 경고 박스창 스타일
                    RoundedRectangle(cornerRadius: 10).inset(by: 0.5).stroke(showNicknameLengthWarning ? Color.red0 : Color.clear, lineWidth: 1)
                )

            
            // 텍스트필드
            configuration
                .padding()
        }
    }
}
