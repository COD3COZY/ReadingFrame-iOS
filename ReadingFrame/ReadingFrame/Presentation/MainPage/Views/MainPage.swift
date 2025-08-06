//
//  MainPage.swift
//  ReadingFrame
//
//  Created by 석민솔 on 2/13/24.
//

import SwiftUI

/// 홈 화면
struct MainPage: View {
    // MARK: - Properties
    /// 홈 화면 뷰모델
    @StateObject var viewModel = MainPageViewModel()
    
    // 읽고 있는 책 관련변수
    /// 현재 보이는 페이지 index
    @State var selectedPageIndex: Int = 0
    
    // 읽고 싶은 책 관련변수
    // 다 읽은 책 관련변수
    
    // MARK: - View
    var body: some View {
        // MARK: - 읽고 있는 책
        VStack(alignment: .leading, spacing: 0) {
            // 등록된 책이 있다면
            if (viewModel.readingBooksCount >= 1) {
                readingBooksSection
            }
            // 등록된 책이 없다면
            else {
                notRegisteredBook(readingStatus: .reading)
            }
        }
        
        // MARK: - 읽고 싶은 책
        VStack(alignment: .leading, spacing: 0) {
            // 등록된 책이 있다면
            if (viewModel.wantToReadBooksCount >= 1) {
                WantToReadRowView(viewModel: viewModel)
            }
            // 등록된 책이 없다면
            else {
                notRegisteredBook(readingStatus: .wantToRead)
            }
        }
        
        // MARK: - 다 읽은 책
        VStack(alignment: .leading, spacing: 0) {
            // 등록된 책이 있다면
            if (viewModel.finishReadBooksCount >= 1) {
                FinishReadRowView(viewModel: viewModel)
            }
            // 등록된 책이 없다면
            else {
                notRegisteredBook(readingStatus: .finishRead)
            }
        }
    }
}

extension MainPage {
    // MARK: - Reading Books Section
    private var readingBooksSection: some View {
        VStack {
            sectionHeader(
                title: "읽고 있는 책",
                count: viewModel.readingBooksCount,
                destination: BookRowDetailView(readingStatus: .reading)
            )
            
            readingBooksContent
        }
    }
    
    /// 읽는 중인 책에 나와있는거
    private var readingBooksContent: some View {
        // ReadingRowView의 TabView 부분만 추출
        ZStack(alignment: .top) {
            // 읽는중인 책 컨텐츠
            TabView(selection: $selectedPageIndex) {
                ForEach(Array(viewModel.notHiddenReadingBooksList().prefix(10).enumerated()), id: \.offset) { index, book in
                    ReadingItemView(
                        viewModel: self.viewModel,
                        bookIndex: index
                    )
                    .tag(index)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never)) // indicator를 page 단위로 설정
            .indexViewStyle(.page(backgroundDisplayMode: .never)) // 기존 indicator 숨기기
            
            // 페이징
            PageIndicator(numberOfPages: min(10, viewModel.notHiddenReadingBooksList().count), currentPage: $selectedPageIndex)
        }
        .padding(.bottom, 55)
        .frame(height: 480)
    }
    
    // wantToReadBooksSection
    
    // finishReadBooksSection
    
    // MARK: - Common Components
    private func sectionHeader(title: String, count: Int, destination: some View) -> some View {
        HStack {
            HStack(spacing: 5) {
                Text(title)
                Text("\(count)")
                    .fontDesign(.rounded)
            }
            .font(.thirdTitle)
            .foregroundStyle(.black0)
            
            Spacer()
            
            NavigationLink {
                destination
                    .toolbarRole(.editor)
                    .toolbar(.hidden, for: .tabBar)
            } label: {
                Image(systemName: "chevron.right")
                    .font(.title3)
                    .fontWeight(.medium)
                    .foregroundStyle(.black0)
            }
        }
        .padding([.leading, .trailing], 16)
        .padding(.bottom, 16)
    }
    
    /// 책이 등록되지 않았을 때의 뷰
    private func notRegisteredBook(readingStatus: ReadingStatus) -> some View {
        VStack(spacing: 0) {
            let sectionName: String = {
                switch readingStatus {
                case .wantToRead:
                    "읽고 싶은 책"
                case .reading:
                    "읽고 있는 책"
                case .finishRead:
                    "다 읽은 책"
                default:
                    "어라?"
                }
            }()
            
            HStack(spacing: 5) {
                Text(sectionName)
                Text("0")
                    .fontDesign(.rounded)
                
                Spacer()
            }
            .font(.thirdTitle)
            .foregroundStyle(.black0)
            .padding([.leading, .bottom], 16)
            
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
                
                // MARK: 검색하기 버튼
                NavigationLink {
                    Search()
                        .toolbarRole(.editor) // back 텍스트 표시X
                        .toolbar(.hidden, for: .tabBar) // toolbar 숨기기
                } label: {
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
    MainPage(viewModel: MainPageViewModel())
}
