//
//  EnterProfile.swift
//  ReadingFrame
//
//  Created by 석민솔 on 4/3/24.
//

import SwiftUI

struct EnterProfile: View {
    // MARK: - Properties
    /// API 전송을 위한 회원가입 정보
    @ObservedObject var signupInfo: SignUpInfo
    
    /// 선택한 색상(기본은 메인 자주색)
    @State var colorChoose: ThemeColor = .main
    
    /// (임시용) 색상의 이름 텍스트 직접 생성한 color는 이름만 뽑아내는 방법을 아직 몰라서
    @State var colorName: String = "main"
    
    /// 선택한 캐릭터(기본은 R)
    @State var characterChoose: ProfileCharacterType = .R
    
    /// 가입이 완료되면 메인화면으로 보여줄 때 변수
//    @State var isLoggedIn: Bool = false
    @Binding var isLoggedIn: Bool
    
    /// 뷰모델
    @ObservedObject var viewModel = SignUpViewModel()
    
    // MARK: - View
    var body: some View {
        EnterProfileView
            .navigationBarBackButtonHidden(true)

//        if isSignUpCompleted == false {
//            // 가입완료처리가 안되어있다면 기본적인 EnterProfile View
//            EnterProfileView
//                .navigationBarBackButtonHidden(true)
//                .onAppear {
//                    print("sign up info: \(signupInfo.nickname)")
//                }
//        } else {
//            // 가입완료가 다 되었다면 메인페이지로 넘어가도록 처리(이전 버튼 눌러도 안돌아오도록)
//            AppTabView()
//        }
    }
}




// MARK: - View Parts
extension EnterProfile {
    /// 프로필 입력 뷰 전체
    private var EnterProfileView: some View {
        ZStack (alignment: .bottom) {
            VStack {
                // MARK: 선택에 따라 프로필 보여주는 구역
                Text("사용하실 프로필을 선택해주세요")
                    .font(.subheadline)
                    .foregroundStyle(.greyText)
                    .padding(.top, 30)
                    .padding(.bottom, 20)
                
                // 선택한 색상과 캐릭터 반영되는 프로필 이미지
                choosenProfileDisplayZone
                
                // 프로필 선택 회색박스
                VStack(alignment: .leading, spacing: 20) {
                    
                    // MARK: 색상 선택
                    Text("색상")
                        .font(.subheadline)
                        .foregroundStyle(.black0)
                    
                    // 색상 5개 그리드
                    colorChooseGrid
                    
                    
                    // MARK: 캐릭터 5종 선택
                    Text("캐릭터")
                        .font(.subheadline)
                        .foregroundStyle(.black0)
                    
                    characterChooseGrid
                    
                    Spacer()
                }
                .padding([.top, .horizontal], 30)
                .padding(.bottom, 70) // SE 캐릭터 선택지 잘 보이도록 조금 밀어줌(임시, 더 좋은 방법 찾으면 변경하도록 하겠습니다!)
                .background(
                    RoundedRectangle(cornerRadius: 40)
                        .foregroundStyle(Color.grey1)
                )
                
            }
            
            
            // MARK: 가입 완료 버튼
            SignUpButton

        }
        .ignoresSafeArea(edges: .bottom)
    }
    
