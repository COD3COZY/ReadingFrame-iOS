//
//  EnterNickname.swift
//  ReadingFrame
//
//  Created by 석민솔 on 3/20/24.
//

import SwiftUI

struct EnterNickname: View {
    /// 유저가 입력할 닉네임
    @State var nickname: String = ""
    
    /// 중복 여부를 검사할 변수
    @State var isDuplicate: Bool = true
    
//    /// 다음 버튼 활성화 검사할 변수
//    var canGoNext: Bool {
//        return self.isDuplicate
//    }
    
    var body: some View {
        ZStack {
            VStack {
                Text("ReadingFrame에 오신 걸 \n환영합니다!")
                    .font(.SecondTitle)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.top, 70)
                Spacer()
            }
            
            VStack(alignment: .leading) {
                Spacer()
                
                // 닉네임 입력하는 영역
                VStack(alignment: .leading, spacing: 10) {
                    Text("사용하실 닉네임을 입력해주세요")
                        .font(.subheadline)
                        .foregroundStyle(.greyText)
                    
                    HStack(spacing: 8) {
                        // MARK: 닉네임 입력하는 텍스트 필드
                        TextField("ex. 독서왕", text: $nickname)
                            .textFieldStyle(NicknameTextfieldStyle())
                        
                        // MARK: 중복검사 버튼
                        Button {
                            // TODO: 중복 검사하기
                        } label: {
                            Text("중복확인")
                                .foregroundStyle(.black0)
                                .font(.subheadline)
                                .frame(minWidth: 88, minHeight: 50, maxHeight: 50)
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .foregroundStyle(.white)
                                        .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 0)
                                )
                        }
                    }
                }
                .padding(.horizontal, 20)
                
                Spacer()
                
                // MARK: 다음 버튼
                Button {
                    
                } label: {
                    HStack {
                        Text("다음")
                            .font(.headline)
                        Image(systemName: "chevron.forward")
                    }
                    .frame(minWidth: 100, minHeight: 48)
                    .foregroundStyle(.white)
                    .background(
                        RoundedRectangle(cornerRadius: 40)
                    )
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding([.trailing, .bottom], 26)
            }
        }
    }
}

/// 텍스트필드 커스텀용 스타일
struct NicknameTextfieldStyle: TextFieldStyle {
    
    func _body(configuration: TextField<Self._Label>) -> some View {
        
        ZStack(alignment: .leading) {
            Rectangle()
                .foregroundColor(.white)
                .frame(height: 50)
                .cornerRadius(10)
                .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 0)

            
            // 텍스트필드
            configuration
                .padding()
        }
    }
}


#Preview {
    EnterNickname()
}
