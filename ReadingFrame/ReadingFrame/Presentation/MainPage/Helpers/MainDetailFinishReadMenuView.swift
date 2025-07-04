//
//  MainDetailFinishReadMenuView.swift
//  ReadingFrame
//
//  Created by 석민솔 on 7/2/25.
//

import SwiftUI

/// 다읽은 책  리스트 row일 때 메뉴
struct MainDetailFinishReadMenuView: View {
    var body: some View {
        // MARK: 정보 버튼
        NavigationLink {
            // TODO: 책 정보 화면으로 이동
        } label: {
            Label("정보", systemImage: "info.circle")
        }
        
        // MARK: 소장 버튼
        Button {
            // TODO: 소장 여부에 따라 이미 소장한 책이면 alert, 소장하지 않은 책인 경우 소장여부 변경 API 호출
        } label: {
            Label("소장", systemImage: "square.and.arrow.down")
        }
        
        // MARK: 리뷰 남기기 or 확인하기 버튼
        Button {
            // TODO: 리뷰 남기기 화면 연결
        } label: {
            Label("리뷰 남기기", systemImage: "bubble")
        }
    }
}

#Preview {
    MainDetailFinishReadMenuView()
}