    /// 선택한 색상과 캐릭터 반영되는 프로필 이미지 보여주는 부분
    private var choosenProfileDisplayZone: some View {
        VStack {
            // R, I, P일 경우
            if (characterChoose == .R || characterChoose == .I || characterChoose == .P) {
                ZStack {
                    Image(characterChoose.rawValue)
                        .resizable()
                        .renderingMode(.template)
                        .aspectRatio(contentMode: .fit)
                        .foregroundStyle(colorChoose.color) // 여기에 선택한 색상
                        .frame(width: 170, height: 170)
                    // 전체 캐릭터 모양에 그림자가 적용되도록 함
                        .background(Color.white)
                        .mask {
                            if characterChoose == .R {
                                Image("character_R_fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 170, height: 170)
                            }
                            if characterChoose == .I {
                                RoundedRectangle(cornerRadius: 10)
                                    .frame(width: 58, height: 170)
                            }
                            if characterChoose == .P {
                                Image("character_P_fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 170, height: 170)
                                
                            }
                        }
                        .shadow(color: Color(red: 0.47, green: 0.47, blue: 0.47).opacity(0.25), radius: 7.5, x: 0, y: 15)
                }
                .padding(.bottom, 20)
                
                // A, M일 경우
            } else {
                ZStack {
                    Image(characterChoose.rawValue + "_" + colorChoose.name)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 170, height: 170)
                        .shadow(color: Color(red: 0.47, green: 0.47, blue: 0.47).opacity(0.25), radius: 7.5, x: 0, y: 15)
                }
                .padding(.bottom, 20)
            }
        }
    }
    
    /// 색상 선택용 5개 그리드
    private var colorChooseGrid: some View {
        HStack(spacing: 10) {
            // 자주색
            Circle()
                .frame(minWidth: 60, minHeight: 60)
                .foregroundStyle(Color.main)
                .onTapGesture {
                    withAnimation {
                        self.colorChoose = .main
                    }
                }
                .overlay (
                    Circle()
                        .inset(by: -3)
                        .stroke(colorChoose == .main ? .black0 : .clear, lineWidth: 2)
                        .backgroundStyle(Color.white)
                )
            
            // 노랑색
            Circle()
                .frame(minWidth: 60, minHeight: 60)
                .foregroundStyle(Color.yellow)
                .onTapGesture {
                    withAnimation {
                        self.colorChoose = .yellow
                    }
                }
                .overlay (
                    Circle()
                        .inset(by: -3)
                        .stroke(colorChoose == .yellow ? .black0 : .clear, lineWidth: 2)
                        .backgroundStyle(Color.white)
                )
            
            // 초록색
            Circle()
                .frame(minWidth: 60, minHeight: 60)
                .foregroundStyle(Color.emerald)
                .onTapGesture {
                    withAnimation {
                        self.colorChoose = .emerald
                    }
                }
                .overlay (
                    Circle()
                        .inset(by: -3)
                        .stroke(colorChoose == .emerald ? .black0 : .clear, lineWidth: 2)
                        .backgroundStyle(Color.white)
                )
            
            // 파랑색
            Circle()
                .frame(minWidth: 60, minHeight: 60)
                .foregroundStyle(Color.blue)
                .onTapGesture {
                    withAnimation {
                        self.colorChoose = .blue
                    }
                }
                .overlay (
                    Circle()
                        .inset(by: -3)
                        .stroke(colorChoose == .blue ? .black0 : .clear, lineWidth: 2)
                        .backgroundStyle(Color.white)
                )
            
            // 보라색
            Circle()
                .frame(minWidth: 60, minHeight: 60)
                .foregroundStyle(Color.purple0)
                .onTapGesture {
                    withAnimation {
                        self.colorChoose = .purple
                        
                    }
                }
                .overlay (
                    Circle()
                        .inset(by: -3)
                        .stroke(colorChoose == .purple ? .black0 : .clear, lineWidth: 2)
                        .backgroundStyle(Color.white)
                )
        }
    }
    
    /// 캐릭터 선택 구역
    private var characterChooseGrid: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .top, spacing: 20) {
                // R
                Image("chooseProfile_R")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
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
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
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
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
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
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
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
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
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
        .padding(.horizontal, -30)  // 스크롤 좌우 화면은 꽉차게
    }
    
    /// 가입 완료 버튼
    private var SignUpButton: some View {
        VStack {
            Button {
                // signupInfo에 선택한 캐릭터 입력해주기
                self.signupInfo.profileImageCode = ProfileImage.getProfileImageCode(
                    of: ProfileCharacter(
                        character: characterChoose,
                        color: colorChoose
                    )
                )
                
                // 잘 입력됐나 확인용
                print("signupInfo.nickname:  \(signupInfo.nickname)")
                print("signupInfo.profileImageCode:  \(signupInfo.profileImageCode)")
                print("signupInfo.socialLoginType:  \(signupInfo.socialLoginType)")
                
                
                // 회원가입 API 호출
                // MARK: 카카오 회원가입 API 호출
                if signupInfo.socialLoginType == .kakao {
                    viewModel.signUpKakao(
                        request: KakaoSignUpRequest(
                            nickname: signupInfo.nickname,
                            profileImageCode: signupInfo.profileImageCode,
                            email: KeyChain.shared.getKeychainItem(key: .kakaoEmail)!
                        )
                    ) { success in
                        // 카카오 회원가입 API 응답 성공
                        if success {
                            // 닉네임 키체인에 저장
                            // 카카오, 애플 유형에 따라 key 다르게 저장
                            if KeyChain.shared.addKeychainItem(
                                key: KeychainKeys.kakaoNickname,
                                value: signupInfo.nickname
                            ) {
                                // 메인 화면으로 이동
                                withAnimation {
                                    isLoggedIn = true
                                }
                            }
                            
                        }
                        // 카카오 회원가입 API 응답 실패
                        else {
                            
                        }
                    }
                    
                }
                // TODO: 애플 회원가입 API 호출
                else {
                    // - keychain에서 UserIdentifier, idToken 불러오기
                }
                
                // TODO: 가입 실패 시 처리하는 로직
                
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
            .padding(.horizontal)
            .padding(.bottom, 26)
        }
    }
}

#Preview {
    EnterProfile(signupInfo: SignUpInfo(socialLoginType: .kakao), isLoggedIn: .constant(false))
}
