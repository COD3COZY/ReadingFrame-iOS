//
//  NicknameTextfieldStyle.swift
//  ReadingFrame
//
//  Created by 석민솔 on 8/24/24.
//  닉네임 텍스트필드를 위한 커스텀 스타일을 만들기 위한 파일입니다.
//
import SwiftUI

/// 작성한 텍스트 있으면 x 버튼
struct TextFieldClearButton: ViewModifier {
    @Binding var text: String

    func body(content: Content) -> some View {
        ZStack(alignment: .trailing) {
            content

            if !text.isEmpty {
                Button {
                    withAnimation {
                        text.removeAll()
                    }
                } label: {
                    Image(systemName: "multiply.circle.fill")
                        .font(.body)
                        .foregroundStyle(.gray)
                }
                .offset(x: 25)
            }
        }
    }
}

/// 텍스트필드에 빨간 경고 테두리
struct TextFieldWarning: ViewModifier {
    var showWarning: Bool

    func body(content: Content) -> some View {
        content
            .frame(height: 50)
            .overlay(
                RoundedRectangle(cornerRadius: 40)
                    .inset(by: 0.5)
                    .stroke(showWarning ? Color.red0 : Color.clear, lineWidth: 1)
            )
    }
}

extension View {
    /// 작성한 텍스트 있으면 x 버튼
    func clearButton(text: Binding<String>) -> some View {
        modifier(TextFieldClearButton(text: text))
            .padding(.trailing, 40)
            .padding(.leading, 20)
            .background {
                RoundedRectangle(cornerRadius: 40)
                    .foregroundColor(.white)
                    .frame(height: 50)
                    .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 0)
            }
    }
    
    /// 텍스트필드에 빨간 경고 테두리
    func warningTextField(_ showWarning: Bool) -> some View {
        modifier(TextFieldWarning(showWarning: showWarning))
    }
}
