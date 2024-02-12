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
        TabView(selection: $selectedTab) {
            // Tab1: 홈
            MainPage()
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
    }
}

#Preview {
    AppTabView()
}
