//
//  EmojiSelectPopover.swift
//  ReadingFrame
//
//  Created by 석민솔 on 2/27/24.
//

import SwiftUI

struct EmojiSelectPopover: View {
    
    // MARK: - Property
    
    /// 받아오는 한줄평 하나의 정보
    @Bindable var comment: Comment
    
    /// 리액션 종류 배열
    let reactionTypes: [commentReaction] = [.heart, .good, .wow, .sad, .angry]
    
    /// 리액션 종류별 이모지 순서대로
    let reactionEmoji: [String] = ["❤️", "👍🏻", "😲", "😢", "😤"]
    
    
    /// 이 뷰가 있는 팝오버 버튼 클릭 후 없애주기 위한 변수
    @Binding var emojiSelectViewAppear: Bool
    

    // MARK: - View
    var body: some View {
        HStack(spacing: 30) {
            // 버튼을 ForEach로 처리
            // reaction: 한줄평 반응 열거형 순서대로, emoji: 버튼으로 보여줄 이모지 텍스트
            ForEach(Array(zip(reactionTypes,reactionEmoji)), id: \.0) { reaction, emoji in
                
                Button(action: {
                    // 로직은 CommentReactionToken과 같습니다.
                    
                    // 누른 리액션이 기존에 눌렀던 리액션과 일치하는지 여부
                    if comment.myReaction == reaction {
                        withAnimation(.smooth) {
                            // 내 리액션이면 반응 취소
                            comment.myReaction = nil    // 내 리액션 없애기
                            comment.removeReaction(reaction: reaction)
                            
                            // 팝오버 없애기
                            emojiSelectViewAppear = false
                        }
                    } else {
                        // 내 리액션이 아니면 (기존 리액션 없애고 추가) or ( 새로운 반응 추가)
                        withAnimation(.default) {
                            // 기존에 내 리액션이 있었다면 그 리액션 지우기
                            if let reaction = comment.myReaction {
                                comment.removeReaction(reaction: reaction)
                            }
                            
                            comment.myReaction = reaction   // 내 리액션 바꿔주고
                            comment.addReaction(reaction: reaction) // 새로 누른 리액션 count 늘려주기
                            
                            // 팝오버 없애기
                            emojiSelectViewAppear = false
                        }
                    }
                }) {
                    // 버튼 UI: 이모지 텍스트
                    Text(emoji)
                        .font(.title3)
                }

            }
        }
        // 팝오버 가로 패딩 적용
        .padding(.horizontal, 30)
    }
}
