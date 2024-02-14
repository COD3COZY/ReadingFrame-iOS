//
//  MainPage.swift
//  ReadingFrame
//
//  Created by 석민솔 on 2/13/24.
//

import SwiftUI

/// 홈 화면
struct MainPage: View {
    @State private var wantToReadBooksCount = 0 /// 읽고 싶은 책 갯수
    @State private var readingBooksCount = 0 /// 읽고 있는 책 갯수
    @State private var finishReadBooksCount = 0 /// 다 읽은 책 갯수
    
    @State private var searchText = "" /// 사용자가 입력한 검색어
    
    var body: some View {
        ScrollView() {
            VStack(alignment: .leading) {
                VStack(alignment: .trailing) {
                    
                    // FIXME: 전환 속도가 너무 느림, 텍스트 중앙 정렬되는 이유 찾기
                    // 검색바를 클릭한 경우
                    NavigationLink {
                        SearchView()
                    } label: {
                        SearchBar(searchText: $searchText)
                    }
                    
                    // 홈 화면, 책장 화면 전환 버튼
                    HomeSegmentedControl()
                        .frame(width: 118, height: 28)
                        .padding(.top, 15)
                }
                .padding(.top, 10)
                
                // 읽고 있는 책
                HStack {
                    Text("읽고 있는 책")
                        .font(.thirdTitle)
                        .foregroundStyle(.black0)
                    
                    Text("\(readingBooksCount)")
                        .font(.thirdTitle)
                        .foregroundStyle(.black0)
                }
                
                // 등록된 책 갯수에 따른 뷰 처리
                // 등록된 책이 있다면
                if (readingBooksCount >= 1) {
                    
                }
                // 등록된 책이 없다면
                else {
                    notRegisteredBook()
                }
                
                // 읽고 싶은 책
                HStack {
                    Text("읽고 싶은 책")
                        .font(.thirdTitle)
                        .foregroundStyle(.black0)
                    
                    Text("\(wantToReadBooksCount)")
                        .font(.thirdTitle)
                        .foregroundStyle(.black0)
                }
                .padding(.top, 47)
                
                // 등록된 책 갯수에 따른 뷰 처리
                // 등록된 책이 있다면
                if (wantToReadBooksCount >= 1) {
                    
                }
                // 등록된 책이 없다면
                else {
                    notRegisteredBook()
                }
                
                // 다 읽은 책
                HStack {
                    Text("다 읽은 책")
                        .font(.thirdTitle)
                        .foregroundStyle(.black0)
                    
                    Text("\(finishReadBooksCount)")
                        .font(.thirdTitle)
                        .foregroundStyle(.black0)
                }
                .padding(.top, 47)
                
                // 등록된 책 갯수에 따른 뷰 처리
                // 등록된 책이 있다면
                if (finishReadBooksCount >= 1) {
                    
                }
                // 등록된 책이 없다면
                else {
                    notRegisteredBook()
                }
                
            }
            .padding([.leading, .trailing], 16)
            
            Spacer()
        }
        // 화면 전체 스크롤 가능하도록 설정
        .frame(maxWidth: .infinity)
    }
}

/// 책이 등록되지 않았을 때의 뷰
struct notRegisteredBook: View {
    var body: some View {
        HStack {
            Text("🧐")
                .font(.system(size: 64))
                .fontWeight(.medium)
                .foregroundStyle(.black0)
            
            Text("아직 추가된 책이 없어요.\n검색하기로 원하는 책을 추가해 볼까요?")
                .font(.subheadline)
                .foregroundStyle(.greyText)
        }
        .padding(.top, 12)
        
        HStack {
            Spacer()
            
            // TODO: 버튼 클릭 시 Search 화면으로 이동
            NavigationLink {
                SearchView()
            } label: {
                // 검색하기 버튼
                HStack {
                    Text("검색하기")
                        .font(.subheadline)
                        .foregroundStyle(.black0)
                    
                    Image(systemName: "chevron.right")
                        .font(.system(size: 14).weight(.medium))
                        .foregroundStyle(.black0)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        MainPage()
    }
}
