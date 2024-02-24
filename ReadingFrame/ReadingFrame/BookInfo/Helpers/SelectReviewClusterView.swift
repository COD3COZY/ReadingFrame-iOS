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
    let selectReviews: [selectReviewCode]
    
    var body: some View {
        ScrollView(.vertical) {
            // 레이아웃 사용해서 선택리뷰들 줄바꿈
            WrapLayout(alignment: .leading, spacing: 10) {
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
    /// 선택리뷰에 따른 실제 리뷰 텍스트값
    var selectReviewText: String {
        switch selectReview {
        case .creative:
            return "창의적이에요"
        case .fastPaced:
            return "전개가 시원해요"
        case .realistic:
            return "현실적이에요"
        case .socialTheme:
            return "사회적 주제를 다뤄요"
        case .philosophical:
            return "철학적이에요"
        case .historical:
            return "역사적인 내용을 다뤄요"
        case .environmentalIssues:
            return "환경문제를 다뤄요"
        case .newPerspective:
            return "새로운 관점을 제공해요"
        case .specialized:
            return "전문적이에요"
        case .wellStructured:
            return "구성이 탄탄해요"
        case .convoluted:
            return "난해해요"
        case .touching:
            return "감동적이에요"
        case .leaveLingering:
            return "여운이 남아요"
        case .comforting:
            return "위로가 되었어요"
        case .sad:
            return "슬퍼요"
        case .difficult:
            return "어려워요"
        case .easyToRead:
            return "쉽게 읽혀요"
        case .entertaining:
            return "재미있어요"
        case .insightful:
            return "통찰력이 있어요"
        case .informative:
            return "유익해요"
        case .immersive:
            return "몰입감 있어요"
        case .angering:
            return "화가 나요"
        case .intense:
            return "강렬해요"
        case .trustworthyAuthor:
            return "믿고보는 작가에요"
        case .hiddenGem:
            return "숨은 명작이에요"
        case .polarising:
            return "호불호가 갈릴 것 같아요"
        case .wantToOwn:
            return "소장하고 싶어요"
        case .recommend:
            return "추천하고 싶어요"
        case .readMultiple:
            return "여러 번 읽었어요"
        case .goodForGift:
            return "선물하기 좋아요"
        case .looksNice:
            return "삽화/표지가 예뻐요"
        case .wantSequel:
            return "후속편 원해요"
        }
        
    }
    
    Text(selectReviewText)
        .font(.footnote)
        .padding(.vertical, 7)
        .padding(.horizontal, 16)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .foregroundStyle(Color.grey1)
        )
}

#Preview {
    SelectReviewClusterView(selectReviews: [.looksNice, .comforting, .entertaining, .convoluted, .convoluted, .environmentalIssues, .hiddenGem, .immersive])
}
