//
//  Login.swift
//  ReadingFrame
//
//  Created by 석민솔 on 8/18/24.
//

import SwiftUI
import AuthenticationServices
import KakaoSDKAuth
import KakaoSDKCommon
import KakaoSDKUser

struct Login: View {
    /// 로그인 되었는지 확인하는 변수
    @State var isLoggedIn: Bool = false
    
    /// 회원가입해야하는지 로그인만 하면 되는지 확인하는 변수
    /// - True: 회원가입이 필요한 유저, EnterNickname 화면으로 이동
    /// - False: 회원가입이 이미 되어 있는 유저, 홈화면(AppTabView)으로 이동
    @State var haveToSignUp: Bool = false
    
    /// API 전송을 위한 회원가입 정보
    /// - 회원가입이 필요하다면 생성시켜주면 됩니다
    @State var signupInfo: SignUpInfo?
    
    var body: some View {
        VStack {
            if isLoggedIn == false {
                // 로그인이 안되어있는 상황
                if haveToSignUp == false {
                    
                    // 회원가입으로 넘어가기 야매 버튼
                    // TODO: 이 버튼 없애고 정식 로직 밟기
                    Button {
                        haveToSignUp.toggle()
                    } label: {
                        Text("회원가입으로 넘어가기")
                    }
                    .padding(.bottom, 30)
                    
                    // 기본 로그인 화면
                    LogInView
                    
                } else {
                    // 회원가입이 필요한 상태라면 닉네임 입력 화면으로 넘어가기
                    NavigationStack {
                        EnterNickname(signupInfo: self.signupInfo ?? SignUpInfo(socialLoginType: .apple))
                    }
                }
            } else {
                // 로그인이 완료되면 메인화면으로 화면 넘어가도록 처리
                AppTabView()
            }
        }
    }
}

#Preview {
    Login()
}

// MARK: - View Parts
extension Login {
    private var LogInView: some View {
        VStack(spacing: 0) {
            // 캐릭터들 이미지
            // TODO: 로직 구현되면 onTapGesture 없애기
            // 지금은 API가 없으니까 일단 이 이미지 누르면 메인화면으로 넘어가도록 설정
            Image("character_set")
                .resizable()
                .scaledToFit()
                .onTapGesture {
                    isLoggedIn.toggle()
                }
            
            // 환영 문구 텍스트
            Text("독서기록에 가장 적합한 틀, ReadingFrame\n ReadingFrame과 함께 즐거운 독서경험을 만들어보세요!")
                .foregroundStyle(Color.greyText)
                .font(.footnote)
                .multilineTextAlignment(.center)
                .padding(.top, 80)
            
            // 애플 로그인 버튼
            appleLoginButton
                .padding(.top, 80)
            
            // 카카오 로그인 버튼
            kakaoLoginButton
                .padding(.top, 10)
                .onTapGesture {
                    kakaoLogin()
                }
        }
    }

    private var appleLoginButton: some View {
        SignInWithAppleButton { (request) in
            
        } onCompletion: { (result) in
            
            // getting error or success
            switch result {
            case .success(let user):
                print("success")
                
                // do login
                guard let credential = user.credential as? ASAuthorizationAppleIDCredential else {
                    print("error")
                    return
                }
                
                // 서버에 보내줄 유저 ID
                let userIdentifier = credential.user
                // 서버에 보내줄 토큰
                let idToken = credential.identityToken
                
                // 값 확인하는 프린트문
                print("userID: \(String(describing: userIdentifier))")
                print("user idToken: \(String(decoding: idToken!, as: UTF8.self))")
                
                // 키체인에 userIdentifier, idToken 저장
                // userIdentifier 저장
                if KeyChain.shared.addKeychainItem(key: KeychainKeys.appleUserIdentifier, value: userIdentifier) {
                    print("appleUserIdentifier 키체인에 저장 완!")
                }
                
                // idToken 저장
                if KeyChain.shared.addKeychainItem(key: KeychainKeys.appleIdentityToken, value: String(decoding: idToken!, as: UTF8.self)) {
                    print("appleIdentityToken 키체인에 저장 완!")
                }
                
                
                // 기존 키체인에 닉네임이 있는지 확인
                if let appleNickname = KeyChain.shared.getKeychainItem(key: KeychainKeys.appleNickname) {
                    // 닉네임이 있으면: 로그인 로직
                    // TODO: 애플로그인 API 호출
                    
                } else {
                    // 닉네임이 없으면: 회원가입 로직
                    // 회원가입 화면으로 넘기기 위한 signUpInfo 저장
                    self.signupInfo = SignUpInfo(socialLoginType: .apple)
                    
                    // 회원가입 로직으로 전환
                    haveToSignUp = true
                }
                
                
                // TODO: 서버에서 토큰 받으면 -> 토큰 활용해서 홈화면으로 이동
                if false {
                    // 홈화면 이동
                    isLoggedIn = true
                }
                
            case .failure(let error):
                print(error.localizedDescription)
                
            }
        }
        .signInWithAppleButtonStyle(.black)
        .frame(height: 55)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .padding(.horizontal)
    }
    
