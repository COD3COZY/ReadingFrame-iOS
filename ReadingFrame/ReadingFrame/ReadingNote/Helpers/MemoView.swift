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
                // MARK: 메모한 페이지
                Text("\(memo.markPage)")
                    .font(.system(size: 13, weight: .semibold, design: .rounded))
                    .foregroundStyle(.black0)
                Text("p")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundStyle(.black0)
                
                Text("(")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundStyle(.greyText)
                // MARK: 책 퍼센트
                Text("\(memo.markPercent)")
                    .font(.system(size: 13, weight: .semibold, design: .rounded))
                    .foregroundStyle(.greyText)
                Text("%)")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundStyle(.greyText)
                
                Spacer()
                
                // MARK: 메모한 날짜
                Text("\(DateRange().dateToString(date: memo.date))")
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
    MemoView(memo: Memo(id: "1", date: Date(), markPage: 24, markPercent: 20, memo: "메모입니다."))
}
