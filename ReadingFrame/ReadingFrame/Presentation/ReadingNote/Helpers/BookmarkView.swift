//
//  BookmarkView.swift
//  ReadingFrame
//
//  Created by 이윤지 on 7/1/24.
//

import SwiftUI

/// 독서노트 화면에서 사용되는 개별 북마크 뷰
struct BookmarkView: View {
    var bookmark: Bookmark
    
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            Image(systemName: "bookmark")
                .foregroundStyle(.main)
                .font(.system(size: 24))
            
            VStack(alignment: .leading, spacing: 4) {
                Text("\(DateRange.dateToString(date: bookmark.date))")
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .foregroundStyle(.black0)
                
                if let placeName = bookmark.location?.placeName {
                    Text(placeName)
                        .font(.caption)
                        .foregroundStyle(.greyText)
                }
            }
            .padding(.horizontal, 12)
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 2) {
                Text("\(bookmark.markPage)p")
                    .font(.system(size: 28, weight: .bold, design: .rounded))
                    .foregroundStyle(.black0)
                
                Text("\(bookmark.markPercent)%")
                    .font(.caption)
                    .fontDesign(.rounded)
                    .foregroundStyle(.greyText)

            }
        }
        .padding(.horizontal, 16)
    }
}

#Preview {
    BookmarkView(bookmark: Bookmark(id: "1", date: Date(), markPage: 42, markPercent: 21))
}
