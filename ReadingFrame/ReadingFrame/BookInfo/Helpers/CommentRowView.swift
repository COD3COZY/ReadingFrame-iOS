//
//  CommentRowView.swift
//  ReadingFrame
//
//  Created by 석민솔 on 2/27/24.
//

import SwiftUI

/// 한줄평 List Row
struct CommentRowView: View {
    /// API 호출해서 BookInfo_Review 페이지에서 받아올 한줄평 정보
    @Bindable var comment: Comment
    
    /// 버튼에 들어갈 날짜 text
    var dateString: String {
        // DateFormatter 형식 지정
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        
        // Date -> String
        let dateString = dateFormatter.string(from: comment.commentDate)
        
        return dateString
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            // MARK: 닉네임
            Text(comment.nickname)
                .font(.subheadline.weight(.bold))
            
            // MARK: 날짜
            Text(dateString)
                .font(.footnote)
                .foregroundStyle(.greyText)
                .padding(.bottom, 9)
            
            // MARK: 한줄평 텍스트
            Text(comment.commentText)
                .font(.subheadline)
                .padding(.bottom, 12)
            
            // MARK: 한줄평 반응 버튼들
            CommentReactionView(comment: self.comment)
        }
        .padding(.vertical, 20)

    }
}
