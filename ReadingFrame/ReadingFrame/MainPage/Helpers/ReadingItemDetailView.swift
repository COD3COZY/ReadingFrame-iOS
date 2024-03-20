//
//  ReadingItemDetailView.swift
//  ReadingFrame
//
//  Created by 이윤지 on 3/17/24.
//

import SwiftUI

/// 읽고 있는 책 상세 페이지의 리스트에 들어갈 아이템 뷰
struct ReadingItemDetailView: View {
    
    /// 읽고 있는 책 객체
    @Bindable var book: RegisteredBook
    
    var body: some View {
        ZStack {
            NavigationLink {
                ReadingNote().toolbarRole(.editor)
            } label: {
                EmptyView()
            }
            .frame(width: 0, height: 0)
            .hidden()
            
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    LoadableBookImage(bookCover: book.book.cover)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .frame(width: 80, height: 120)
                        .padding(.trailing, 10)
                    
                    VStack(alignment: .leading, spacing: 0) {
                        HStack {
                            // MARK: 배지
                            Badge_Info(
                                bookType: book.bookType,
                                category: book.book.categoryName,
                                isMine: book.isMine
                            )
                            
                            Spacer()
                            
                            // MARK: Menu
                            Menu {
                                
                            } label: {
                                Image(systemName: "ellipsis")
                                    .font(.subheadline)
                                    .foregroundStyle(.black0)
                            }
                        }
                        
                        // MARK: 책 이름
                        Text("\(book.book.title)")
                            .font(.headline)
                            .foregroundStyle(.black0)
                            .padding(.top, 10)
                        
                        // MARK: 저자
                        Text("\(book.book.author)")
                            .font(.footnote)
                            .foregroundStyle(.black0)
                            .padding(.top, 3)
                        
                        // MARK: 진행률
                        ReadingPercentBar(book: book)
                            .frame(height: 55)
                    }
                }
                
                // MARK: Line
                Rectangle()
                    .foregroundStyle(.grey2)
                    .frame(height: 1)
                    .padding(.top, 16)
            }
            .padding(.top, 16)
        }
    }
}

#Preview {
    ReadingItemDetailView(book: RegisteredBook())
}
