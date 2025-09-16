//
//  EdigReview_Keyword.swift
//  ReadingFrame
//
//  Created by 석민솔 on 9/22/24.
//

import SwiftUI

/// 이 책을 기억하고 싶은 단어 한가지 키워드 입력 페이지
struct EditReview_Keyword: View {
    // MARK: - Properties
    /// 외부로 확정할 단어
    @Binding var confirmedKeyword: String?
    
    /// 이 페이지에서 기록할 단어
    @State var keyword: String = ""
    
    // 화면 전환용
    let moveToPreviousPage: () -> Void
    let moveToNextPage: () -> Void
    
    // MARK: - init
    init(
        confirmedKeyword: Binding<String?>,
        moveToPreviousPage: @escaping () -> Void,
        moveToNextPage: @escaping () -> Void
    ) {
        self._confirmedKeyword = confirmedKeyword
        self.keyword = confirmedKeyword.wrappedValue ?? ""
        
        self.moveToPreviousPage = moveToPreviousPage
        self.moveToNextPage = moveToNextPage
    }
    
    // MARK: - View
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading, spacing: 0) {
                // 안내문구
                Text("이 책을 기억하고 싶은 단어 한 가지")
                    .font(.thirdTitle)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 20)
                    .padding(.bottom, 13)
                
                Text("다른 사람에게 공개되지 않아요")
                    .font(.caption)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundStyle(Color.greyText)
                    .padding(.bottom, 25)
                
                // 키워드 입력 박스
                KeywordTextField(text: $keyword, parentViewWidth: geometry.size.width)
                    .frame(maxWidth: geometry.size.width, maxHeight: 45, alignment: .topLeading)
                
                Spacer()
                
                // 화면 이동 버튼들
                nextButton
                    .padding(.vertical, 16)
            }
            .padding(.horizontal, 16)
        }
    }
}

#Preview {
    EditReview_Keyword(confirmedKeyword: .constant("키워드"), moveToPreviousPage: {}, moveToNextPage: {})
}

extension EditReview_Keyword {
    private var nextButton: some View {
        HStack {
            // 이전 버튼
            Button {
                withAnimation {
                    moveToPreviousPage()
                }
            } label: {
                HStack {
                    Image(systemName: "chevron.left")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                    
                    Text("이전")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                }
                .padding(.vertical, 15)
                .padding(.horizontal, 25)
                .background(RoundedRectangle(cornerRadius: 40).fill(Color.main))
            }

            
            Spacer()
            
            // 다음 버튼
            Button {
                if !keyword.isEmpty {
                    confirmedKeyword = keyword
                }
                withAnimation {
                    moveToNextPage()
                }
            } label: {
                HStack {
                    Text("다음")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                    
                    Image(systemName: "chevron.right")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                }
                .padding(.vertical, 15)
                .padding(.horizontal, 25)
                .background(RoundedRectangle(cornerRadius: 40).fill(Color.main))
            }
        }
    }
}


