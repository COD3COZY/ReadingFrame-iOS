//
//  MyPage.swift
//  ReadingFrame
//
//  Created by 석민솔 on 2/13/24.
//

import SwiftUI
import StoreKit

struct MyPage: View {
    // MARK: - Properties
    @ObservedObject var vm = MyPageViewModel()

    /// 리뷰 남기기 alert
    @Environment(\.requestReview) var requestReview
    
    /// 로그아웃 alert
    @State var showLogOutAlert: Bool = false
    
    
    // MARK: - View
    var body: some View {
        NavigationStack {
            VStack {
                profileSection
                    .padding(.top, 50)
                
                badgeSection
                    .padding(.top, 36)
                
                mypageListBox
                    .padding(.top, 30)
            }
            .alert(
                "로그아웃하시겠습니까?",
                isPresented: $showLogOutAlert
            ) {
                Button("취소", role: .cancel) { }
                Button("로그아웃", role: .destructive) {
                    // TODO: 로그아웃 처리하기
                }
            }
            .navigationTitle("마이페이지")
            .navigationBarTitleDisplayMode(.inline)
        }
        .tint(.black0)
    }
}

// MARK: - View Components
extension MyPage {
    /// 캐릭터랑 닉네임
    private var profileSection: some View {
        VStack(spacing: 10) {
            // 캐릭터
            if let profile = vm.profileImage {
                CircleBorderCharcterView(profile: profile)
            } else { ProgressView() }
            
            // 닉네임
            Text(vm.nickname ?? "닉네임")
                .font(.SecondTitle)
        }
    }
    
    
    /// 배지 섹션
    private var badgeSection: some View {
        NavigationLink {
            badgeView
                .toolbarRole(.editor)
        } label: {
            badgeBox
        }

    }
    
    /// 배지 박스뷰
    private var badgeBox: some View {
        HStack {
            Text("획득한 배지")
                .font(.subheadline)
                .foregroundStyle(Color.black0)
            
            if let badgeCount = vm.badgeCount {
                Text("\(badgeCount)")
                    .font(.firstTitle)
                    .foregroundStyle(Color.main)
            }
            
            Spacer()
            
            Image(systemName: "trophy.fill")
                .font(.firstTitle)
                .fontWeight(.regular)
                .foregroundStyle(Color.black0)
        }
        .padding(16)
        .background(
            Color.grey1
        )
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .padding(.horizontal, 16)
    }
    
    /// 리스트 섹션
    private var mypageListBox: some View {
        VStack(spacing: 0) {
            // 프로필 편집
            NavigationLink {
                if let profile = vm.profileImage, let nickname = vm.nickname {
                    EditProfile(
                        character: profile,
                        nickname: nickname
                    )
                    .toolbarRole(.editor)
                }
            } label: {
                mypageListRow(text: "프로필 편집")
            }
            
            // 환경설정
            NavigationLink {
                Settings()
                    .toolbarRole(.editor)
            } label: {
                mypageListRow(text: "환경설정")
            }
            
            // 도움말 및 지원
            NavigationLink {
                Support()
                    .toolbarRole(.editor)
            } label: {
                mypageListRow(text: "도움말 및 지원")
            }
            
            // 리뷰 남기기
            Button {
                requestReview()
            } label: {
                mypageListRow(text: "리뷰 남기기")
            }
            
            Spacer()
            
            // 로그아웃 버튼
            logOutButtonSection

        }
        .background(
            RoundedRectangle(cornerRadius: 20)
                .foregroundStyle(Color.grey1)
                .ignoresSafeArea(edges: .bottom)
        )
    }
    
    /// 리스트 row UI
    private func mypageListRow(text: String) -> some View {
        VStack(spacing: 0) {
            HStack(alignment: .center) {
                Text(text)
                    .font(.body)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundStyle(.black0)
            }
            .padding(.vertical, 19)
            Divider()
        }
        .padding(.horizontal, 22)
    }
    
    /// 로그아웃 버튼
    private var logOutButtonSection: some View {
        HStack {
            Button {
                showLogOutAlert.toggle()
            } label: {
                Text("로그아웃")
                    .foregroundStyle(Color.greyText)
            }
            .padding(20)
            
            Spacer()
        }
    }
}

// MARK: - 연결되는 페이지
extension MyPage {
    // TODO: 배지 VM 만들어서 다시 연결할 뷰 작성하기
    private var badgeView: some View {
        VStack {
            Text("쭈르륵 배지 와다다")
        }
    }
}

#Preview {
    MyPage()
}
