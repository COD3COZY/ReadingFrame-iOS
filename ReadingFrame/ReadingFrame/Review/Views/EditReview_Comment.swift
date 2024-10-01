//
//  EditReview_Comment.swift
//  ReadingFrame
//
//  Created by 석민솔 on 9/23/24.
//

import SwiftUI

struct EditReview_Comment: View {
    // MARK: - Properties
    /// 리뷰 입력 화면들에서 전체적으로 사용될 객체
    @StateObject var review: Review
    
    /// 텍스트 에디터에 입력하기 전에 보여줄 텍스트
    @State private var placeholderText: String = "책에 대한 생각을 자유롭게 적어주세요"
    
    /// 유저가 작성할 한줄평
    @State private var comment = ""
    
    // 글자 제한 관련 변수들
    /// 글자수 제한 200자
    let characterLimit: Int = 200
    
    /// 입력된 글자수
    @State private var typedCharacters: Int = 0
    
    
    // MARK: - View
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("한줄평을 작성해보세요")
                .font(.thirdTitle)
                .padding(.bottom, 30)
            
            // TextEditor
            ZStack(alignment: .topLeading) {
                // placeholder용 텍스트 에디터
                if self.comment.isEmpty {
                    TextEditor(text: $placeholderText)
                        .font(.body)
                        .foregroundColor(.greyText)
                        .disabled(true)
                }
                // 실제 사용할 텍스트 에디터
                TextEditor(text: $comment)
                    .font(.body)
                    .opacity(self.comment.isEmpty ? 0.5 : 1)
                    .onChange(of: comment) {
                        // 글자수 카운트 & 제한
                        typedCharacters = comment.count
                        comment = String(comment.prefix(characterLimit))
                        
                        // 한줄평 입력되면 바로 review 객체에 입력시키기
                        review.comment = self.comment
                    }
            }
            .frame(maxHeight: 300)
            
            // 글자수 띄워주기
            HStack {
                Spacer()
                Text("\(typedCharacters) / \(characterLimit)")
                    .font(.footnote)
                    .foregroundStyle(Color.gray)
            }
            
            Spacer()
            
            // 이전 다음 버튼 컨트롤
            nextButton
            
        }
        .padding(.horizontal, 16)
        .padding(.top, 20)
        .padding(.bottom, 16)
        // 네비게이션 바
        .navigationTitle("리뷰 작성") // 네비게이션 바 타이틀
        .navigationBarTitleDisplayMode(.inline) // 상단에 바 뜨는 모양
        // 텍스트 에디터 바깥쪽 클릭하면 키보드 숨기기
        .onTapGesture {
            hideKeyboard()
        }
        // 화면 전처리
        .task {
            print("---Comment 입력 페이지 task ----")
            print("Review객체정보\n- selected: \(review.selectReviews)\n- keyword: \(review.keyword ?? "없어요. 없다니까요")\n- comment: \(review.comment ?? "없어요, 없다니까요")")
            
            // 이전 뷰에서 review 넘겨줬을 때 입력되어있는 한줄평 있으면 self.comment에도 반영
            if let commentText = self.review.comment {
                self.comment = commentText
            }
        }
    }
    
    // MARK: - Methods
    /// 키보드 숨기기
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

#Preview {
    EditReview_Comment(review: .init())
}

extension EditReview_Comment {
    private var nextButton: some View {
        HStack {
//            // 이전 버튼
//            NavigationLink(destination: EditReview_Keyword(review: self.review)) {
//                HStack {
//                    Image(systemName: "chevron.left")
//                        .font(.subheadline)
//                        .fontWeight(.semibold)
//                        .foregroundColor(.white)
//                    
//                    Text("이전")
//                        .font(.headline)
//                        .fontWeight(.semibold)
//                        .foregroundColor(.white)
//                }
//                .padding(.vertical, 15)
//                .padding(.horizontal, 25)
//                .background(RoundedRectangle(cornerRadius: 40).fill(Color.main))
//            }
            
            Spacer()
            
            // 다음 버튼
            NavigationLink(destination: EditReview_CheckReviews(review: self.review).toolbarRole(.editor)) {
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
