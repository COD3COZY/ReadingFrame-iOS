//
//  Login.swift
//  ReadingFrame
//
//  Created by 석민솔 on 8/18/24.
//

import SwiftUI
import AuthenticationServices

struct Login: View {
    var body: some View {
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
    
    // TODO: 카카오 로그인 구현하기
    func kakaoLogin() {
        // 여기에 로직 입력하면 될 것 같습니다~.~
    }
}

#Preview {
    Login()
}

extension Login {
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
                
                let userIdentifier = credential.user
                let idToken = credential.identityToken // 서버에 보내줄 토큰
                
                // TODO: 서버에 애플로그인 정보 보내기
                
                // TODO: 서버에서 토큰 받으면 -> 토큰 활용해서 홈화면으로 이동
                // TODO: 서버에서 토큰 못받으면 -> 회원가입 로직으로 이동
                
                print("userID: \(String(describing: userIdentifier))")
                print("user idToken: \(String(decoding: idToken!, as: UTF8.self))")
                
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
