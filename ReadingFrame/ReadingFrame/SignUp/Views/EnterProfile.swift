//
//  EnterProfile.swift
//  ReadingFrame
//
//  Created by 석민솔 on 4/3/24.
//

import SwiftUI

struct EnterProfile: View {
    var body: some View {
        VStack {
            // MARK: 선택에 따라 프로필 보여주는 구역
            Text("사용하실 프로필을 선택해주세요")
                .font(.subheadline)
                .foregroundStyle(.greyText)
            
            // TODO: 선택한 색상과 캐릭터 반영되는 프로필 이미지
            // 일단 우리앱 대표캐릭터로
            Image("character_main")
                .renderingMode(.template)
                .foregroundStyle(Color.main) // 여기에 선택한 색상
                .frame(width: 180, height: 180)
                .clipShape(Circle().inset(by: 20))
                .overlay(
                    Circle()
                        .inset(by: 20)
                        .stroke(.black0, lineWidth: 2)
                )
            
            // 프로필 선택 회색박스
            VStack(alignment: .leading, spacing: 20) {
                
                // MARK: 색상 선택
                Text("색상")
                    .font(.subheadline)
                    .foregroundStyle(.black0)
                
                // TODO: 색상 5개 그리드
                HStack {
                    Circle()
                        .foregroundStyle(Color.main)
                    Circle()
                        .foregroundStyle(Color.yellow)
                    Circle()
                        .foregroundStyle(Color.mint)
                    Circle()
                        .foregroundStyle(Color.blue)
                    Circle()
                        .foregroundStyle(Color.purple)
                }
                
                
                // MARK: 캐릭터 5종 선택
                Text("캐릭터")
                    .font(.subheadline)
                    .foregroundStyle(.black0)
                
                ScrollView(.horizontal) {
                    HStack(spacing: 20) {
                        Image("chooseProfile_R")
                        Image("chooseProfile_A")
                        Image("chooseProfile_M")
                        Image("chooseProfile_I")
                        Image("chooseProfile_P")
                        
                    }
                }
                
                Spacer()
                
                // MARK: 가입 완료 버튼
                NavigationLink {
                    MainPage()
                } label: {
                    Text("가입 완료")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .padding(14)
                        .frame(maxWidth: .infinity)
                        .background(
                            RoundedRectangle(cornerRadius: 40)
                                .foregroundStyle(Color.main)
                        )
                        .padding(.horizontal, 20)
                }
                .frame(maxWidth: .infinity, alignment: .center)

            }
            .padding([.top, .horizontal], 20)
            .background(
                RoundedRectangle(cornerRadius: 40)
                    .foregroundStyle(Color.grey1)
            )
            
        }
        
    }
}

#Preview {
    EnterProfile()
}
