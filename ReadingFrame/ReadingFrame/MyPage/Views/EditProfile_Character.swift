//
//  EditProfile_Character.swift
//  ReadingFrame
//
//  Created by 석민솔 on 2/12/25.
//

import SwiftUI

/// 프로필 캐릭터 수정하는 뷰
struct EditProfile_Character: View {
    // MARK: - Properties
    @ObservedObject var vm: EditProfileViewModel
    @Environment(\.dismiss) private var dismiss
    
    /// 현재 화면에서 고르는 캐릭터(저장하기 전 모니터링용 객체)
    @State var profileToChoose: ProfileCharacter
    
    /// 선택값이 변경되면 완료 버튼 활성화
    var isCompleteButtonAbled: Bool {
        vm.profileCharacter.character != profileToChoose.character
        || vm.profileCharacter.color != profileToChoose.color
    }
    
    // alert 관련 변수들
    /// 빠져나가면 저장안됨 alert
    @State var showDontSaveAlert: Bool = false
    
    /// 변경안됨 경고 alert
    @State var showCannotChangeAlert: Bool = false
    
    
    // MARK: - init
    init(vm: ObservedObject<EditProfileViewModel>) {
        self._vm = vm
        self._profileToChoose = State(wrappedValue: vm.wrappedValue.profileCharacter)
    }
    
    // MARK: - View
    var body: some View {
        VStack(spacing: 0) {
            // 선택한 캐릭터 보여주는 구역
            CircleBorderCharcterView(profile: profileToChoose, baseSize: 180)
                .padding(.vertical, 30)
            
            // 프로필 선택 회색박스
            profileChooseSection
            
        }
        .navigationTitle("프로필 편집")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar { completeButton }
        .alert(
            "이 페이지에서 나가시겠습니까?",
            isPresented: $showDontSaveAlert
        ) {
            Button("아니오", role: .cancel) { }
            Button("예", role: .destructive) {
                dismiss()
            }
        } message: {
            Text("변경사항이 저장되지 않을 수 있습니다")
        }

    }
}

// MARK: - Components
extension EditProfile_Character {
    /// 프로필 선택 회색박스
    private var profileChooseSection: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            // MARK: 색상 선택
            Text("색상")
                .font(.subheadline)
                .foregroundStyle(.black0)
                .padding(.top, 5)
                .padding(.bottom, 20)
            
            // 색상 5개 그리드
            colorChooseGrid
                .padding(.bottom, 30)
            
            
            // MARK: 캐릭터 5종 선택
            Text("캐릭터")
                .font(.subheadline)
                .foregroundStyle(.black0)
                .padding(.vertical, 20)
            
            characterChooseGrid
            
