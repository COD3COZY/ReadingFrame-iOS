//
//  CommentHScrollView.swift
//  ReadingFrame
//
//  Created by 석민솔 on 2/20/24.
//

import SwiftUI

struct CommentHScrollView: View {
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing: 10) {
                // 지금은 로직없이 더미로 넣어두었습니다
                singleCommentBox(comment: Comment())
                singleCommentBox(comment: Comment())
                singleCommentBox(comment: Comment())
                singleCommentBox(comment: Comment())
                singleCommentBox(comment: Comment())
                
            }
        }

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
    CommentHScrollView()
}
