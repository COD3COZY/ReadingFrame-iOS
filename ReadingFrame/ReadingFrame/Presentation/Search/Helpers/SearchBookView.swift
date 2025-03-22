//
//  SearchBookView.swift
//  ReadingFrame
//
//  Created by 이윤지 on 12/23/24.
//

import SwiftUI

/// 검색 결과 화면의 책 아이템 뷰
struct SearchBookView: View {
    /// 책 아이템
    var book: SearchBookResponse
    
    /// 검색어
    @Binding var searchText: String
    
    var body: some View {
        HStack(spacing: 12) {
            LoadableBookImage(bookCover: book.cover)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .frame(width: 80, height: 120)
            
            VStack(alignment: .leading, spacing: 0) {
                HighlightedTextView(text: book.title, keyword: searchText)
                    .foregroundStyle(.black0)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                HighlightedTextView(text: book.author, keyword: searchText)
                    .font(.footnote)
                    .foregroundStyle(.black0)
                    .padding(.top, 3)
                
                HStack(spacing: 5) {
                    Text("출판사")
                    Text("|")
                    Text("\(book.publisher)")
                }
                .font(.caption)
                .foregroundStyle(.greyText)
                .padding(.top, 20)
                
                HStack(spacing: 5) {
                    Text("발행일")
                    Text("|")
                    Text("\(book.publicationDate)")
                }
                .font(.caption)
                .foregroundStyle(.greyText)
                .padding(.top, 3)
            }
        }
    }
}

#Preview {
    SearchBookView(book: SearchBookResponse(isbn: "", cover: "", title: "천 개의 파랑", author: "천선란", publisher: "허블", publicationDate: "2020. 8. 19"), searchText: .constant("파랑"))
}
