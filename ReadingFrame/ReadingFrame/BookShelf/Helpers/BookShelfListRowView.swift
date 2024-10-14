//
//  BookShelfListRowView.swift
//  ReadingFrame
//
//  Created by 석민솔 on 9/2/24.
//

import SwiftUI

/// BookShelfListByType에서 리스트 행(row)으로 사용될 뷰
struct BookShelfListRowView: View {
    /// 책정보
    let bookInfo: BookShelfRowInfo
    
    var body: some View {        
        VStack {
            HStack(alignment: .center, spacing: 12) {
                // MARK: 책 표지
                LoadableBookImage(bookCover: bookInfo.cover)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .frame(width: 80, height: 120)
                
                // 책정보
                VStack(alignment: .leading, spacing: 0) {
                    HStack {
                        // MARK: 배지
                        Badge_Info(
                            bookType: bookInfo.bookType,
                            category: bookInfo.category,
                            isMine: bookInfo.isMine
                        )
                        
                        Spacer()
                    }
                    
                    // MARK: 책 이름
                    Text(bookInfo.title)
                        .font(.headline)
                        .foregroundStyle(.black0)
                        .padding(.top, 10)
                    
                    // MARK: 저자
                    Text(bookInfo.author)
                        .font(.footnote)
                        .foregroundStyle(.black0)
                        .padding(.top, 3)
                    
                    // MARK: 진행률
                    // 읽고 있는 책일 때만 진행률 띄우기
                    if let readingPercent = bookInfo.readingPercent, let readpage = bookInfo.readPage {
                        ReadingPercentBar(readPage: readpage, totalPage: bookInfo.totalPage, readingPercent: readingPercent)
                            .frame(height: 55)
                    }
                }
                
            }
            .padding(.vertical, 15)
            
            // line
            Rectangle()
                .foregroundStyle(.grey2)
                .frame(height: 1)
        }
        .padding(.horizontal, 16)
    }
}

#Preview {
    BookShelfListRowView(bookInfo: .init(ISBN: "", cover: "https://www.hanbit.co.kr/data/books/B9421379018_l.jpg", title: "스위프트 프로그래밍", author: "야곰", bookType: .paperbook, category: .etc, isMine: true, totalPage: 200, readPage: 100, readingPercent: 50))
}
