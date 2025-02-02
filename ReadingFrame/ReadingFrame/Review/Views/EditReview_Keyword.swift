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
    /// 전달받을 전체 리뷰 객체
    @StateObject var review: Review
    
    /// 기록할 단어
    @State var keyword: String = ""
    
    // MARK: 리뷰 네비게이션 Stack 관리 관련
    /// 리뷰 전체 빠져나가기 위한 클로저
    let popToRootAction: () -> Void
    
    ///  이전으로 돌아가기
    let dismissAction: () -> Void
    
    /// 리뷰 작성 빠져나가기 alert
    @State var exitReviewAlert: Bool = false
    
    
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
                    // 키워드 입력되면 바로 review 객체에 입력시키기
                    .onChange(of: keyword) {
                        review.keyword = self.keyword
                    }
                
                Spacer()
                
                // 화면 이동 버튼들
                nextButton
                    .padding(.vertical, 16)
            }
            .padding(.horizontal, 16)
            .navigationTitle("리뷰 작성")
            .navigationBarTitleDisplayMode(.inline) // 상단에 바 뜨는 모양
            // 상단 이전 버튼(리뷰 빠져나가기)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        exitReviewAlert.toggle()
                    } label: {
                        Image(systemName: "chevron.left")
                            .foregroundStyle(.black0)
                            .fontWeight(.medium)
                    }
                    // MARK: < 버튼 클릭 시 나타나는 Alert
                    .alert(
                        "이 페이지에서 나가시겠습니까?",
                        isPresented: $exitReviewAlert
                    ) {
                        Button("아니오", role: .cancel) { }
                        Button("예", role: .destructive) {
                            // 독서노트 작성 빠져나가기
                            popToRootAction()
                        }
                    } message: {
                        Text("변경사항이 저장되지 않을 수 있습니다.")
                    }
                }
            }
            .task {
                // 선택리뷰 확인
                print("---Keyword 입력 페이지 task ----")
                print("Review객체정보\n- selected: \(review.selectReviews)\n- keyword: \(review.keyword ?? "없어요. 없다니까요")\n- comment: \(review.comment ?? "없어요, 없다니까요")")
                
                // 뷰에서 review 넘겨줬을 때 입력되어있는 키워드 있으면 self.keyword에도 반영
                if let keywordText = self.review.keyword {
                    self.keyword = keywordText
                }
            }
            .onDisappear {
                if keyword.count > 0 {
                    print("작성한 키워드 review 객체에 입력")
                    review.keyword = self.keyword
                }
            }
        }
    }
}

#Preview {
    EditReview_Keyword(review: .init(), popToRootAction: {}, dismissAction: {})
}

extension EditReview_Keyword {
    private var nextButton: some View {
        HStack {
            // 이전 버튼
            Button {
                dismissAction()
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
            NavigationLink(
                value: ReviewNavigationDestination.editReview_comment(data: self.review)
            ) {
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
//                .onTapGesture {
//                    if keyword.count > 0 {
//                        review.keyword = self.keyword
//                    }
//                }
            }
        }
    }
}


