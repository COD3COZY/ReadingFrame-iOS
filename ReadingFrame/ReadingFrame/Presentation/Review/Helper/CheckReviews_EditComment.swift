//
//  CheckReviews_EditComment.swift
//  ReadingFrame
//
//  Created by 석민솔 on 11/13/24.
//

import SwiftUI

/// 3종 확인 리뷰에서 한줄평 수정 Sheet으로 띄워질 뷰
struct CheckReviews_EditComment: View {
    // MARK: - Properties
    /// 호출한 뷰에서 받아올 한줄평
    @Binding var parentComment: String?
    
    /// 한줄평 페이지 dismiss시키기 위한 변수
    @Binding var isCommentSheetAppear: Bool
    
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
        VStack {
            HStack {
                Button {
                    // dissmiss
                    isCommentSheetAppear.toggle()
                } label: {
                    Text("취소")
                        .foregroundStyle(Color.main)
                }
                
                Spacer()
                
                Text("한줄평")
                    .font(.thirdTitle)

                Spacer()
                
                Button {
                    // 리뷰 한줄평에 여기서 작성한 한줄평 입력
                    parentComment = comment
                    
                    // dismiss
                    isCommentSheetAppear.toggle()
                    
                } label: {
                    Text("완료")
                        .font(.headline)
                        .foregroundStyle(Color.main)
                }
                
            }
            .padding(.vertical, 15)
            
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
        }
        .padding(.horizontal, 16)
        .onAppear {
            if let comment = parentComment {
                self.comment = comment
            }
        }
    }
}

#Preview {
    CheckReviews_EditComment(parentComment: .constant("안녕하시게"), isCommentSheetAppear: .constant(true))
}
