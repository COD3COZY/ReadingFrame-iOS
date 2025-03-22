//
//  MemoView.swift
//  ReadingFrame
//
//  Created by 이윤지 on 7/7/24.
//

import SwiftUI

/// 독서노트 화면에서 사용되는 개별 메모 뷰
struct MemoView: View {
    var memo: Memo
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .center, spacing: 0) {
                if let page = memo.markPage, let percent = memo.markPercent {
                    // MARK: 메모한 페이지
                    Text("\(page)p")
                        .font(.system(size: 13, weight: .semibold, design: .rounded))
                        .foregroundStyle(.black0)

                    // MARK: 책 퍼센트
                    Text("(\(percent)%)")
                        .font(.system(size: 13, weight: .semibold, design: .rounded))
                        .foregroundStyle(.greyText)
                }
                
                Spacer()
                
                // MARK: 메모한 날짜
                Text("\(DateRange.dateToString(date: memo.date))")
                    .font(.system(size: 12, weight: .regular, design: .rounded))
                    .foregroundStyle(.greyText)
            }
            
            // MARK: 메모
            Text(memo.memo)
                .font(.subheadline)
                .foregroundStyle(.black0)
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(.white)
        )
    }
}

#Preview {
    MemoView(memo: Memo(id: "1", date: Date(), markPage: nil, markPercent: nil, memo: "옆에 있는 당신이 행복하면 저도 행복해져요. 저를 행복하게 하고 싶으시다면 당신이 행복해지면 돼요. 괜찮지 않나요?"))
}
