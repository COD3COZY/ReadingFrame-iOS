//
//  Home.swift
//  ReadingFrame
//
//  Created by 이윤지 on 2/18/24.
//

import SwiftUI

struct Home: View {
    // MARK: - Properties
    @EnvironmentObject private var coordinator: Coordinator

    /// segmented control 변수
    @State var selection: String = "book.closed"

    /// 서재 정렬 어떤 타입으로 할건지(책 종류별, 독서상태별, 장르별)
    @State var bookshelfType: BookshelfSort = .booktype


    // MARK: - View
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            ScrollView() {
                VStack(alignment: .leading, spacing: 0) {
                    // 검색 바 및 전환 버튼
                    VStack(alignment: .trailing, spacing: 0) {
                        
                        SearchBarButtonView()
                        
                        HStack {
                            // segmented control에서 책장 선택하면 책장 종류 선택하는 picker 보이도록
                            if selection == "books.vertical" {
                                // MARK: 책장 종류 picker
                                BookshelfTypePicker(bookshelfSort: $bookshelfType)
                            }
                            
                            Spacer()
                            
                            // MARK: 홈 화면, 책장 화면 전환 버튼
                            HomeSegmentedControl(selection: $selection)
                                .frame(width: 118, height: 28)
                                .padding([.top, .trailing], 16)
                                .padding(.bottom, 29)
                        }
                        
                        if (selection == "book.closed") {
                            // MARK: 홈 화면 띄우기
                            MainPage()
                        }
                        else {
                            // MARK: 책장 화면 띄우기
                            BookShelf(bookshelfSort: $bookshelfType)
                        }
                    }
                    .padding(.top, 10)
                }
                Spacer()
            }
            .scrollIndicators(.hidden)
            .frame(maxWidth: .infinity)
            .navigationDestination(for: Path.self) { path in
                destinationView(for: path)
            }
        }
        .tint(.black0) // accentcolor를 검정색으로(뒤로가기 버튼 색상 설정을 위함)
    } // 화면 전체 스크롤 가능하도록 설정

    @ViewBuilder
    private func destinationView(for path: Path) -> some View {
        switch path {
        case .bookInfo(let isbn):
            BookInfo(isbn: isbn).pushedScreen()
        case .readingNote(let isbn):
            ReadingNote(isbn: isbn).pushedScreen()
        case .bookInfoReview:
            BookInfo_Review().pushedScreen()
        case .bookRowDetail(let status):
            BookRowDetailView(readingStatus: status).pushedScreen()
        case .search:
            Search().pushedScreen()
        case .bookShelfListByType(let subtype):
            BookShelfListByType(vm: .init(bookshelfSubtype: subtype)).pushedScreen()
        case .tabReadingNote(let bookType, let totalPage, let isbn, let tab):
            TabReadingNote(
                bookType: bookType,
                totalPage: totalPage,
                isbn: isbn,
                selectedTab: tab
            )
            .pushedScreen()
        case .editReview(let review):
            EditReview(review: review)
                .navigationBarBackButtonHidden()
                .pushedScreen()
        case .characterDetail(let character, let bookInfo):
            CharacterDetail(character: character, bookInfo: bookInfo).pushedScreen()
        case .searchBadge:
            SearchBadge().pushedScreen()
        case .editProfile(let character, let nickname):
            EditProfile(character: character, nickname: nickname).pushedScreen()
        case .editProfileCharacter:
            EmptyView()
        case .settings:
            Settings().pushedScreen()
        case .support:
            Support().pushedScreen()
        }
    }
}

#Preview {
    Home()
        .environmentObject(Coordinator())
}
