//
//  CommentReactionToken.swift
//  ReadingFrame
//
//  Created by 석민솔 on 2/27/24.
//

import SwiftUI

/// 한줄평 반응을 위한 하나의 토큰 버튼 만들어주는 뷰
struct CommentReactionToken: View {
    
    // MARK: - Property
    
    /// 받아오는 한줄평 하나의 정보
    @Bindable var comment: Comment
    
    /// 현재 버튼의 반응 유형
    var reactionType: CommentReaction
    
    /// 현재 토큰의 반응 개수
    var reactionCount: Int

    /// 반응 열거형 따라 이모티콘 문자열 정해주기
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
    
    /// 현재 토큰이 유저가 선택한 리액션인지 알려주는 값
    var isMyReaction: Bool {
        return comment.myReaction == reactionType
    }
    
    let accentColor = Color(red: 0.84, green: 0.14, blue: 0.33)

    // MARK: - View
    var body: some View {
        // 버튼 UI
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
                    // 그림자: 유저의 반응인지 유무에 따라 다르게 적용
                    .shadow(color: isMyReaction ?  (accentColor.opacity(0.4)) : (.black.opacity(0.2)),
                            radius: (isMyReaction ? 2.5 : 2), x: 0, y: 0)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    // 테두리: 유저의 반응이면 accentColor 테두리
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
