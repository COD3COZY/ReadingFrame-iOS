//
//  CommentHScrollView.swift
//  ReadingFrame
//
//  Created by 석민솔 on 2/20/24.
//

import SwiftUI

/// 한줄평 박스 가로 스크롤로 보여주는 뷰
struct CommentHScrollView: View {
    /// 받아올 한줄평들
    var comments: [Comment]
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 10) {
                // 한줄평 순서대로 보여주기
                ForEach(comments, id: \.self) { comment in
                    singleCommentBox(comment: comment)
                }
            }
            // BookInfo 다른 아이템들과 여백 동일하게 보이기 위해 적용(처음 한줄평의 leading과 마지막 한줄평 trailing)
            .padding(.horizontal, 16)
        }
        // 좌우 스크롤 안보이게 하기(미관상 이게 더 예쁜 것 같음)
        .scrollIndicators(.hidden)

    }
    
    
    struct singleCommentBox: View {
        var comment: Comment
        
        var body: some View {
            VStack(spacing: 6) {
                Text(comment.nickname)
                    .font(.footnote)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(comment.commentText)
                    .font(.footnote)
                    .lineLimit(2) // 최대 두 줄까지 표시
                    .truncationMode(.tail) // 말줄임표 추가
                    .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
            }
            .padding(16)
            .frame(width: 300, height: 100)
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .foregroundStyle(Color.grey1)
            )

        }
    }
}

#Preview {
    CommentHScrollView(comments: [Comment(commentText: "첫번째 리뷰"),
                                  Comment(commentText: "두번째 리뷰"),
                                  Comment(commentText: "세번째 리뷰"),
                                  Comment(commentText: "네번째 리뷰"),
                                  Comment(commentText: "다섯번째 리뷰")])
}
