//
//  EnterNickname.swift
//  ReadingFrame
//
//  Created by 석민솔 on 3/20/24.
//

import SwiftUI

struct EnterNickname: View {
    // MARK: - Properties
    /// API 전송을 위한 회원가입 정보
    @ObservedObject var signupInfo: SignUpInfo
    
    /// 뷰모델
    @ObservedObject var viewModel = SignUpViewModel()
    
    /// 유저가 입력할 닉네임
    @State var nickname: String = ""
    
    /// 닉네임 길이
    var nicknameLength: Int {
        return self.nickname.count
    }
    
    /// 닉네임 길이를 바탕으로 닉네임 입력 TextField 글자 불가능 표시 만들어줄 변수
    /// 1글자일 때, 20글자 이상일 때 불가능, 그 이외일 때는 불가능 UI 띄우지 않음
    /// - true: 닉네임 길이 불가
    /// - false: 닉네임 길이 통과
    var showNicknameLengthWarning: Bool {
        return !(nicknameLength == 0 || nicknameLength >= 2 && nicknameLength <= 20)
    }
    
    /// 닉네임 경고 텍스트
    var nicknameWarningText: String {
        var text: String = ""
        
        if showNicknameLengthWarning {
            text += "닉네임은 2~20글자여야 합니다\n"
        }
        if isDuplicate {
            text += "중복된 닉네임입니다"
        }
        
        return text
    }
    
    /// 중복 여부를 검사할 변수. 중복이라면 true, 중복이 아니라면 false
    @State var isDuplicate: Bool = false
    
    /// 다음 버튼 활성화 검사할 변수
    /// - 중복확인 통과 && 닉네임 길이 2~20글자
    var canGoNext: Bool {
        return (self.nicknameLength >= 2 && self.nicknameLength <= 20)
    }
    
    /// 중복검사결과 alert 띄우기용 변수
    @State var showDuplicateTestResultAlert: Bool = false
    
    /// EnterProfile로 넘기기위한 핸들러 변수
    @EnvironmentObject var navigationManager: SignUpNavigationManager
    
    // MARK: - View
    var body: some View {
        ZStack {
            // 안내 텍스트
            VStack {
                Text("ReadingFrame에 오신 걸 \n환영합니다!")
                    .font(.SecondTitle)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.top, 70)
                Spacer()
            }
            
            // 닉네임 입력하는 영역
            VStack(alignment: .leading) {
                Spacer()
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("사용하실 닉네임을 입력해주세요")
                        .font(.subheadline)
                        .foregroundStyle(.greyText)
                    
                    // 닉네임 입력하는 텍스트 필드
                    nicknameTextField
                    
                    // 닉네임에 이상 있는 경우 어떤 문제인지 알려주는 텍스트
                    Text(nicknameWarningText)
                        .font(.footnote)
                        .foregroundStyle(.red0)
                        .frame(height: 40, alignment: .top)
                        .opacity(nicknameWarningText.isEmpty ? 0 : 1)
                        .padding(.leading, 7)
                }
                .padding(.horizontal, 20)
                
                Spacer()
                
            }
            
            // 다음 버튼
            nextButton
            // MARK: 중복검사 결과 alert
            .alert("이미 사용중인 닉네임입니다", isPresented: $showDuplicateTestResultAlert) {
                Button(role: .cancel, action: {}) {
                    Text("확인")
                }
            }
        }
    }
}

// MARK: - View Parts
extension EnterNickname {
    /// 닉네임 입력하는 텍스트필드
    private var nicknameTextField: some View {
        TextField("ex. 독서왕", text: $nickname)
            .clearButton(text: $nickname)
            .warningTextField(showNicknameLengthWarning || isDuplicate)
            .onChange(of: nickname) {
                // 닉네임 글자수 20글자 못넘게 제한
                nickname = String(nickname.prefix(20))
            }
    }
    
    /// 다음 버튼
    private var nextButton: some View {
        VStack {
            // 중복검사하고 결과에 따라 EnterProfile로 이동시키거나 다시 닉네임 입력하도록
            if canGoNext {
                Button {
                    // 닉네임 중복검사 API 호출
                    viewModel.validateNickname(nickname: nickname) { success in
                        // 사용 가능한 닉네임
                        if success {
                            self.isDuplicate = false
                            
                            // signUpInfo의 nickname에 현재 유저가 입력한 닉네임 입력해주기
                            self.signupInfo.nickname = self.nickname
                            
//                            print("signupInfo")
//                            print("--nickname: \(signupInfo.nickname)")
//                            print("--platform: \(signupInfo.socialLoginType)")
                            
                            // EnterProfile로 화면 넘기기
                            navigationManager.path.append(SignUpNavigationDestination.enterProfile(data: self.signupInfo))
                        }
                        // 이미 사용중인 닉네임
                        else {
                            self.isDuplicate = true
                            
                            // 중복여부 alert 띄워주기
                            self.showDuplicateTestResultAlert.toggle()
                        }
                    }
                } label: {
                    HStack {
                        Text("다음")
                            .font(.headline)
                        Image(systemName: "chevron.forward")
                    }
                    .frame(minWidth: 100, minHeight: 48)
                    .foregroundStyle(.white)
                    .background(
                        RoundedRectangle(cornerRadius: 40)
                            .foregroundStyle(Color.main)
                    )
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding([.trailing, .bottom], 26)
                }
                
            }
            // 다음 버튼 누를 수 있는 조건 충족 안되있다면 버튼 비활성상태 유지
            else {
                Button {
                    // 빈 액션
                } label: {
                    HStack {
                        Text("다음")
                            .font(.headline)
                        Image(systemName: "chevron.forward")
                    }
                    .frame(minWidth: 100, minHeight: 48)
                    .foregroundStyle(.white)
                    .background(
                        RoundedRectangle(cornerRadius: 40)
                            .fill(Color.gray) // 비활성화 상태일 때는 회색 배경
                    )
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding([.trailing, .bottom], 26)
                .disabled(true) // 버튼 자체를 비활성화
            }
        }
        .frame(maxHeight: .infinity, alignment: .bottom)
    }
}


#Preview {
    EnterNickname(signupInfo: SignUpInfo(socialLoginType: .apple))
}
