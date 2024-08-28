//
//  ContentView.swift
//  ReadingFrame
//
//  Created by 석민솔 on 1/30/24.
//

import SwiftUI

struct LaunchView: View {
    // MARK: - Properties
    /// 런칭 처리 끝난 후에 바꿔줘서 화면 전환시키기 위한 변수
    @State var isLoading: Bool = true
    
    /// 로그인되어있는지 확인하는 변수
    /// (이 변수에 따라 로그인 화면으로 이동할지, 홈화면으로 이동할지 결정됨)
    @State var isLoggedIn: Bool = false
    
    // MARK: - View
    var body: some View {
        if isLoading {
            // MARK: Launch screen UI
            SplashScreenView
                .onAppear {
                    // 런칭처리하는 코드
                    LaunchSomething()
                }
        } else {
            // MARK: 런칭 끝나고 보여줄 화면
            if isLoggedIn {
                // 로그인 만료되지 않은 경우에는 메인화면으로 이동
                AppTabView()
                
            } else {
                // 로그인 필요할 경우 로그인 화면으로 이동
                Login()
            }
            
        }
    }
    
}

// MARK: - 스플래시 스크린
extension LaunchView {
    var SplashScreenView: some View {
        VStack {
            Spacer()
            Image("icon_temp")
                .resizable()
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 40))
                .frame(width: 213, height: 213)
            Text("ReadingFrame")
                .font(.title)
                .fontWeight(.light)
            Spacer()
        }
    }
}

// MARK: - Methods
extension LaunchView {
    /// 로그인 여부 & 데이터 로딩 함수
    func LaunchSomething() {
        // !!!: 테스트용 토큰 임의로 만들고 삭제하는 코드 여기에 작성하시면 됩니다
        // ex. KeyChain.shared.addToken()
        // ex. KeyChain.shared.deleteToken()
        
        // xAuthToken 있는지 키체인에서 불러오기
        if let token = KeyChain.shared.getToken() {
            print("토큰 있다")
            print(token)
            
            // 토큰 있다면 AppTabView로 전환
            isLoggedIn = true
            
        } else {
            // 토큰 없다면 -> 로그인 화면으로 바로 이동
            print("토큰 없음. 못찾음.")
            
        }
        
        // 런칭 처리 완료. 로딩 끝내기
        // 시간이 너무 짧게 걸려서 일단 2초정도는 스플래시 보여주려고 합니다
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.isLoading = false
        }
    }
}

#Preview {
    LaunchView()
}
