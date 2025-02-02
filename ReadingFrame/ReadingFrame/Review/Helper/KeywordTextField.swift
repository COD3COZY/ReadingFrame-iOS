//
//  KeywordTextField.swift
//  ReadingFrame
//
//  Created by 석민솔 on 9/23/24.
//

import SwiftUI

/// 유저가 입력한 텍스트의 길이에 맞게 너비가 커지는 뷰
struct KeywordTextField: View {
    // MARK: - Properties
    /// 유저가 적은 텍스트 받아오는 값
    @Binding var text: String
    
    /// 유저 입력전 placeholder
    let placeholder: String = "키워드"
    
    /// 텍스트 너비를 저장할 변수
    @State private var textRect = CGRect()
    
    /// 부모 뷰의 크기
    let parentViewWidth: Double
    
    // MARK: - View
    var body: some View {
        VStack(alignment: .leading) {
            ZStack(alignment: .topLeading) {
                // MARK: 글자 너비에 맞게 커지는 배경 상자
                RoundedRectangle(cornerRadius: 40)
                    .frame(width: dynamicWidth(), height: 45, alignment: .leading)
                    .foregroundStyle(Color.white)
                    .shadow(color: Color(red: 0.47, green: 0.47, blue: 0.47).opacity(0.3), radius: 2, x: 0, y: 0)
                    .animation(.default, value: textRect.width) // 애니메이션 추가
                
                // MARK: 키워드 입력 박스
                HStack(alignment: .center, spacing: 5) {
                    Text("#")
                        .font(.thirdTitle)
                        .fontWeight(.regular)
                    
                    // 실제 이용될 텍스트 입력창
                    TextField(placeholder, text: $text)
                        .tint(.main)
                        .frame(width: parentViewWidth - 90)
                        .onChange(of: text) { oldValue, newValue in
                            // 15글자 이상 입력하지 못하게 제한
                            if newValue.count > 15 {
                                text = String(newValue.prefix(15))
                            }
                        }
                }
                .padding(.horizontal, 16)
                .frame(height: 45, alignment: .leading)
            }
            
            
            // textfield에 입력될 텍스트 너비 측정용 투명 Text 객체
            Text(text == "" ? placeholder : text)
                .background(GlobalGeometryGetter(rect: $textRect))
                .background(Color.yellow)
                .layoutPriority(1)
                .opacity(0)            
        }
    }
    
    /// 텍스트 길이에 따른 배경 상자 너비 계산
    private func dynamicWidth() -> CGFloat {
        let minWidth: CGFloat = 130             // 최소 너비
        
        let textboxWidth: CGFloat = 60 + textRect.width     // 글자 너비 반영된 키워드 박스 크기
        
        let maxWidth: CGFloat = parentViewWidth - 32 // 최대 너비
        
        // 최소를 130으로 하고, 문자길이가 더 커지면 큰 값을 너비로 설정, 부모 뷰에 맞춰서 최대 크기
        let finalWidth = max(minWidth, min(textboxWidth, maxWidth))
        
        return finalWidth
    }
}

/// 텍스트 길이에 따른 동적 너비 계산
struct GlobalGeometryGetter: View {
    @Binding var rect: CGRect

    var body: some View {
        return GeometryReader { geometry in
            self.makeView(geometry: geometry)
        }
    }

    func makeView(geometry: GeometryProxy) -> some View {
        DispatchQueue.main.async {
            self.rect = geometry.frame(in: .global)
        }

        return Rectangle().fill(Color.clear)
    }
}

//#Preview {
//    ZStack {
//        Color.black
//        KeywordTextField(parentViewSize: .init(width: 350, height: 844))
//    }
//}
