//
//  MainPage.swift
//  ReadingFrame
//
//  Created by 석민솔 on 2/13/24.
//

import SwiftUI

/// 홈 화면
struct MainPage: View {
    /// 읽고 있는 책 리스트
    @State private var readingBooksList: [RegisteredBook] = []
    
    /// 읽고 싶은 책 리스트
    @State private var wantToReadBooksList: [RegisteredBook] = []
    
    /// 다 읽은 책 리스트
    @State private var finishReadBooksList: [RegisteredBook] = []
    
    var body: some View {
        // MARK: - 읽고 있는 책
        VStack(alignment: .leading, spacing: 0) {
            // TODO: 등록된 책 갯수에 따른 뷰 처리
            // 등록된 책이 있다면
            if (readingBooksList.count >= 1) {
                MainPageReadingBookRow(items: readingBooksList)
            }
            // 등록된 책이 없다면
            else {
                Text("읽고 있는 책 0")
                    .font(.thirdTitle)
                    .foregroundStyle(.black0)
                    .padding([.leading, .bottom], 16)
                
                notRegisteredBook()
            }
        }
        .onAppear {
            // 임시 데이터 넣기
            let tempReadingBooksList: [RegisteredBook] = [
                RegisteredBook(book: InitialBook(readingStatus: .reading)),
                RegisteredBook(book: InitialBook(readingStatus: .reading)),
                RegisteredBook(book: InitialBook(readingStatus: .reading)),
                RegisteredBook(book: InitialBook(readingStatus: .reading)),
                RegisteredBook(book: InitialBook(readingStatus: .reading)),
            ]
            readingBooksList.append(contentsOf: tempReadingBooksList)
        }
        
        // MARK: - 읽고 싶은 책
        VStack(alignment: .leading, spacing: 0) {            
            // TODO: 등록된 책 갯수에 따른 뷰 처리
            // 등록된 책이 있다면
            if (wantToReadBooksList.count >= 1) {
                MainPageBookRow(items: wantToReadBooksList, readingStatus: .wantToRead)
            }
            // 등록된 책이 없다면
            else {
                Text("읽고 싶은 책 0")
                    .font(.thirdTitle)
                    .foregroundStyle(.black0)
                    .padding([.leading, .bottom], 16)
                
                notRegisteredBook()
            }
        }
        .onAppear {
            // 임시 데이터 넣기
            let tempWantToList: [RegisteredBook] = [
                RegisteredBook(book: InitialBook(readingStatus: .wantToRead)),
                RegisteredBook(book: InitialBook(readingStatus: .wantToRead)),
                RegisteredBook(book: InitialBook(readingStatus: .wantToRead)),
                RegisteredBook(book: InitialBook(readingStatus: .wantToRead)),
            ]
            wantToReadBooksList.append(contentsOf: tempWantToList)
        }
        
        // MARK: - 다 읽은 책
        VStack(alignment: .leading, spacing: 0) {
            // TODO: 등록된 책 갯수에 따른 뷰 처리
            // 등록된 책이 있다면
            if (finishReadBooksList.count >= 1) {
                MainPageBookRow(items: finishReadBooksList, readingStatus: .finishRead)
                    .listRowInsets(EdgeInsets())
            }
            // 등록된 책이 없다면
            else {
                Text("다 읽은 책 0")
                    .font(.thirdTitle)
                    .foregroundStyle(.black0)
                    .padding([.leading, .bottom], 16)
                
                notRegisteredBook()
            }
        }
        .onAppear {
            // 임시 데이터 넣기
            let tempFinishReadList: [RegisteredBook] = [
                RegisteredBook(book: InitialBook(readingStatus: .finishRead)),
                RegisteredBook(book: InitialBook(readingStatus: .finishRead)),
                RegisteredBook(book: InitialBook(readingStatus: .finishRead)),
                RegisteredBook(book: InitialBook(readingStatus: .finishRead)),
                RegisteredBook(book: InitialBook(readingStatus: .finishRead)),
            ]
            finishReadBooksList.append(contentsOf: tempFinishReadList)
        }
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
                        .toolbarRole(.editor) // back 텍스트 표시X
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
        .padding(.bottom, 55)
    }
}

#Preview {
    MainPage()
}
