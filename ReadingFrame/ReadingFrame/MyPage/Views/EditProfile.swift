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
    @State var isCompleteButtonAbled: Bool = false
    
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
            
            nicknameEditSection
        }
        .navigationTitle("프로필 편집")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar { completeButton }
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
        VStack {
            Text("닉네임")
                .font(.headline)
        }
    }
    
//    /// 닉네임 박스
//    private var nicknameTextfield: some View {
//        TextField(text: $nickname)
//            .textFieldStyle(NicknameTextfieldStyle(showNicknameLengthWarning: self.showNicknameLengthWarning))
//            .onChange(of: nickname) {
//                // 닉네임 글자수 20글자 못넘게 제한
//                nickname = String(nickname.prefix(20))
//                
//                // 중복확인까지 했으면서 다시 닉네임 변경하면 다시 중복확인해서 넘어가도록(다음 버튼 비활성화도 해야함)
//                isDuplicate = true
//            }
//    }
    
    
    /// 네비게이션 바 상단 완료 버튼
    private var completeButton: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Button {
                // TODO: 저장하고 이 뷰 나가기
                
            } label: {
                Text("완료")
                    .foregroundStyle(isCompleteButtonAbled ? .main : .greyText)
            }
            .disabled(!isCompleteButtonAbled)
        }
    }
}

#Preview {
    EditProfile(character: ProfileCharacter(character: .R, color: .main), nickname: "닉네임")
}
