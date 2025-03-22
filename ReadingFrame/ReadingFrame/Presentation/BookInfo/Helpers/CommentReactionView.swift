//
//  CommentReactionView.swift
//  ReadingFrame
//
//  Created by 석민솔 on 2/27/24.
//

import SwiftUI

/// 한줄평당 반응 다섯가지 토큰 버튼 보여줄 뷰
/// - 반응 개수 버튼들: 버튼을 각각 CommentReactionToken으로 뷰로 만들고 ForEach 사용해서 보여주었습니다.
/// - 반응 추가: accentColor색 추가 버튼을 누르면 EmojiSelectPopover를 띄워주고 버튼 입력하면 반영되도록 했습니다.
struct CommentReactionView: View {
    // MARK: - Property
    
    /// 리액션 남길 하나의 한줄평
    @Bindable var comment: Comment
    
    // 반응 조회, 수정 버튼 보여줄 때 ForEach로 쓰려고 만들어둔 배열들
    /// 리액션 종류 배열
    let reactionType: [commentReaction] = [.heart, .good, .wow, .sad, .angry]
    /// 리액션별 얼마나 눌렸는지 확인하는 배열
    var reactionCount: [Int] {
        return [comment.heartCount, comment.goodCount, comment.wowCount, comment.sadCount, comment.angryCount]
    }
    
    /// 반응 추가 버튼을 보여줄지 안보여줄지 알려주는 변수
    var showPlusButton: Bool {
        /// 버튼 몇 개 보이는지
        var howManyButton: Int = 0
        
        for count in reactionCount {
            if count > 0 {
                // 해당 반응이 있을 경우 버튼 종류 있다고 알려주기
                howManyButton += 1
            }
        }
        
        // 5종 모두 있으면 반응추가 버튼 숨기기
        if howManyButton == 5 {
            return false
        } else {
            // 4종 이하라면 반응추가 버튼 보여주기
            return true
        }
    }
    
    /// 반응 선택하는 다섯가지 이모지 버튼 뷰 보일지 안보일지 결정
    @State var emojiSelectViewAppear: Bool = false

    /// 이 뷰도 accentColor 적용이 검은색으로 되는 관계로 추가했습니다..
    let accentColor = Color(red: 0.84, green: 0.14, blue: 0.33)
    
    
    // MARK: - View
    var body: some View {
        HStack {
            // MARK: 반응 개수 버튼들
            ForEach(Array(zip(reactionType, reactionCount)), id: \.0) { reactionType, reactionCount in
                if reactionCount > 0 {
                    CommentReactionToken(comment: comment,
                                         reactionType: reactionType,
                                         reactionCount: reactionCount)
                }
            }
            // MARK: 반응 추가 버튼
            // 5개 반응이 다 채워져 있지 않은 경우 띄워주기
            if showPlusButton {
                // 반응 추가 버튼
                Button(action: {}) {
                    HStack(spacing: 5) {
                        Image(systemName: "plus")
                            .font(.caption)
                            .fontWeight(.semibold)
                        Image(systemName: "face.smiling")
                            .fontWeight(.medium)
                    }
                    .foregroundStyle(Color.white)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 5)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundStyle(accentColor)
                    )
                }
                // 버튼 눌렀을 때 액션
                .onTapGesture {
                    emojiSelectViewAppear.toggle()
                }
                
                // MARK: 반응 5개 중 선택하는 화면
                .popover(isPresented: $emojiSelectViewAppear) {
                    EmojiSelectPopover(comment: self.comment, emojiSelectViewAppear: self.$emojiSelectViewAppear)
                        .presentationCompactAdaptation(.popover)
                }
                // 반응추가 버튼 나타났다가 없어질 때 애니메이션 효과
                .animation(.easeInOut, value: showPlusButton)
            }
        }
    }
}