            Spacer()
        }
        .padding([.top, .horizontal], 20)
        .padding(.bottom, 70) // SE 캐릭터 선택지 잘 보이도록 조금 밀어줌(임시, 더 좋은 방법 찾으면 변경하도록 하겠습니다!)
        .background(
            RoundedRectangle(cornerRadius: 25)
                .foregroundStyle(Color.grey1)
                .ignoresSafeArea(edges: .bottom)
        )
    }
    
    /// 색상 선택용 5개 그리드
    private var colorChooseGrid: some View {
        HStack(spacing: 10) {
            let strokeWidth: CGFloat = 3
            // 자주색
            Circle()
                .frame(minWidth: 60, minHeight: 60)
                .foregroundStyle(Color.main)
                .onTapGesture {
                    withAnimation {
                        self.profileToChoose.color = .main
                    }
                }
                .overlay (
                    Circle()
                        .stroke(profileToChoose.color == .main ? .black0 : .clear, lineWidth: strokeWidth)
                )
            
            // 노랑색
            Circle()
                .frame(minWidth: 60, minHeight: 60)
                .foregroundStyle(Color.yellow)
                .onTapGesture {
                    withAnimation {
                        self.profileToChoose.color = .yellow
                    }
                }
                .overlay (
                    Circle()
                        .stroke(profileToChoose.color == .yellow ? .black0 : .clear, lineWidth: strokeWidth)
                )
            
            // 초록색
            Circle()
                .frame(minWidth: 60, minHeight: 60)
                .foregroundStyle(Color.emerald)
                .onTapGesture {
                    withAnimation {
                        self.profileToChoose.color = .emerald
                    }
                }
                .overlay (
                    Circle()
                        .stroke(profileToChoose.color == .emerald ? .black0 : .clear, lineWidth: strokeWidth)
                )
            
            // 파랑색
            Circle()
                .frame(minWidth: 60, minHeight: 60)
                .foregroundStyle(Color.blue)
                .onTapGesture {
                    withAnimation {
                        self.profileToChoose.color = .blue
                    }
                }
                .overlay (
                    Circle()
                        .stroke(profileToChoose.color == .blue ? .black0 : .clear, lineWidth: strokeWidth)
                )
            
            // 보라색
            Circle()
                .frame(minWidth: 60, minHeight: 60)
                .foregroundStyle(Color.purple0)
                .onTapGesture {
                    withAnimation {
                        self.profileToChoose.color = .purple
                        
                    }
                }
                .overlay (
                    Circle()
                        .stroke(profileToChoose.color == .purple ? .black0 : .clear, lineWidth: strokeWidth)
                )
        }
    }
    
    /// 캐릭터 선택 구역
    private var characterChooseGrid: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            let circleSize: CGFloat = 106
            HStack(alignment: .top, spacing: 20) {
                // R
                Image("chooseProfile_R")
                    .resizable()
                    .scaledToFit()
                    .frame(width: circleSize, height: circleSize)
                    .onTapGesture {
                        withAnimation {
                            self.profileToChoose.character = .R
                        }
                    }
                    .overlay (
                        Circle()
                            .inset(by: -6)
                            .stroke(profileToChoose.character == .R ? .black0 : .clear, lineWidth: 2)
                            .backgroundStyle(Color.white)
                    )
                
                // A
                Image("chooseProfile_A")
                    .resizable()
                    .scaledToFit()
                    .frame(width: circleSize, height: circleSize)
                    .onTapGesture {
                        withAnimation {
                            self.profileToChoose.character = .A
                        }
                    }
                    .overlay (
                        Circle()
                            .inset(by: -6)
                            .stroke(profileToChoose.character == .A ? .black0 : .clear, lineWidth: 2)
                            .backgroundStyle(Color.white)
                    )
                
                // M
                Image("chooseProfile_M")
                    .resizable()
                    .scaledToFit()
                    .frame(width: circleSize, height: circleSize)
                    .onTapGesture {
                        withAnimation {
                            self.profileToChoose.character = .M
                        }
                    }
                    .overlay (
                        Circle()
                            .inset(by: -6)
                            .stroke(profileToChoose.character == .M ? .black0 : .clear, lineWidth: 2)
                            .backgroundStyle(Color.white)
                    )
                
                // I
                Image("chooseProfile_I")
                    .resizable()
                    .scaledToFit()
                    .frame(width: circleSize, height: circleSize)
                    .onTapGesture {
                        withAnimation {
                            self.profileToChoose.character = .I
                        }
                    }
                    .overlay (
                        Circle()
                            .inset(by: -6)
                            .stroke(profileToChoose.character == .I ? .black0 : .clear, lineWidth: 2)
                            .backgroundStyle(Color.white)
                    )
                
                // P
                Image("chooseProfile_P")
                    .resizable()
                    .scaledToFit()
                    .frame(width: circleSize, height: circleSize)
                    .onTapGesture {
                        withAnimation {
                            self.profileToChoose.character = .P
                        }
                    }
                    .overlay (
                        Circle()
                            .inset(by: -6)
                            .stroke(profileToChoose.character == .P ? .black0 : .clear, lineWidth: 2)
                            .backgroundStyle(Color.white)
                    )
                
            }
            .padding(.horizontal, 30)
            .padding(.vertical, 10)
        }
        .padding(.horizontal, -30)  // 스크롤 좌우 화면은 꽉차게
    }
    
    /// 네비게이션 바 상단 완료 버튼
    private var completeButton: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Button {
                // TODO: 저장하고 이 뷰 나가기
                if vm.saveCharacter(profileToChoose) {
                    dismiss()  // 뷰 닫기
                } else {
                    showCannotChangeAlert.toggle()
                }
            } label: {
                Text("완료")
                    .foregroundStyle(isCompleteButtonAbled ? .main : .greyText)
            }
            .disabled(!isCompleteButtonAbled)
            .alert(
                "변경사항을 저장하지 못했습니다",
                isPresented: $showCannotChangeAlert
            ) {
                Button("확인") { }
            } message: {
                Text("변경사항을 저장하시려면\n다시 한 번 완료 버튼을 눌러주세요")
            }
        }
    }
}

#Preview {
    EditProfile_Character(
        vm: ObservedObject(
            wrappedValue: EditProfileViewModel(
                character: ProfileCharacter(
                    character: .R,
                    color: .main
                ),
                nickname: "홍길동"
            )
        )
    )
}
