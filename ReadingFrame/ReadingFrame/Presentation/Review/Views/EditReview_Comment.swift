//
//  EditReview_Comment.swift
//  ReadingFrame
//
//  Created by 석민솔 on 9/23/24.
//

import SwiftUI

/// 한줄평 입력 페이지
struct EditReview_Comment: View {
    // MARK: - Properties
    /// 외부로 전달할 한줄평
    @Binding var confirmedComment: String?
    
    // 화면 전환용
    let moveToPreviousPage: () -> Void
    let moveToNextPage: () -> Void
    
    /// 텍스트 에디터에 입력하기 전에 보여줄 텍스트
    @State private var placeholderText: String = "책에 대한 생각을 자유롭게 적어주세요"
    
    /// 이 페이지에서 유저가 작성할 한줄평
    @State private var comment = ""
    
    // 글자 제한 관련 변수들
    /// 글자수 제한 200자
    let characterLimit: Int = 200
    
    /// 입력된 글자수
    @State private var typedCharacters: Int = 0
    

    // MARK: - init
    init(
        confirmedComment: Binding<String?>,
        moveToPreviousPage: @escaping () -> Void,
        moveToNextPage: @escaping () -> Void
    ) {
        self._confirmedComment = confirmedComment
        self.comment = confirmedComment.wrappedValue ?? ""
        
        self.moveToPreviousPage = moveToPreviousPage
        self.moveToNextPage = moveToNextPage
    }
    
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

        // 텍스트 에디터 바깥쪽 클릭하면 키보드 숨기기
        .onTapGesture {
            hideKeyboard()
        }
    }
    
    // MARK: - Methods
    /// 키보드 숨기기
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

//#Preview {
//    EditReview_Comment(review: .init())
//}

extension EditReview_Comment {
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
                if !comment.isEmpty {
                    confirmedComment = comment
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
