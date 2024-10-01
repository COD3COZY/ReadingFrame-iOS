//
//  EditReview_CheckReviews.swift
//  ReadingFrame
//
//  Created by 석민솔 on 9/23/24.
//

import SwiftUI

struct EditReview_CheckReviews: View {
    // MARK: - Properties
    /// 완성된 리뷰 객체
    @StateObject var review: Review
    
    // MARK: - View
    var body: some View {
        VStack {
            // 전체 리뷰 확인 & 전체 삭제 버튼
            // 이 책을 기럭하고 싶은 단어 한 가지
            keywordSection
            
            // 선택한 키워드
            selectReviewSection
            
            // 한줄평
            commentSection
        }
        .navigationTitle("리뷰 작성") // 네비게이션 바 타이틀
        .navigationBarTitleDisplayMode(.inline) // 상단에 바 뜨는 모양

    }
}

#Preview {
    EditReview_CheckReviews(review: .init())
}

extension EditReview_CheckReviews {
    /// 이 책을 기럭하고 싶은 단어 한 가지 섹션 UI
    private var keywordSection: some View {
        VStack {
            // 제목 & 삭제 버튼
            nameAndDeleteBar(reviewType: .keyword)
            
            // 입력된 키워드
        }
    }
    
    /// 선택한 키워드  섹션 UI
    private var selectReviewSection: some View {
        VStack {
            // 제목 & 전체 삭제 버튼
            nameAndDeleteBar(reviewType: .select)
            
            // 키워드 한줄로 보여주기
        }
    }
    
    /// 한줄평 섹션 UI
    private var commentSection: some View {
        VStack {
            // 제목 & 삭제 버튼
            nameAndDeleteBar(reviewType: .comment)
            
            if let commentText = review.comment {
                Text(commentText)
                    .onTapGesture {
                        // 한줄평 수정 sheet 띄우기
                    }
            } else {
                Text("책에 대한 생각을 자유롭게 적어주세요")
            }
            
        }
    }
    
    /// 제목 & 삭제 버튼
    @ViewBuilder
    func nameAndDeleteBar(reviewType: ReviewType) -> some View {
        
        let title: String = switch reviewType {
        case .select:
            "선택한 키워드"
        case .keyword:
            "이 책을 기억하고 싶은 단어 한 가지"
        case .comment:
            "한줄평"
        }
        
        HStack {
            // 제목
            Text(title)
            
            // 삭제 버튼 동작
            Button {
                if reviewType == .select {
                    // 선택리뷰 삭제
                    
                } else if reviewType == .keyword {
                    // 키워드 삭제
                    
                } else {
                    // 한줄평 삭제
                    
                }
            } label: {
                Image(systemName: "trash")
                    .foregroundStyle(Color.grey2)
            }

        }
    }
    
    /// 종류별 리뷰
    enum ReviewType {
        case select
        case keyword
        case comment
    }
}
