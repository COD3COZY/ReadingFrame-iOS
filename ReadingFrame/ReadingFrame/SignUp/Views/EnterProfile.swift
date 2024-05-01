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
        ScrollView {
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
                            .frame(maxWidth: 130, maxHeight: 130)
//                            .clipShape(Circle().inset(by:))

                        Circle()
                            .foregroundStyle(Color.clear)
                            .frame(maxWidth: 180, maxHeight: 180)
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
                            .frame(width: characterChoose == .M ? 130 : 130, height: characterChoose == .M ? 130 : 130)
//                            .clipShape(Circle().inset(by: characterChoose == .M ? -20 : -5))

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
                    HStack(spacing: 10) {
                        // 자주색
                        Circle()
                            .frame(minWidth: 60, minHeight: 60)
                            .foregroundStyle(Color.main)
                            .onTapGesture {
                                withAnimation {
                                    self.colorChoose = Color.main
                                    self.colorName = "main"
                                }
                            }
                            .overlay (
                                Circle()
                                    .inset(by: -3)
                                    .stroke(colorChoose == Color.main ? .black0 : .clear, lineWidth: 2)
                                    .backgroundStyle(Color.white)
                            )
                        
                        // 노랑색
                        Circle()
                            .frame(minWidth: 60, minHeight: 60)
                            .foregroundStyle(Color.yellow)
                            .onTapGesture {
                                withAnimation {
                                    self.colorChoose = Color.yellow
                                    self.colorName = "yellow"
                                }
                            }
                            .overlay (
                                Circle()
                                    .inset(by: -3)
                                    .stroke(colorChoose == Color.yellow ? .black0 : .clear, lineWidth: 2)
                                    .backgroundStyle(Color.white)
                            )
                        
                        // 초록색
                        Circle()
                            .frame(minWidth: 60, minHeight: 60)
                            .foregroundStyle(Color.emerald)
                            .onTapGesture {
                                withAnimation {
                                    self.colorChoose = Color.emerald
                                    self.colorName = "emerald"
                                    
                                }
                            }
                            .overlay (
                                Circle()
                                    .inset(by: -3)
                                    .stroke(colorChoose == Color.emerald ? .black0 : .clear, lineWidth: 2)
                                    .backgroundStyle(Color.white)
                            )
                        
                        // 파랑색
                        Circle()
                            .frame(minWidth: 60, minHeight: 60)
                            .foregroundStyle(Color.blue)
                            .onTapGesture {
                                withAnimation {
                                    self.colorChoose = Color.blue
                                    self.colorName = "blue"
                                }
                            }
                            .overlay (
                                Circle()
                                    .inset(by: -3)
                                    .stroke(colorChoose == Color.blue ? .black0 : .clear, lineWidth: 2)
                                    .backgroundStyle(Color.white)
                            )
                        
                        // 보라색
                        Circle()
                            .frame(minWidth: 60, minHeight: 60)
                            .foregroundStyle(Color.purple0)
                            .onTapGesture {
                                withAnimation {
                                    self.colorChoose = Color.purple0
                                    self.colorName = "purple0"
                                    
                                }
                            }
                            .overlay (
                                Circle()
                                    .inset(by: -3)
                                    .stroke(colorChoose == Color.purple0 ? .black0 : .clear, lineWidth: 2)
                                    .backgroundStyle(Color.white)
                            )
                    }
                    
                    
                    // MARK: 캐릭터 5종 선택
                    Text("캐릭터")
                        .font(.subheadline)
                        .foregroundStyle(.black0)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(alignment: .top, spacing: 20) {
                            // R
                            Image("chooseProfile_R")
                                .onTapGesture {
                                    withAnimation {
                                        self.characterChoose = .R
                                    }
                                }
                                .overlay (
                                    Circle()
                                        .inset(by: -6)
                                        .stroke(characterChoose == .R ? .black0 : .clear, lineWidth: 2)
                                        .backgroundStyle(Color.white)
                                )
                            
                            // A
                            Image("chooseProfile_A")
                                .onTapGesture {
                                    withAnimation {
                                        self.characterChoose = .A
                                    }
                                }
                                .overlay (
                                    Circle()
                                        .inset(by: -6)
                                        .stroke(characterChoose == .A ? .black0 : .clear, lineWidth: 2)
                                        .backgroundStyle(Color.white)
                                )
                            
                            // M
                            Image("chooseProfile_M")
                                .onTapGesture {
                                    withAnimation {
                                        self.characterChoose = .M
                                    }
                                }
                                .overlay (
                                    Circle()
                                        .inset(by: -6)
                                        .stroke(characterChoose == .M ? .black0 : .clear, lineWidth: 2)
                                        .backgroundStyle(Color.white)
                                )
                            
                            // I
                            Image("chooseProfile_I")
                                .onTapGesture {
                                    withAnimation {
                                        self.characterChoose = .I
                                    }
                                }
                                .overlay (
                                    Circle()
                                        .inset(by: -6)
                                        .stroke(characterChoose == .I ? .black0 : .clear, lineWidth: 2)
                                        .backgroundStyle(Color.white)
                                )
                            
                            // P
                            Image("chooseProfile_P")
                                .onTapGesture {
                                    withAnimation {
                                        self.characterChoose = .P
                                    }
                                }
                                .overlay (
                                    Circle()
                                        .inset(by: -6)
                                        .stroke(characterChoose == .P ? .black0 : .clear, lineWidth: 2)
                                        .backgroundStyle(Color.white)
                                )
                            
                        }
                        .padding(.horizontal, 30)
                        .padding(.vertical, 10)
                    }
                    .padding(.horizontal, -30)
                    .padding(.vertical, -10)
                    
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
                    .padding(.top, 90)
                    .padding(.bottom, 30)
                    
                }
                .padding([.top, .horizontal], 30)
                .background(
                    RoundedRectangle(cornerRadius: 40)
                        .foregroundStyle(Color.grey1)
                )
                
            }
        }
        .ignoresSafeArea(edges: .bottom)
        
        
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
