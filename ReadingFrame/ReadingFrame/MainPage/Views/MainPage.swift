//
//  MainPage.swift
//  ReadingFrame
//
//  Created by 석민솔 on 2/13/24.
//

import SwiftUI

/// 홈 화면
struct MainPage: View {
    
    @State private var wantToReadBooksCount = 5 /// 읽고 싶은 책 개수
    @State private var readingBooksCount = 0 /// 읽고 있는 책 개수
    @State private var finishReadBooksCount = 0 /// 다 읽은 책 개수
    
    var body: some View {
        NavigationStack {
            ScrollView() {
                VStack(alignment: .leading, spacing: 0) {
                    // 검색 바 및 전환 버튼
                    VStack(alignment: .trailing, spacing: 0) {
                        
                        // 검색바를 클릭한 경우
                        NavigationLink {
                            SearchView()
                        } label: {
                            // MARK: 검색 바
                            HStack {
                                Image(systemName: "magnifyingglass")
                                
                                Text("제목, 작가를 입력하세요")
                                
                                Spacer()
                            }
                            .padding(EdgeInsets(top: 8, leading: 7, bottom: 8, trailing: 7))
                            .foregroundStyle(.greyText)
                            .background(Color(.grey1))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                        
                        // MARK: 홈 화면, 책장 화면 전환 버튼
                        HomeSegmentedControl()
                            .frame(width: 118, height: 28)
                            .padding(.top, 15)
                    }
                    .padding(.top, 10)
                    .padding([.leading, .trailing], 16)
                    
                    // MARK: - 읽고 있는 책
                    VStack(alignment: .leading, spacing: 0) {
                        HStack {
                            Text("읽고 있는 책")
                                .font(.thirdTitle)
                                .foregroundStyle(.black0)
                            
                            Text("\(readingBooksCount)")
                                .font(.thirdTitle)
                                .foregroundStyle(.black0)
                        }
                        .padding(.top, 29)
                        .padding([.leading, .trailing], 16)
                        .padding(.bottom, 19)
                        
                        // TODO: 등록된 책 갯수에 따른 뷰 처리
                        // 등록된 책이 있다면
                        if (readingBooksCount >= 1) {
                        }
                        // 등록된 책이 없다면
                        else {
                            notRegisteredBook()
                        }
                    }
                    
                    // MARK: - 읽고 싶은 책
                    VStack(alignment: .leading, spacing: 0) {
                        HStack {
                            Text("읽고 싶은 책")
                                .font(.thirdTitle)
                                .foregroundStyle(.black0)
                            
                            Text("\(wantToReadBooksCount)")
                                .font(.thirdTitle)
                                .foregroundStyle(.black0)
                        }
                        .padding(.top, 47)
                        .padding([.leading, .trailing], 16)
                        .padding(.bottom, 19)
                        
                        // TODO: 등록된 책 갯수에 따른 뷰 처리
                        // 등록된 책이 있다면
                        if (wantToReadBooksCount >= 1) {
                            MainPageBookRow(items: [
                                RegisteredBook()
                            ])
                            .listRowInsets(EdgeInsets())
                        }
                        // 등록된 책이 없다면
                        else {
                            notRegisteredBook()
                        }
                    }
                    
                    // MARK: - 다 읽은 책
                    VStack(alignment: .leading, spacing: 0) {
                        HStack {
                            Text("다 읽은 책")
                                .font(.thirdTitle)
                                .foregroundStyle(.black0)
                            
                            Text("\(finishReadBooksCount)")
                                .font(.thirdTitle)
                                .foregroundStyle(.black0)
                        }
                        .padding(.top, 47)
                        .padding([.leading, .trailing], 16)
                        .padding(.bottom, 19)
                        
                        // TODO: 등록된 책 갯수에 따른 뷰 처리
                        // 등록된 책이 있다면
                        if (finishReadBooksCount >= 1) {
                            
                        }
                        // 등록된 책이 없다면
                        else {
                            notRegisteredBook()
                        }
                    }
                }
                Spacer()
            }
            .scrollIndicators(.hidden)
        .frame(maxWidth: .infinity)
        } // 화면 전체 스크롤 가능하도록 설정
    }
}

/// 책이 등록되지 않았을 때의 뷰
struct notRegisteredBook: View {
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Text("🧐")
                    .font(.system(size: 64))
                    .fontWeight(.medium)
                    .foregroundStyle(.black0)
                
                Text("아직 추가된 책이 없어요.\n검색하기로 원하는 책을 추가해 볼까요?")
                    .font(.subheadline)
                    .foregroundStyle(.greyText)
                    .padding(.leading, 15)
                
                Spacer()
            }
            
            HStack {
                Spacer()
                
                // 버튼 클릭 시 Search 화면으로 이동
                NavigationLink {
                    SearchView()
                } label: {
                    // MARK: 검색하기 버튼
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
        .padding([.leading, .trailing], 16)
    }
}

#Preview {
    MainPage()
}
