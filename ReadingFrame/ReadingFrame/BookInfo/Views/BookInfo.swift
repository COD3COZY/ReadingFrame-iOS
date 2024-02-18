//
//  BookInfo.swift
//  ReadingFrame
//
//  Created by 석민솔 on 2/16/24.
//

import SwiftUI

/// 도서정보와 리뷰 간략하게 조회하는 페이지.
struct BookInfo: View {
    @State private var book: InitialBook = InitialBook()
    
    var body: some View {
        ZStack {
            ScrollView {
                // TODO: 책 기본정보
                Text("Hello world!")
                Button(action: {
                    RegisterBook(book: $book)
                }, label: {
                    Text("책등록모달 띄워주기")
                })
                
                // TODO: 책설명
                
                
                // TODO: 키워드 리뷰
                
                
                // TODO: 한줄평 리뷰
                
                
            }
            // TODO: 고정위치 버튼 뷰
            
        }
        // MARK: 네비게이션 바 설정
        .navigationTitle("도서 정보")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Preview: 네비게이션 바까지 확인 시 필요
struct BookInfoNavigate_Preview: PreviewProvider {
    static var previews: some View {
        // 네비게이션 바 연결해주기 위해 NavigationStack 사용
        NavigationStack {
            NavigationLink("도서 정보 보기") {
                BookInfo()
                    .toolbarRole(.editor)   // 이전 버튼 뒤에 화면 이름 표기 없음
            }
            .navigationTitle("Home")
        }
        // 이전 버튼(<) 색 검은색으로
        .tint(.black0)
    }
}

struct BookInfo_Preview: PreviewProvider {
    static var previews: some View {
        BookInfo()
    }
}

