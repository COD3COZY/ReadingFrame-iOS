//
//  SearchView.swift
//  ReadingFrame
//
//  Created by 이윤지 on 2/13/24.
//

import SwiftUI

/// 검색 창 화면
struct Search: View {
    /// 사용자가 입력한 검색어
    @State private var searchText: String = ""
    
    /// 뷰모델
    @StateObject private var viewModel = SearchViewModel()
    
    /// 검색 API 호출 결과
    @State private var isSuccess: Bool = false
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                // 검색 입력 필드
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundStyle(.greyText)
                    
                    TextField("제목, 작가를 입력하세요", text: $searchText) {
                        viewModel.searchBooks(searchText: searchText) { success in
                            if success {
                                isSuccess = true
                            }
                            else {
                                isSuccess = false
                            }
                        }
                    }
                    // 검색어 변경 시 값 초기화
                    .onChange(of: searchText) { old, new in
                        isSuccess = false
                        viewModel.searchBooks = []
                        viewModel.bookCount = -1
                    }
                }
                .padding(EdgeInsets(top: 8, leading: 7, bottom: 8, trailing: 7))
                .background(Color(.grey1))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.horizontal, 16)
                
                // 로딩 중
                if viewModel.isLoading {
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                }
                // 결과 출력
                else {
                    // 입력한 검색어가 없다면
                    if searchText.isEmpty {
                        GreyLogoAndTextView(text: "찾고 있는 책을 검색해 보세요.")
                    }
                    // API 호출에 성공했다면
                    else if isSuccess {
                        // 결과가 없다면
                        if viewModel.bookCount == 0 {
                            GreyLogoAndTextView(text: "검색 결과가 없어요.")
                        }
                        // 결과가 있다면
                        else {
                            searchResultList
                        }
                    }
                }
            }
        }
        .padding(.top, 8)
        .frame(maxWidth: .infinity) // 화면 전체 스크롤 가능하도록 설정
        .navigationTitle("검색하기")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - View Components
extension Search {
    /// 검색 결과 책들 리스트로 나타내기
    private var searchResultList: some View {
        ScrollView() {
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    Text("도서 검색")
                        .font(.thirdTitle)
                        .foregroundStyle(.black0)
                        .padding(.leading, 4)
                    
                    Spacer()
                    
                    HStack(spacing: 1) {
                        Text("\(viewModel.bookCount)")
                            .fontDesign(.rounded)
                        Text("건")
                    }
                    .font(.headline)
                    .fontWeight(.regular)
                    .foregroundStyle(.greyText)
                }
                
                ForEach(Array(viewModel.searchBooks.enumerated()), id: \.offset) { index, book in
                    navigationToEachBookInfo(book)
                }
                .padding(.top, 20)
            }
            .padding(.top, 30)
            .padding(.horizontal, 16)
        }
    }
    
    /// 책정보 페이지로 넘어가는 네비게이션링크
    private func navigationToEachBookInfo(_ book: SearchBookResponse) -> some View {
        NavigationLink {
            BookInfo(isbn: book.isbn)
                .toolbarRole(.editor)
        } label: {
            VStack(spacing: 0) {
                SearchBookView(book: book, searchText: $searchText)
                    .padding(.vertical, 15)
                
                Rectangle()
                    .frame(height: 1)
                    .foregroundStyle(.grey1)
            }
        }

    }
}

#Preview {
    Search()
}
