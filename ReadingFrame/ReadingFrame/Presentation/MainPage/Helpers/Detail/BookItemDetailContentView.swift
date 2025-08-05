//
//  BookItemDetailContentView.swift
//  ReadingFrame
//
//  Created by 석민솔 on 7/2/25.
//

import SwiftUI

/// 메인 디테일뷰 리스트에서 리스트에 들어가는 정보만 표시해주는 뷰
struct BookItemDetailContentView: View {
    // MARK: - Properties
    var bookCover: String
    var readingStatus: ReadingStatus
    var bookType: BookType?
    var category: CategoryName?
    var isMine: Bool?
    var title: String
    var author: String
    var readPage: Int?
    var totalPage: Int?
    var readingPercent: Int?
    
    // MARK: - init
    /// DetailBookModel 프로토콜 준수하는 책 객체 입력하면 readingStatus에 따라 타입캐스팅해서 필요한 정보 입력하도록 함
    init(book: DetailBookModel) {
        // 기본값. 읽고싶은 책일 때도 이 경우에 포함
        self.bookCover = book.cover
        self.readingStatus = book.readingStatus
        self.bookType = nil
        self.category = book.category
        self.isMine = nil
        self.title = book.title
        self.author = book.author
        self.readPage = nil
        self.totalPage = nil
        self.readingPercent = nil
        
        // 읽는중인 책일 때
        if book.readingStatus == .reading, let currentBook = book as? ReadingBookModel {
            self.bookType = currentBook.bookType
            self.isMine = currentBook.isMine
            self.readPage = currentBook.readPage
            self.totalPage = currentBook.totalPage
            self.readingPercent = currentBook.readingPercent
        }
        
        // 다읽은 책일 때
        else if book.readingStatus == .finishRead, let currentBook = book as? FinishReadBookModel {
            self.bookType = currentBook.bookType
            self.isMine = currentBook.isMine
        }
    }
    
    // MARK: - View
    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            // 책 표지
            LoadableBookImage(bookCover: bookCover)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .frame(width: 80, height: 120)
                .padding(.trailing, 10)
            
            
            VStack(alignment: .leading, spacing: 0) {
                // 태그
                Tag_Info(
                    bookType: bookType,
                    category: category,
                    isMine: isMine
                )
                
                // 책 이름
                Text(title)
                    .font(.headline)
                    .foregroundStyle(.black0)
                    .padding(.top, 10)
                
                // 저자
                Text(author)
                    .font(.footnote)
                    .foregroundStyle(.black0)
                    .padding(.top, 3)
                
                // 진행률
                if (readingStatus == .reading) {
                    // 읽고 있는 책일 때만 진행률 띄우기
                    ReadingPercentBar(readPage: readPage!,
                                      totalPage: totalPage!,
                                      readingPercent: readingPercent!)
                    .frame(height: 55)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    BookItemDetailContentView(
        book: WantToReadBookModel(
            isbn: "",
            cover: "",
            title: "제목",
            author: "작가",
            category: .art
        )
    )
}
