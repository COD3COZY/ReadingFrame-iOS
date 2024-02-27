//
//  MainPageReadingBookItem.swift
//  ReadingFrame
//
//  Created by 이윤지 on 2/21/24.
//

import SwiftUI

/// 홈 화면의 읽고 있는 책 리스트에 들어가는 개별 뷰
struct MainPageReadingBookItem: View {
    /// 읽고 싶은 책 객체
    @Bindable var book: RegisteredBook
    
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            // MARK: 책 표지
            NavigationLink {
                // 책 정보 화면으로 이동
                BookInfo()
                    .toolbarRole(.editor) // back 텍스트 표시X
            } label: {
                LoadableBookImage(bookCover: book.book.cover)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .frame(width: 144, height: 220)
                    .shadow(color: Color(white: 0, opacity: 0.2), radius: 18, x: 2, y: 2)
            }
            
            // MARK: 책 이름
            Text("\(book.book.title)")
                .font(.headline)
                .foregroundStyle(.black0)
                .padding(.top, 20)
            
            // MARK: 저자
            Text("\(book.book.author)")
                .font(.footnote)
                .foregroundStyle(.greyText)
                .padding(.top, 2)
            
            // MARK: 막대 그래프 및 퍼센트
            ReadingPercentBar(book: book, width: 300)
            
            HStack(spacing: 10) {
                // MARK: 책갈피 버튼
                ReadingLabel(label: "책갈피", image: "bookmark")
                // TODO: 책갈피 추가 sheet 띄우기
                
                // MARK: 독서노트 버튼
                NavigationLink {
                    // TODO: 독서노트 화면으로 이동
                    ReadingNote()
                        .toolbarRole(.editor) // back 텍스트 표시X
                    
                } label: {
                    ReadingLabel(label: "독서노트", image: "magazine")
                }
                
                // MARK: - Menu
                Menu {
                    // MARK: 다 읽음 버튼
                    Button {
                        
                    } label: {
                        Label("다 읽음", systemImage: "book.closed")
                    }
                    // MARK: 정보 버튼
                    Button {
                        
                    } label: {
                        Label("정보", systemImage: "info.circle")
                    }
                    // MARK: 리뷰 남기기 버튼
                    Button {
                        
                    } label: {
                        Label("리뷰 남기기 버튼", systemImage: "bubble")
                    }
                    // MARK: 소장 버튼
                    Button {
                        
                    } label: {
                        Label("소장", systemImage: "square.and.arrow.down")
                    }
                    // MARK: 홈 화면에서 숨기기 버튼
                    Button {
                        
                    } label: {
                        Label("홈 화면에서 숨기기", systemImage: "eye.slash")
                    }
                } label: {
                    Image(systemName: "ellipsis")
                        .font(.body)
                        .foregroundStyle(.black0)
                }
            }
            .padding(.top, 15)
        }
        .padding(.top, 18)
    }
}

#Preview {
    MainPageReadingBookItem(book: RegisteredBook())
}
