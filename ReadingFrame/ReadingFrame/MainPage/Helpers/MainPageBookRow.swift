//
//  MainPageBookRow.swift
//  ReadingFrame
//
//  Created by 이윤지 on 2/14/24.
//

import SwiftUI

/// 홈 화면의 읽고 싶은 책, 다 읽은 책 리스트
struct MainPageBookRow: View {
    /// 책 리스트
    @Binding var items: [MainPageBookModel]
    
    /// 읽고 있는 책 리스트
    @Binding var readingBooksList: [MainPageBookModel]
    
    /// 다 읽은 책 리스트
    @Binding var finishReadBooksList: [MainPageBookModel]
    
    /// 독서 상태가 변경되었는지 확인하기 위한 변수
    @State var isReadingStatusChange: Bool = false
    
    /// 독서 상태
    var readingStatus: ReadingStatus
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                // 읽고 싶은 책이라면
                if (readingStatus == .wantToRead) {
                    Text("읽고 싶은 책")
                        .font(.thirdTitle)
                        .foregroundStyle(.black0)
                }
                // 다 읽은 책이라면
                else if (readingStatus == .finishRead) {
                    Text("다 읽은 책")
                        .font(.thirdTitle)
                        .foregroundStyle(.black0)
                }
                Text("\(items.count)")
                    .font(.thirdTitle)
                    .foregroundStyle(.black0)
                
                Spacer()
                
                // MARK: 각 세부 페이지 이동 버튼
                Button {
                    // 각 페이지로 이동
                    if (readingStatus == .wantToRead) {
                        // TODO: 읽고 싶은 책 상세 페이지로 이동
                    }
                    else if (readingStatus == .finishRead) {
                        // TODO: 다 읽은 책 상세 페이지로 이동
                    }
                } label: {
                    Image(systemName: "chevron.right")
                        .font(.title3)
                        .fontWeight(.medium)
                        .foregroundStyle(.black0)
                }
            }
            .padding([.leading, .trailing], 16)
            .padding(.bottom, 16)
            
            // 세로 스크롤 뷰
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    ForEach(Array(items.enumerated()), id: \.offset) { index, book in
                        if (readingStatus == items[index].book.book.readingStatus) {
                            MainPageBookItem(book: book, isReadingStatusChange: $isReadingStatusChange) // 책 뷰 띄우기
                                .tag(index)
                                .onDisappear {
                                    for index in items.indices {
                                        // 독서 상태가 바뀌었다면
                                        let item: MainPageBookModel = items[index]
                                        if (isReadingStatusChange) {
                                            // 독서 상태가 읽는 중이라면
                                            if (item.book.book.readingStatus == .reading) {
                                                readingBooksList.append(item)
                                                items.remove(at: index) // 리스트에서 값 삭제
                                            }
                                            // 독서 상태가 다 읽음이라면
                                            else if (item.book.book.readingStatus == .finishRead) {
                                                finishReadBooksList.append(item)
                                                items.remove(at: index) // 리스트에서 값 삭제
                                            }
                                            break
                                        }
                                    }
                                }
                        }
                    }
                }
                .padding(.leading, 16)
                .padding(.trailing, 4)
            }
        }
        .padding(.bottom, 55)
    }
}

#Preview {
    MainPageBookRow(items: .constant([MainPageBookModel(book: RegisteredBook(), isStatusChange: false)]),
                    readingBooksList: .constant([MainPageBookModel(book: RegisteredBook(), isStatusChange: false)]),
                    finishReadBooksList: .constant([MainPageBookModel(book: RegisteredBook(), isStatusChange: false)]),
                    readingStatus: .wantToRead)
}
