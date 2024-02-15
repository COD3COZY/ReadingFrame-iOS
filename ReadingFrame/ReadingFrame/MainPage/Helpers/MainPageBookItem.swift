//
//  BookView.swift
//  ReadingFrame
//
//  Created by 이윤지 on 2/14/24.
//

import SwiftUI

/// 홈 화면의 읽고 싶은 책, 다 읽은 책 리스트에 들어가는 개별 뷰
struct MainPageBookItem: View {
    var registeredBook: RegisteredBook
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 0) {
                // MARK: 책 표지
                NavigationLink {
                    // 읽고 싶은 책이라면
                    if (registeredBook.readingStatus == .wantToRead) {
                        // TODO: 책 정보 화면으로 이동
                        
                    }
                    // 다 읽은 책 이라면
                    else if (registeredBook.readingStatus == .finishRead) {
                        // TODO: 독서 노트 화면으로 이동
                    }
                } label: {
                    // 책 표지 클릭 시, 각 화면으로 이동
                    LoadableBookImage(bookCover: RegisteredBook.defaultRegisteredBook)
                        .frame(width: 173)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                }
                
                // MARK: 책 이름
                Text(registeredBook.title)
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundStyle(.black0)
                    .lineLimit(2)
                    .padding(.top, 12)
                
                // 저자 글자 개수에 따른 뷰 처리
                // 저자가 2줄 이상인 경우 bottom 정렬, 저자가 1줄인 경우 center 정렬
                HStack(alignment: registeredBook.author.count >= 14 ? .bottom : .center) {
                    // MARK: 저자
                    Text(registeredBook.author)
                        .font(.caption)
                        .lineLimit(2)
                        .foregroundStyle(.greyText)
                    
                    Spacer()
                    
                    // MARK: 더보기 버튼
                    Menu {
                        // 읽고 싶은 책이라면
                        if (registeredBook.readingStatus == .wantToRead) {
                            // MARK: 읽는 중 버튼
                            Button {
                            } label: {
                                Label("읽는 중", systemImage: "book")
                            }
                            // MARK: 다 읽음 버튼
                            Button {
                            } label: {
                                Label("다 읽음", systemImage: "book.closed")
                            }
                        }
                        // 다 읽은 책 이라면
                        else if (registeredBook.readingStatus == .finishRead){
                            // MARK: 정보 버튼
                            Button {
                            } label: {
                                Label("정보", systemImage: "info.circle")
                            }
                            // MARK: 소장 버튼
                            Button {
                            } label: {
                                Label("소장", systemImage: "square.and.arrow.down")
                            }
                            // MARK: 리뷰 남기기 버튼
                            Button {
                            } label: {
                                Label("리뷰 남기기", systemImage: "ellipsis.bubble")
                            }
                        }
                    } label: {
                        Image(systemName: "ellipsis")
                            .font(.caption)
                            .foregroundStyle(.black0)
                    }
                }
                .frame(height: registeredBook.author.count >= 14 ? 32 : 16)
                .padding(.top, 5)
            }
            .fixedSize(horizontal: false, vertical: true)
        }
        .frame(width: 173)
        .padding(.trailing, 12)
    }
}

#Preview {
    MainPageBookItem(registeredBook: RegisteredBook.defaultRegisteredBook)
}
