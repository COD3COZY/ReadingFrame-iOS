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
    var comments: [CompactComment]
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 10) {
                // 한줄평 순서대로 보여주기
                ForEach(comments, id: \.userNickname) { comment in
                    singleCommentBox(comment: comment)
                }
            }
            // BookInfo 다른 아이템들과 여백 동일하게 보이기 위해 적용(처음 한줄평의 leading과 마지막 한줄평 trailing)
            .padding(.horizontal, 16)
        }
        // 좌우 스크롤 안보이게 하기(미관상 이게 더 예쁜 것 같음)
        .scrollIndicators(.hidden)

    }
}

extension CommentHScrollView {
    private func singleCommentBox(comment: CompactComment) -> some View {
        VStack(spacing: 6) {
            Text("\(comment.userNickname)(\(maskEmail(comment.userEmail)))")
                .font(.footnote)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(comment.comment)
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
    
    /// 이메일 주소로 개인정보 보호 아이디 만들기
    private func maskEmail(_ email: String) -> String {
        guard let atIndex = email.firstIndex(of: "@") else { return email } // '@' 위치 찾기
        
        let localPart = String(email[..<atIndex]) // '@' 앞부분만 추출
        
        let prefixPart = localPart.prefix(3) // 앞 3글자
        let maskedPart = String(repeating: "*", count: max(0, localPart.count - 3)) // 나머지를 '*'로 변환
        
        return prefixPart + maskedPart
    }
}
