//
//  ContentView.swift
//  ReadingFrame
//
//  Created by 석민솔 on 1/30/24.
//

import SwiftUI

struct ContentView: View {
    
    @State var isLoading: Bool = true   // 런칭 처리 끝난 후에 바꿔줘서 화면 전환시키기 위한 변수
    
    var body: some View {
        ZStack {
            if isLoading {
                // MARK: Launch screen UI
                SplashScreenView
                    .onAppear {
                        // 런칭처리하는 코드
                        LaunchSomething()
                    }
            } else {
                // MARK: 런칭 끝나고 보여줄 화면
                // 로그인 필요할 경우 로그인 화면으로 이동
                
                // 로그인 만료되지 않은 경우에는 메인화면으로 이동
                AppTabView()
            }
        }
    }
    
    func LaunchSomething() {
        // 로그인 여부 & 데이터 로딩 관련 코드 여기에 적으면 될 것 같습니다
        // 런칭 처리 완료 후 isLoading 상태 변경
        // 지금은 시간만 지난 후에 상태변경되는 코드로 적어두었습니다
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.isLoading = false
        }
    }
}

// MARK: - 스플래시 스크린
extension ContentView {
    var SplashScreenView: some View {
        VStack {
            Spacer()
            Image("icon_temp")
                .resizable()
                .scaledToFit()
                .frame(width: 213, height: 213)
            Text("ReadingFrame")
                .font(.title)
                .fontWeight(.light)
            Spacer()
        }
    }
}

#Preview {
    ContentView()
}
