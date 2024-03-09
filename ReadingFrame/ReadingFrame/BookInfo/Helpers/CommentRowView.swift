//
//  CommentRowView.swift
//  ReadingFrame
//
//  Created by 석민솔 on 2/27/24.
//

import SwiftUI

/// 한줄평 List Row
struct CommentRowView: View {
    // MARK: - Property
    
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
    
    /// 이 row의 리뷰가 유저의 리뷰인지 확인하고 더보기 버튼 대신 삭제 버튼을 띄워줄 값
    var isMyReview: Bool {
        // TODO: 내 닉네임과 comment 닉네임이 일치하는지 검사
        // 지금은 일단 dummy로 독서왕으로 설정
        if (comment.nickname == "독서왕") {
            return true
        } else {
            return false
        }
    }
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            // 닉네임, 날짜, 메뉴 버튼
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 3) {
                    // MARK: 닉네임
                    Text(comment.nickname)
                        .font(.subheadline.weight(.bold))
                    
                    // MARK: 날짜
                    Text(dateString)
                        .font(.footnote)
                        .foregroundStyle(.greyText)
                        .padding(.bottom, 9)
                }
                
                Spacer()
                
                // MARK: 메뉴 or 삭제 버튼
                if isMyReview {
                    // 내가 쓴 리뷰라면 삭제 '버튼' 보여주기
                    Button(action: {
                        print("내가 쓴 한줄평 삭제")
                        // TODO: 삭제하시겠습니까 알람창 띄워주기
                    }) {
                        Image(systemName: "xmark")
                            .font(.body)
                            .foregroundStyle(.black0)
                    }
                } else {
                    // 내가 쓴 리뷰가 아니라면 신고 메뉴 보여주기
                    Menu {
                        Menu("신고하기") {
                            Button("부적절한 리뷰", action: {
                                print("부적절한 리뷰입니다.")
                                // TODO: 신고 알람창 띄우기
                                
                                // 신고하겠다는 확인 들어오면
                                // TODO: 신고하기 API 호출하기 reportType: 0
                            })
                            Button("스팸/도배성 리뷰", action: {
                                print("스팸/도배성 리뷰입니다.")
                                // TODO: 신고 알람창 띄우기
                                
                                // 신고하겠다는 확인 들어오면
                                // TODO: 신고하기 API 호출하기 reportType: 1
                            })
                        }
                    } label: {
                        Image(systemName: "ellipsis")
                            .font(.body)
                            .foregroundStyle(.black0)
                    }
                    
                }
            }
            
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