    private var kakaoLoginButton: some View {
        HStack(alignment: .center) {
            Spacer()
            Image("kakao_logo")
                .resizable()
                .scaledToFit()
                .frame(width: 30)
            Text("카카오 로그인")
                .font(.title3)
                .foregroundStyle(.black.opacity(0.85))
                .padding(.vertical)
            Spacer()
        }
        .background(
            RoundedRectangle(cornerRadius: 12)
                .foregroundStyle(Color(red: 247/255, green: 228/255, blue: 54/255))
        )
        .padding(.horizontal)
    }
}

extension Login {
    // TODO: 카카오 로그인 구현하기
    func kakaoLogin() {
        // 카카오톡 앱 설치 여부 확인
        if (UserApi.isKakaoTalkLoginAvailable()) {
            // 카카오톡 앱을 통한 로그인 실행
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print("Kakao Login Error: \(error)")
                }
                
                // KeyChain에 카카오 닉네임이 저장되어 있다면
                if let email = KeyChain.shared.getKeychainItem(key: .kakaoNickname) {
                    // 카카오 로그인 API 연결
                    LoginAPI.shared.loginKakao(request: KakaoLoginRequest(email: email)) {(networkResult) -> (Void) in
                        switch networkResult {
                        // 성공
                        case .success(let data):
                            if let loginResult = data as? KakaoLoginResponse {
                                KeyChain.shared.addToken(token: loginResult.xAuthToken) // KeyChain에 토큰 저장
                                isLoggedIn = true
                            }
                        // 오류
                        case .requestErr(_):
                            print("requestErr")
                        case .pathErr:
                            print("pathErr")
                        case .serverErr:
                            print("serverErr")
                        case .networkFail:
                            print("networkFail")
                        }
                    }
                }
                // KeyChain에 카카오 이메일이 저장되어 있지 않다면
                else {
                    // 카카오 이메일 정보 가져오기
                    UserApi.shared.me {(user, error) in
                        if let error = error {
                            print("Kakao Data Error: \(error)")
                        }
                        
                        print(user?.kakaoAccount?.email ?? "no email..")
                        
                        // 카카오 이메일 저장
                        if let email = user?.kakaoAccount?.email {
                            KeyChain.shared.addKeychainItem(key: .kakaoEmail, value: email)
                            
                            self.signupInfo = SignUpInfo(socialLoginType: .kakao)
                            
                            // 회원가입 로직으로 전환
                            haveToSignUp = true
                        }
                    }
                }
            }
        }
        // 사파리를 통한 카카오 로그인 진행
        else {
            UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                if let error = error {
                    print(error)
                }
                
                // KeyChain에 카카오 닉네임이 저장되어 있다면
                if let email = KeyChain.shared.getKeychainItem(key: .kakaoNickname) {
                    // 카카오 로그인 API 연결
                    LoginAPI.shared.loginKakao(request: KakaoLoginRequest(email: email)) {(networkResult) -> (Void) in
                        switch networkResult {
                        // 성공
                        case .success(let data):
                            if let loginResult = data as? KakaoLoginResponse {
                                KeyChain.shared.addToken(token: loginResult.xAuthToken) // KeyChain에 토큰 저장
                                isLoggedIn = true
                            }
                        // 오류
                        case .requestErr(_):
                            print("requestErr")
                        case .pathErr:
                            print("pathErr")
                        case .serverErr:
                            print("serverErr")
                        case .networkFail:
                            print("networkFail")
                        }
                    }
                }
                // KeyChain에 카카오 이메일이 저장되어 있지 않다면
                else {
                    // 카카오 이메일 정보 가져오기
                    UserApi.shared.me {(user, error) in
                        if let error = error {
                            print("Kakao Data Error: \(error)")
                        }
                        
                        print(user?.kakaoAccount?.email ?? "no email..")
                        
                        // 카카오 이메일 저장
                        if let email = user?.kakaoAccount?.email {
                            KeyChain.shared.addKeychainItem(key: .kakaoEmail, value: email)
                            
                            self.signupInfo = SignUpInfo(socialLoginType: .kakao)
                            
                            // 회원가입 로직으로 전환
                            haveToSignUp = true
                        }
                    }
                }
            }
        }
    }
}
