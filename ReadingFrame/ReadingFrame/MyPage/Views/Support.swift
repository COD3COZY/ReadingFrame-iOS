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
    /// 자주 묻는 질문 데이터
    let data: SupportData
    
    /// 인덱스의 질문이 토글됐는지 저장하는 배열
    @State var isItemIndexExpanded: [Bool]
    
    // init
    init() {
        self.data = SupportData()
        self.isItemIndexExpanded = .init(repeating: false, count: data.questions.count)
    }
    
    // MARK: - View
    var body: some View {
        VStack(spacing: 30) {
            questionsSection
                .padding(.top, 10)
        }
        .navigationTitle("도움말 및 지원")
        .navigationBarTitleDisplayMode(.inline)
    }
}


// MARK: - View Components
extension Support {
    /// 자주 묻는 질문 구역
    private var questionsSection: some View {
        ScrollView {
            titleText("자주 묻는 질문")
            
            ForEach(0..<data.questions.count, id: \.self) { index in
                VStack(alignment: .leading, spacing: 0) {
                    // 질문
                    questionRow(data.questions[index], isExpanded: isItemIndexExpanded[index])
                        .onTapGesture {
                            withAnimation(.easeInOut) {
                                if isItemIndexExpanded[index] {
                                    isItemIndexExpanded[index] = false
                                } else {
                                    isItemIndexExpanded[index] = true
                                }
                            }
                        }
                    
                    // 응답
                    if isItemIndexExpanded[index] {
                        answerRow(data.answers[index])
                    }
                }
            }
        }
    }
    
    /// 질문 row UI
    private func questionRow(_ text: String, isExpanded: Bool) -> some View {
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
