//
//  SelectReviewClusterView.swift
//  ReadingFrame
//
//  Created by 석민솔 on 2/20/24.
//

import SwiftUI

/// 받아온 선택 리뷰들 줄바꿈해서 보여주는 뷰
struct SelectReviewClusterView: View {
    /// 받아올 선택리뷰들
    var selectReviews: [selectReviewCode]
    
    /// 리뷰 한단어
    var keyword: String? = nil
    
    var body: some View {
        ScrollView(.vertical) {
            // 레이아웃 사용해서 선택리뷰들 줄바꿈
            WrapLayout(alignment: .leading) {
                if let keywords = keyword, !keywords.isEmpty {
                    Text("# \(keyword ?? "")")
                        .font(.footnote)
                        .foregroundStyle(.white)
                        .padding(.vertical, 7)
                        .padding(.horizontal, 16)
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .foregroundStyle(Color.black0)
                        )
                }
                
                ForEach(selectReviews, id: \.self) { reviewToken in
                    // 개별 토큰 모양으로 만들어서 보여줌
                    singleSelectReviewToken(reviewToken)
                }
            }
        }
    }
    
    
}

/// 선택리뷰를 입력하면 토큰 모양 텍스트 박스 만들어주는 뷰
@ViewBuilder
func singleSelectReviewToken(_ selectReview: selectReviewCode) -> some View {
    Text(selectReview.text)
        .font(.footnote)
        .padding(.vertical, 7)
        .padding(.horizontal, 16)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .foregroundStyle(Color.grey1)
        )
}

#Preview {
    SelectReviewClusterView(selectReviews: [.looksNice, .comforting, .entertaining, .convoluted, .convoluted, .environmentalIssues, .hiddenGem, .immersive], keyword: "한단어")
}
