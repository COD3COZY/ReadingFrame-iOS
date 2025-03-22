//
//  EditProfile.swift
//  ReadingFrame
//
//  Created by 석민솔 on 2/12/25.
//

import SwiftUI

/// 프로필 캐릭터와 닉네임 수정하는 페이지
struct EditProfile: View {
    // MARK: Properties
    @StateObject var vm: EditProfileViewModel
    
    /// 현재 뷰에서 수정할 닉네임
    @State var nickname: String
    
    /// 닉네임이 변경되면 완료 버튼 활성화
    var isCompleteButtonAbled: Bool {
        self.nickname != vm.nickname
        && (nickname.count >= 2 && nickname.count <= 20)
    }
    
    // alert 관련 변수
    /// 닉네임 변경 결과 alert
    @State var showCompleteButtonAlert: Bool = false
    
    /// 닉네임 변경 결과로 보여줄 텍스트
    @State var nicknameChangeResultMessage: String = ""
    
    /// 탈퇴하기 확인용 alert
    @State var showDeleteAccountAlert: Bool = false
    
    // MARK: - init
    init(
        character: ProfileCharacter,
        nickname: String
    ) {
        self._vm = StateObject(
            wrappedValue: EditProfileViewModel(
                character: character,
                nickname: nickname
            )
        )
        self._nickname = State(wrappedValue: nickname)
    }
    
    // MARK: - View
    var body: some View {
        VStack {
            profileImageSection
                .padding(.top, 30)
            
            nicknameEditSection
                .padding(.top, 50)
            
            Spacer()
            
            deleteAccountButton
        }
        .navigationTitle("프로필 편집")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar { completeButton }
        .alert("탈퇴하시겠습니까?", isPresented: $showDeleteAccountAlert) {
            Button("아니오", role: .cancel) { }
            Button("예", role: .destructive) {
                if vm.deleteAccount() {
                    // 탈퇴 처리 성공 처리
                    // TODO: 로그인 창으로 리다이렉트
                    print("탈퇴되었습니다")
                } else {
                    print("탈퇴 실패")
                }
            }
        } message: {
            Text("회원 탈퇴 시, 계정은 삭제되며 복구할 수 없습니다.")
        }
        .alert(nicknameChangeResultMessage, isPresented: $showCompleteButtonAlert) {
            Button("확인", role: .cancel) { }
        }
    }
}

extension EditProfile {
    /// 프로필 이미지 보여주고 수정용 연필 버튼 있는 구역
    private var profileImageSection: some View {
        VStack {
            CircleBorderCharcterView(
                profile: vm.profileCharacter,
                baseSize: 180
            )
            .overlay(alignment: .bottomTrailing) {
                NavigationLink {
                    EditProfile_Character(vm: ObservedObject(wrappedValue: vm))
                        .toolbarRole(.editor)
                } label: {
                    editButton
                }
            }
        }
    }
    
    /// 프로필 수정 버튼 연필모양
    private var editButton: some View {
        Image(systemName: "pencil")
            .foregroundStyle(.black0)
            .font(.largeTitle)
            .background(
                Circle()
                    .foregroundStyle(.white)
                    .frame(width: 60, height: 60)
            )
            .shadow(color: .black.opacity(0.12), radius: 3.5, x: 1, y: 2)
    }
    
    /// 닉네임 수정 구역
    private var nicknameEditSection: some View {
        VStack(spacing: 0) {
            Text("닉네임")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 20)
            
            nicknameTextfield
                .frame(height: 50)
            
            // 글자수 카운터
            Text("(\(nickname.count)/20)")
                .font(.footnote)
                .foregroundStyle(.greyText)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.top, 7)
        }
        .padding(.horizontal, 16)
    }
    
    /// 닉네임 입력 필드
    private var nicknameTextfield: some View {
        TextField(nickname, text: $nickname)
            .clearButton(text: $nickname)
            .onChange(of: nickname) {
                // 닉네임 글자수 20글자 못넘게 제한
                nickname = String(nickname.prefix(20))
            }
    }
    
    /// 네비게이션 바 상단 완료 버튼
    private var completeButton: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Button {
                // 닉네임 저장 결과에 따라 alert 메시지 다르게 입력해주고 띄우기
                if vm.saveNickname(nickname) {
                    self.nicknameChangeResultMessage = "닉네임 변경이 완료되었습니다"
                    self.showCompleteButtonAlert.toggle()
                } else {
                    self.nicknameChangeResultMessage = "이미 사용중인 닉네임입니다."
                    self.showCompleteButtonAlert.toggle()
                }
            } label: {
                Text("완료")
                    .foregroundStyle(isCompleteButtonAbled ? .main : .greyText)
            }
            .disabled(!isCompleteButtonAbled)
        }
    }
    
    /// 탈퇴하기 버튼
    private var deleteAccountButton: some View {
        HStack {
            Button {
                showDeleteAccountAlert.toggle()
            } label: {
                Text("탈퇴하기")
                    .font(.subheadline)
                    .foregroundColor(.black.opacity(0.2))
            }
            
            Spacer()
        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    EditProfile(character: ProfileCharacter(character: .R, color: .main), nickname: "닉네임")
}
