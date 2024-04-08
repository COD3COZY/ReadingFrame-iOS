//
//  EnterProfile.swift
//  ReadingFrame
//
//  Created by 석민솔 on 4/3/24.
//

import SwiftUI

struct EnterProfile: View {
    /// 선택한 색상(기본은 메인 자주색)
    @State var colorChoose: Color = Color.main
    
    /// (임시용) 색상의 이름 텍스트 직접 생성한 color는 이름만 뽑아내는 방법을 아직 몰라서
    @State var colorName: String = "main"
    
    /// 선택한 캐릭터(기본은 R)
    @State var characterChoose: ProfileCharacter = .R
    
    var body: some View {
        VStack {
            // MARK: 선택에 따라 프로필 보여주는 구역
            Text("사용하실 프로필을 선택해주세요")
                .font(.subheadline)
                .foregroundStyle(.greyText)
                .padding(.vertical, 30)
            
            // TODO: 선택한 색상과 캐릭터 반영되는 프로필 이미지
            // R, I, P일 경우
            if (characterChoose == .R || characterChoose == .I || characterChoose == .P) {
                ZStack {
                    Image(characterChoose.rawValue)
                        .resizable()
                        .renderingMode(.template)
                        .aspectRatio(contentMode: .fit)
                        .foregroundStyle(colorChoose) // 여기에 선택한 색상
                        .frame(width: 160, height: 160)
                        .clipShape(Circle().inset(by: -10))

                    Circle()
                        .foregroundStyle(Color.clear)
                        .frame(width: 180, height: 180)
                        .overlay(
                            Circle()
                                .stroke(.black0, lineWidth: 2)
                        )
                }
                .padding(.bottom, 30)
            
            // A, M일 경우
            } else {
                ZStack {
                    Image(characterChoose.rawValue + "_" + colorName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: characterChoose == .M ? 140 : 170, height: characterChoose == .M ? 140 : 170)
                        .clipShape(Circle().inset(by: characterChoose == .M ? -20 : -5))

                    Circle()
                        .foregroundStyle(Color.clear)
                        .frame(width: 180, height: 180)
                        .overlay(
                            Circle()
                                .stroke(.black0, lineWidth: 2)
                        )
                }
                .padding(.bottom, 30)

            }
            
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
                        .onTapGesture {
                            withAnimation {
                                self.colorChoose = Color.main
                                self.colorName = "main"
                            }
                        }
                    Circle()
                        .foregroundStyle(Color.yellow)
                        .onTapGesture {
                            withAnimation {
                                self.colorChoose = Color.yellow
                                self.colorName = "yellow"
                            }
                        }
                    Circle()
                        .foregroundStyle(Color.emerald)
                        .onTapGesture {
                            withAnimation {
                                self.colorChoose = Color.emerald
                                self.colorName = "emerald"

                            }
                        }
                    Circle()
                        .foregroundStyle(Color.blue)
                        .onTapGesture {
                            withAnimation {
                                self.colorChoose = Color.blue
                                self.colorName = "blue"
                            }
                        }
                    Circle()
                        .foregroundStyle(Color.purple0)
                        .onTapGesture {
                            withAnimation {
                                self.colorChoose = Color.purple0
                                self.colorName = "purple0"

                            }
                        }
                }
                
                
                // MARK: 캐릭터 5종 선택
                Text("캐릭터")
                    .font(.subheadline)
                    .foregroundStyle(.black0)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(alignment: .top, spacing: 20) {
                        Image("chooseProfile_R")
                            .onTapGesture {
                                withAnimation {
                                    self.characterChoose = .R
                                }
                            }
                        Image("chooseProfile_A")
                            .onTapGesture {
                                withAnimation {
                                    self.characterChoose = .A
                                }
                            }
                        Image("chooseProfile_M")
                            .onTapGesture {
                                withAnimation {
                                    self.characterChoose = .M
                                }
                            }
                        Image("chooseProfile_I")
                            .onTapGesture {
                                withAnimation {
                                    self.characterChoose = .I
                                }
                            }
                        Image("chooseProfile_P")
                            .onTapGesture {
                                withAnimation {
                                    self.characterChoose = .P
                                }
                            }
                        
                    }
                    .padding(.horizontal, 30)
                }
                .padding(.horizontal, -30)
                
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
                }
                .frame(maxWidth: .infinity, alignment: .center)

            }
            .padding([.top, .horizontal], 30)
            .background(
                RoundedRectangle(cornerRadius: 40)
                    .foregroundStyle(Color.grey1)
            )
            
        }
        
    }
}

/// 캐릭터 유형선택용 열거형(추후 프로필 클래스 만들면 그쪽으로 옮길 수도 있을 것 같습니다)
enum ProfileCharacter: String {
    case R = "character_main"
    case A = "character_A"
    case M = "character_M"
    case I = "character_I"
    case P = "character_P"
}

#Preview {
    EnterProfile()
}
