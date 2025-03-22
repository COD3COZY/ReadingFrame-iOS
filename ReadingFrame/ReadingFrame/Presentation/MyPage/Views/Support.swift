//
//  Support.swift
//  ReadingFrame
//
//  Created by 석민솔 on 2/12/25.
//

import SwiftUI

/// 도움말 및 지원 뷰
struct Support: View {
    // MARK: - Properties
    /// 뷰모델
    @ObservedObject var vm = SupportViewModel()
    
    /// 이메일 Sheet용
    @State private var showEmailSheet = false
    
    /// 문의 이메일이 일반 문의인지 오류제보인지 체크
    @State private var isEmailForBugReport: Bool = false
    
    // MARK: - View
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                questionsSection
                    .padding(.top, 10)
                
                inquireSection
            }
        }
        .navigationTitle("도움말 및 지원")
        .navigationBarTitleDisplayMode(.inline)
    }
}


// MARK: - View Components
extension Support {
    /// 자주 묻는 질문 구역
    private var questionsSection: some View {
        VStack {
            titleText("자주 묻는 질문")
            
            ForEach(0..<vm.supportData.questions.count, id: \.self) { index in
                VStack(alignment: .leading, spacing: 0) {
                    // 질문
                    defaultListRow(vm.supportData.questions[index], isExpanded: vm.isItemIndexExpanded[index])
                        .onTapGesture {
                            withAnimation(.easeInOut) {
                                if vm.isItemIndexExpanded[index] {
                                    vm.isItemIndexExpanded[index] = false
                                } else {
                                    vm.isItemIndexExpanded[index] = true
                                }
                            }
                        }
                    
                    // 응답
                    if vm.isItemIndexExpanded[index] {
                        answerRow(vm.supportData.answers[index])
                    }
                }
            }
        }
        .sheet(isPresented: $showEmailSheet) {
            MailView(supportEmail: isEmailForBugReport ? $vm.bugReportEmail : $vm.contactEmail) { result in
                switch result {
                case .success:
                    print("Email sent")
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    /// 질문 row UI
    private func defaultListRow(_ text: String, isExpanded: Bool) -> some View {
        VStack {
            HStack {
                Text(text)
                    .foregroundStyle(.black0)
                    .multilineTextAlignment(.leading)
                    .lineLimit(5)
                
                Spacer()
                
                Image(systemName: isExpanded ? "chevron.down" : "chevron.right")
                    .foregroundStyle(.black0)
                    .fontWeight(.medium)
            }
            .padding(.vertical, 20)
            .padding(.leading, 4)
            
            Divider()
        }
        .padding(.horizontal, 16)
    }
    
    /// 응답 row UI
    private func answerRow(_ text: String) -> some View {
        VStack {
            Text(text)
                .foregroundStyle(.black0)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 15)
                .padding(.top, 20)
                .padding(.bottom, 50)
                .background(Color.grey1)
                .transition(.opacity)
        }
        .padding(.horizontal, 16)
    }
    
    /// 문의 구역
    private var inquireSection: some View {
        VStack {
            titleText("문의")
            
            defaultListRow("오류 제보", isExpanded: false)
                .onTapGesture {
                    // 이메일 앱 있을 경우, 오류 제보용 이메일 Sheet 띄우기
                    isEmailForBugReport = true
                    
                    if MailView.canSendMail {
                        showEmailSheet.toggle()
                    } else {
                        print("""
                        This device does not support email
                        \(vm.contactEmail.body)
                        """
                        )
                    }
                }
            
            defaultListRow("문의하기", isExpanded: false)
                .onTapGesture {
                    // 이메일 앱 있을 경우, 일반문의용 이메일 Sheet 띄우기
                    isEmailForBugReport = false
                    
                    if MailView.canSendMail {
                        showEmailSheet.toggle()
                    } else {
                        print("""
                        This device does not support email
                        \(vm.contactEmail.body)
                        """
                        )
                    }
                }
        }
    }
    
    
    /// 섹션 이름
    private func titleText(_ name: String) -> some View {
        Text(name)
            .font(.thirdTitle)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical, 15)
            .padding(.leading, 20)
    }

}

#Preview {
    Support()
}
