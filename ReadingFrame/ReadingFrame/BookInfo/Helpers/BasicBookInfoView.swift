//
//  BasicBookInfoView.swift
//  ReadingFrame
//
//  Created by 석민솔 on 2/20/24.
//

import SwiftUI

/// 도서정보 상단 기초정보 보여주는 뷰
struct BasicBookInfoView: View {
    
    /// 책정보 보여주기 위한 Book 인스턴스
    var book: Book
    
    /// 한줄평 개수
    let commentCount: Int
    
    
    /// 버튼에 들어갈 날짜 text
    var dateString: String {
        // DateFormatter 형식 지정
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        
        // Date -> String
        let dateString = dateFormatter.string(from: book.publicationDate)
        
        return dateString
    }

    
    var body: some View {
        HStack(spacing: 20) {
            // MARK: 커버 이미지
            LoadableBookImage(bookCover: book.cover)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                // 크기 적용
                .frame(maxWidth: 170, maxHeight: 260)
                // 그림자
                .shadow(color: Color(red: 0.47, green: 0.47, blue: 0.47).opacity(0.3), radius: 7.5, x: 0, y: 0)
            
            // MARK: 오른쪽 책정보
            VStack(alignment: .leading) {
                // 책정보 배지
                Badge_Info(category: book.categoryName)
                
                // 제목
                Text(book.title)
                    .font(.thirdTitle)
                
                // 저자
                Text(book.author)
                    .font(.footnote)
                
                // 리뷰 개수(한줄평 페이지 연결)
                NavigationLink {
                    // 한줄평 페이지로 연결
                    BookInfo_Review()
                        .toolbarRole(.editor)   // 이전 버튼 뒤에 화면 이름 표기 없음
                } label: {
                    HStack(alignment: .center, spacing: 5) {
                        Image(systemName: "bubble")
                            .resizable()
                            .scaledToFit()
                            .fontWeight(.medium)
                            .foregroundStyle(Color.black)
                            .frame(width: 20)
                        
                        Text(String(commentCount))
                            .font(.caption)
                            .foregroundStyle(Color.black)
                        
                        Image(systemName: "chevron.right")
                            .font(.caption)
                            .fontWeight(.medium)
                            .foregroundStyle(Color.black0)
                            .padding(.leading, -2)
                    }
                    .padding(.vertical, 5)
                }
                
                Spacer()
                
                // 출판사
                simpleInfo(key: "출판사", value: book.publisher)
                
                // 발행일
                simpleInfo(key: "발행일", value: dateString)

                // 페이지
                simpleInfo(key: "페이지", value: String(book.totalPage))

            }
            .padding(.vertical)
        }
        .frame(maxHeight: 260)
    }
    
    
    /// 바 하나 중간에 두고 간단한 정보 있는 뷰
    struct simpleInfo: View {
        var key: String
        var value: String
        
        var body: some View {
            HStack(alignment: .center , spacing: 5) {
                Text(key)
                
                Rectangle()
                    .frame(width: 1, height: 10)
                    .foregroundStyle(Color.black0)
                
                Text(value)
            }
            .font(.caption)
        }
    }
}


#Preview {
    BasicBookInfoView(book: InitialBook(), commentCount: 0)
}
