//
//  BookShelfListByType.swift
//  ReadingFrame
//
//  Created by 석민솔 on 7/24/24.
//

import SwiftUI

/// 서재 리스트로 보기 뷰
struct BookShelfListByType: View {
    // MARK: - Properties
    /// 서가 종류
    let bookshelfSubtype: BookEnum
    
    // TODO: API 입력받기
    // 현재는 임시데이터
    /// API에서 입력받은 해당 서가의 모든 책정보
    let allBooks: [BookShelfRowInfo] = [
        BookShelfRowInfo(ISBN: "9788901285894", cover: "https://image.aladin.co.kr/product/34372/90/cover500/8901285894_1.jpg", title: "불안세대", author: "조너선 하이트", bookType: nil, category: .humanSocial, isMine: nil, totalPage: 528, readPage: nil, readingPercent: nil),
        BookShelfRowInfo(ISBN: "9791139717013", cover: "https://image.aladin.co.kr/product/34361/12/cover500/k922932902_1.jpg", title: "일생에 한번은 헌법을 읽어라", author: "이효원", bookType: .eBook, category: .humanSocial, isMine: true, totalPage: 328, readPage: 40, readingPercent: 12),
        BookShelfRowInfo(ISBN: "af;lkdsjfa", cover: "https://image.aladin.co.kr/product/25470/6/cover500/k092633826_3.jpg", title: "공정하다는 착각", author: "작가", bookType: .paperbook, category: .humanSocial, isMine: false, totalPage: 420, readPage: nil, readingPercent: nil),
        BookShelfRowInfo(ISBN: "9788901285894", cover: "https://image.aladin.co.kr/product/34372/90/cover500/8901285894_1.jpg", title: "불안세대", author: "조너선 하이트", bookType: nil, category: .humanSocial, isMine: nil, totalPage: 528, readPage: nil, readingPercent: nil),
        BookShelfRowInfo(ISBN: "9791139717013", cover: "https://image.aladin.co.kr/product/34361/12/cover500/k922932902_1.jpg", title: "일생에 한번은 헌법을 읽어라", author: "이효원", bookType: .eBook, category: .humanSocial, isMine: true, totalPage: 328, readPage: 40, readingPercent: 12),
        BookShelfRowInfo(ISBN: "af;lkdsjfa", cover: "https://image.aladin.co.kr/product/25470/6/cover500/k092633826_3.jpg", title: "공정하다는 착각", author: "작가", bookType: .paperbook, category: .humanSocial, isMine: false, totalPage: 420, readPage: nil, readingPercent: nil),
        BookShelfRowInfo(ISBN: "9788901285894", cover: "https://image.aladin.co.kr/product/34372/90/cover500/8901285894_1.jpg", title: "불안세대", author: "조너선 하이트", bookType: nil, category: .humanSocial, isMine: nil, totalPage: 528, readPage: nil, readingPercent: nil),
        BookShelfRowInfo(ISBN: "9791139717013", cover: "https://image.aladin.co.kr/product/34361/12/cover500/k922932902_1.jpg", title: "일생에 한번은 헌법을 읽어라", author: "이효원", bookType: .eBook, category: .humanSocial, isMine: true, totalPage: 328, readPage: 40, readingPercent: 12),
        BookShelfRowInfo(ISBN: "af;lkdsjfa", cover: "https://image.aladin.co.kr/product/25470/6/cover500/k092633826_3.jpg", title: "공정하다는 착각", author: "작가", bookType: .paperbook, category: .humanSocial, isMine: false, totalPage: 420, readPage: nil, readingPercent: nil),
        BookShelfRowInfo(ISBN: "af;lkdsjfa", cover: "https://image.aladin.co.kr/product/25470/6/cover500/k092633826_3.jpg", title: "공정하다는 착각", author: "작가", bookType: .paperbook, category: .humanSocial, isMine: false, totalPage: 420, readPage: nil, readingPercent: nil),
    ]
    
    /// 검색어
    @State private var searchQuery = ""
    
    /// 표시할 책들의 정보
    @State private var filteredBooks: [BookShelfRowInfo]
    
    init(bookshelfSubtype: BookEnum, searchQuery: String = "") {
        self.bookshelfSubtype = bookshelfSubtype
        self.searchQuery = ""
        self.filteredBooks = allBooks
    }
    
    // MARK: - View
    var body: some View {
        VStack(spacing: 0) {
            // MARK: 검색박스
            HStack(alignment: .center, spacing: 6) {
                Image(systemName: "magnifyingglass")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 15)
                    .foregroundStyle(Color.greyText)
                
                TextField("제목, 작가를 입력하세요", text: $searchQuery)
                    .textFieldStyle(.plain)
            }
            .padding(.vertical, 7)
            .padding(.horizontal, 8)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(Color.grey1)
            )
            .padding(.bottom, 20)
            
            // MARK: 서재 title
            // bookshelfSubtype, 몇 권 있는지
            HStack(spacing: 0) {
                Text(bookshelfSubtype.name)
                    .font(.firstTitle)
                    .padding(.trailing, 6)
                
                Text(String(filteredBooks.count))
                    .font(.firstTitle)
                    .fontDesign(.rounded)
                
                Spacer()
            }
            .padding(.bottom, 15)
            
            ScrollView {
                // MARK: BookshelfView
                BookShelfView(totalPages: filteredBooks.map { $0.totalPage })
                    .padding(.bottom, 20)
                
                // MARK: List
                ForEach(filteredBooks) { book in
                    BookShelfListRowView(bookInfo: book)
                }
            }
            .padding(.horizontal, -16) // 스크롤은 화면 끝에 뜨도록 상쇄시키기
        }
        .padding(.horizontal, 16)
        // 검색어 변하면 다시 검색시키기
        .onChange(of: searchQuery) {
            search()
        }
        .navigationTitle("책장")
    }
}

#Preview {
    BookShelfListByType(bookshelfSubtype: CategoryName.humanSocial)
}

// MARK: - Functions
extension BookShelfListByType {
    /// 제목과 저자로 검색하기
    func search() {
        if searchQuery.isEmpty {
            filteredBooks = allBooks
        } else {
            filteredBooks = allBooks.filter { book in
                book.title.localizedCaseInsensitiveContains(searchQuery) ||
                book.author.localizedCaseInsensitiveContains(searchQuery)
            }
        }
    }
}


