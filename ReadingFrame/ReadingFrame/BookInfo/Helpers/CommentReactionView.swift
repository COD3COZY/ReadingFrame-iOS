//
//  CommentReactionView.swift
//  ReadingFrame
//
//  Created by 석민솔 on 2/27/24.
//

import SwiftUI

struct CommentReactionView: View {
    @State var comment: Comment = Comment(myReaction: .heart, heartCount: 2, goodCount: 15, wowCount: 5, sadCount: 10, angryCount: 1)
    
    let reactionType: [commentReaction] = [.heart, .good, .wow, .sad, .angry]
    var reactionCount: [Int] {
        return [comment.heartCount, comment.goodCount, comment.wowCount, comment.sadCount, comment.angryCount]
    }
    
        
    
    var body: some View {
        HStack {
            // MARK: 반응 버튼
            ForEach(Array(zip(reactionType, reactionCount)), id: \.0) { reactionType, reactionCount in
                if reactionCount > 0 {
                    CommentReactionToken(comment: comment,
                                         reactionType: reactionType,
                                         reactionCount: reactionCount /*isMyReaction: (comment.myReaction == reactionType)*/)
                }
            }
            // TODO: 5개 반응 다 없을 경우 반응 추가 버튼
        }
    }
}

/// 하나의 토큰만 만들어주는 뷰
struct CommentReactionToken: View {
    @Bindable var comment: Comment
    
    /// 현재 버튼의 반응 유형
    var reactionType: commentReaction
    
    var reactionEmoji: String {
        switch reactionType {
        case .heart:
            return "❤️"
        case .good:
            return "👍🏻"
        case .wow:
            return "😲"
        case .sad:
            return "😢"
        case .angry:
            return "😤"
        }
    }
    
    var reactionCount: Int
    
    var isMyReaction: Bool {
        return comment.myReaction == reactionType
    }
    
    let accentColor = Color(red: 0.84, green: 0.14, blue: 0.33)

    
    var body: some View {
        Button(action: {}) {
            HStack(alignment: .center, spacing: 5) {
                Text(reactionEmoji)
                    .font(.footnote)
                Text(String(reactionCount))
                    .font(.footnote)
                    .foregroundColor(.black)
            }
            // 버튼 스타일
            .padding(.horizontal, 12)
            .padding(.vertical, 7)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .foregroundStyle(Color.white)
                    .shadow(color: isMyReaction ?  (accentColor.opacity(0.4)) : (.black.opacity(0.2)),
                            radius: (isMyReaction ? 2.5 : 2), x: 0, y: 0)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(isMyReaction ? accentColor : Color.clear, lineWidth: 1.5)
            )
        }
        .onTapGesture {
            // 누른 리액션이 기존에 눌렀던 리액션과 일치하는지 여부
            if isMyReaction {
                withAnimation(.smooth) {
                    // 내 리액션이면 반응 취소
                    comment.myReaction = nil    // 내 리액션 없애기
                    comment.removeReaction(reaction: reactionType)
                }
            } else {
                // 내 리액션이 아니면 (기존 리액션 없애고 추가) or ( 새로운 반응 추가)
                withAnimation(.default) {
                    // 기존에 내 리액션이 있었다면 그 리액션 지우기
                    if let reaction = comment.myReaction {
                        comment.removeReaction(reaction: reaction)
                    }
                    
                    comment.myReaction = reactionType   // 내 리액션 바꿔주고
                    comment.addReaction(reaction: reactionType) // 새로 누른 리액션 count 늘려주기
                }
            }
        }

    }
}


#Preview {
    CommentReactionView()
}
