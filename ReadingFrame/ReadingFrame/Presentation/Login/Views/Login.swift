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
    // MARK: - Properties
    /// 뷰모델
    @ObservedObject var viewModel = LoginViewModel()

    /// 회원가입해야하는지 로그인만 하면 되는지 확인하는 변수
    /// - True: 회원가입이 필요한 유저, EnterNickname 화면으로 이동
    /// - False: 회원가입이 이미 되어 있는 유저, LoginManager가 AppTabView로 전환
    @State var haveToSignUp: Bool = false

    /// API 전송을 위한 회원가입 정보
    @State var signupInfo: SignUpInfo?

    // 회원가입용 NavigationStack을 위한 변수들
    @StateObject private var navigationManager = SignUpNavigationManager()

    // MARK: - View
    var body: some View {
        if haveToSignUp {
            NavigationStack(path: $navigationManager.path) {
                EnterNickname(
                    signupInfo: self.signupInfo ?? SignUpInfo(socialLoginType: .apple)
                )
                .environmentObject(navigationManager)
                .navigationDestination(for: SignUpNavigationDestination.self) { destination in
                    if case let .enterProfile(data) = destination {
                        EnterProfile(signupInfo: data)
                    }
                }
            }
        } else {
            VStack {
                #if DEBUG
                // 회원가입화면 확인을 위한 개발자용 버튼
                Button {
                    haveToSignUp.toggle()
                    UserApi.shared.unlink { error in
                        if let error = error {
                            print(error)
                        } else {
                            print("unlink() success.")
                        }
                    }
                } label: {
                    Text("회원가입으로 넘어가기")
                }
                .padding(.bottom, 30)
                #endif

                LogInView
            }
        }
    }
}

#Preview {
    Login()
}

// MARK: - View Components
extension Login {
    private var LogInView: some View {
        VStack(spacing: 0) {
            // 캐릭터들 이미지
            Image("character_set")
                .resizable()
                .scaledToFit()

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
        SignInWithAppleButton { _ in

        } onCompletion: { result in
            switch result {
            case .success(let auth):
                handleAppleAuth(auth)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        .signInWithAppleButtonStyle(.black)
        .frame(height: 55)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .padding(.horizontal)
    }

    /// Apple 인증 성공 후 처리
    /// - 키체인의 닉네임 유무로 분기하지 않고, **백엔드에 먼저 로그인 요청**을 보내서
    ///   기존 유저/신규 유저를 판별한다. (다른 기기에서 가입한 유저도 로그인 가능)
    private func handleAppleAuth(_ auth: ASAuthorization) {
        guard let credential = auth.credential as? ASAuthorizationAppleIDCredential,
              let idTokenData = credential.identityToken,
              let idToken = String(data: idTokenData, encoding: .utf8) else {
            print("Apple credential 파싱 실패")
            return
        }

        let userIdentifier = credential.user

        _ = KeyChainService.shared.addKeychainItem(key: .appleUserID, value: userIdentifier)
        _ = KeyChainService.shared.addKeychainItem(key: .appleIDToken, value: idToken)

        viewModel.loginApple(
            request: AppleLoginRequest(userIdentifier: userIdentifier, idToken: idToken)
        ) { result in
            switch result {
            case .success(let token):
                LoginManager.shared.handleLoginSuccess(token: token)
            case .needsSignUp:
                self.signupInfo = SignUpInfo(socialLoginType: .apple)
                haveToSignUp = true
            case .failure(let message):
                print("Apple 로그인 실패: \(message)")
            }
        }
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
    /// 카카오 로그인 진입점
    func kakaoLogin() {
        let onOAuth: (Error?) -> Void = { error in
            if let error = error {
                print("Kakao Login Error: \(error)")
                return
            }
            resolveKakaoEmailAndLogin()
        }

        if UserApi.isKakaoTalkLoginAvailable() {
            UserApi.shared.loginWithKakaoTalk { _, error in onOAuth(error) }
        } else {
            UserApi.shared.loginWithKakaoAccount { _, error in onOAuth(error) }
        }
    }

    private func resolveKakaoEmailAndLogin() {
        if let cached = KeyChainService.shared.getKeychainItem(key: .kakaoEmail), !cached.isEmpty {
            performKakaoLogin(email: cached)
            return
        }

        UserApi.shared.me { user, error in
            if let error = error {
                print("Kakao Data Error: \(error)")
                return
            }
            guard let email = user?.kakaoAccount?.email else {
                print("Kakao 이메일 조회 실패")
                return
            }
            performKakaoLogin(email: email)
        }
    }

    private func performKakaoLogin(email: String) {
        viewModel.loginKakao(request: KakaoLoginRequest(email: email)) { result in
            switch result {
            case .success(let token):
                _ = KeyChainService.shared.addKeychainItem(key: .kakaoEmail, value: email)
                LoginManager.shared.handleLoginSuccess(token: token)
            case .needsSignUp:
                _ = KeyChainService.shared.addKeychainItem(key: .kakaoEmail, value: email)
                self.signupInfo = SignUpInfo(socialLoginType: .kakao)
                haveToSignUp = true
            case .failure(let message):
                print("카카오 로그인 실패: \(message)")
            }
        }
    }
}
