//
//  MainTabView.swift
//  ReadingFrame
//
//  Created by 석민솔 on 2/13/24.
//

import SwiftUI

struct AppTabView: View {
    @State private var selectedTab: Int = 0
    
    var body: some View {
        ZStack {
            TabView(selection: $selectedTab) {
                // Tab1: 홈
                Home()
                    .tabItem {
                        Image(selectedTab == 0 ? "home_selected" : "home_deselected")
                        Text("홈")
                    }
                    .tag(0)
                
                // Tab2: 책지도
                BookMap()
                    .tabItem {
                        Image(selectedTab == 1 ? "map_selected" : "map_deselected")
                        Text("책지도")
                    }
                    .tag(1)
                
                // Tab3: 마이페이지
                MyPage()
                    .tabItem {
                        Image(selectedTab == 2 ? "myPage_selected" : "myPage_deselected")
                        Text("마이")
                    }
                    .tag(2)
            }
            
            // 탭바 상단 라인 ---
            VStack {
                Spacer()
                // 책지도랑 마이페이지에서 안떠서 만들어줌
                if (selectedTab != 0) {
                    Rectangle()
                        .frame(maxWidth: .infinity, maxHeight: 0.3)
                        .foregroundColor(.black.opacity(0.3))
                        .padding(.bottom, 49)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    AppTabView()
}
