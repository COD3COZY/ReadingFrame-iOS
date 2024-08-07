//
//  BookShelf.swift
//  ReadingFrame
//
//  Created by 석민솔 on 7/24/24.
//

import SwiftUI

struct BookShelf: View {
    // MARK: - Properties
    /// 서재 정렬 어떤 타입으로 할건지(책 종류별, 독서상태별, 장르별)
    @State var bookshelfType: BookshelfType = .booktype
    
    /// 서재 타입
    let bookshelfTypes: [BookshelfType] = [.booktype, .readingStatus, .genre]
    
    // 책장 이름
    var bookshelfNames: [String] {
        switch bookshelfType {
        case .booktype:
            ["종이책", "전자책", "오디오북"]
        case .readingStatus:
            ["읽고싶은", "읽는 중", "다 읽음"]
        case .genre:
            ["인문사회", "문학", "에세이", "과학", "자기계발", "예술", "원서", "기타"]
        }
    }
    
    let countByShelf: [Int] = [0, 2, 37, 23, 4, 15, 36, 25]
    
    
    // MARK: - View
    var body: some View {
        ScrollView {
            shelfTypePicker
            
            ForEach(bookshelfNames.indices, id: \.self) { index in
                
                VStack {
                    HStack {
                        // 책장이름
                        Text(bookshelfNames[index])
                        
                        // TODO: 해당 책 개수
                        Text(String(countByShelf[index]))
                            .fontDesign(.rounded)
                            .fontWeight(.bold)
                        
                        Spacer()
                        
                        // TODO: 버튼-화면연결 chevron
                        NavigationLink {
                            BookShelfListByType()
                        } label: {
                            Image(systemName: "chevron.right")
                                .foregroundStyle(Color.black0)
                                .fontWeight(.semibold)

                        }
                    }
                    .padding()
                    
                    BookShelfView(categoryCount: countByShelf[index])
                }
                .padding(.bottom, 25)
                
            }
        }
    }
}

#Preview {
    BookShelf()
}

extension BookShelf {
    // MARK: - View parts
    private var shelfTypePicker: some View {
        Picker("서재 보기", selection: $bookshelfType) {
            ForEach(bookshelfTypes, id: \.self) { shelfType in
                Text(getBookshelfTypeName(shelfType))
            }
        }
        .pickerStyle(.menu)
        .padding()
        .tint(Color.black0)
    }
    
    private var shelfNameBar: some View {
        HStack {
            // TODO: 책장이름
            Text("종이책")
            
            // TODO: 해당 책 개수
            Text(String(4))
            
            Spacer()
            
            // TODO: 버튼-화면연결 chevron
            NavigationLink {
                BookShelfListByType()
            } label: {
                Image(systemName: "chevron.right")
            }

        }
    }
    
    private var singleBookshelf: some View {
        VStack {
            ForEach(Array(bookshelfNames.enumerated()), id: \.element) { index, name in
                
//                HStack {
//                    // TODO: 책장이름
//                    Text(name)
//                    
//                    // TODO: 해당 책 개수
//                    Text(String(Int.random(in: 1...10)))
//                    
//                    Spacer()
//                    
//                    // TODO: 버튼-화면연결 chevron
//                    NavigationLink {
//                        BookShelfListByType()
//                    } label: {
//                        Image(systemName: "chevron.right")
//                    }
//                    
//                }
                
//                BookShelfView(categoryCount: 15)
            }
        }
    }
    
    // MARK: - Functions
    func getBookshelfTypeName(_ shelftype: BookshelfType) -> String {
        switch shelftype {
        case .booktype:
            return "책 유형별"
        case .readingStatus:
            return "독서상태별"
        case .genre:
            return "장르별"
        }
    }
}
