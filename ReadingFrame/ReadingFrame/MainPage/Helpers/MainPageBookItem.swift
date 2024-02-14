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
                // 책 표지
                LoadableBookImage(bookCover: RegisteredBook.defaultRegisteredBook)
                    .frame(width: 173)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                
                // 책 이름
                Text(registeredBook.title)
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundStyle(.black0)
                    .lineLimit(2)
                    .padding(.top, 12)
                
                // 저자 글자 개수에 따른 뷰 처리
                // 저자가 2줄 이상인 경우
                if (registeredBook.author.count >= 14) {
                    HStack(alignment: .bottom) {
                        // 저자
                        Text(registeredBook.author)
                            .font(.caption)
                            .lineLimit(2)
                            .foregroundStyle(.greyText)
                        
                        Spacer()
                        
                        // 더보기 버튼
                        Image(systemName: "ellipsis")
                            .font(.caption)
                            .foregroundStyle(.black0)
                            .onTapGesture {
                                // TODO: Context Menu 띄우기
                            }
                    }
                    .frame(height: 32)
                    .padding(.top, 5)
                }
                // 저자가 1줄인 경우
                else {
                    HStack(alignment: .center) {
                        // 저자
                        Text(registeredBook.author)
                            .font(.caption)
                            .lineLimit(2)
                            .foregroundStyle(.greyText)
                        
                        Spacer()
                        
                        // 더보기 버튼
                        Image(systemName: "ellipsis")
                            .font(.caption)
                            .foregroundStyle(.black0)
                    }
                    .frame(height: 16)
                    .padding(.top, 5)
                }
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
