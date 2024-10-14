//
//  MainPage.swift
//  ReadingFrame
//
//  Created by 석민솔 on 2/13/24.
//

import SwiftUI

/// 홈 화면
struct MainPage: View {
    /// 홈 화면 뷰모델
    @StateObject var viewModel: MainPageViewModel
    
    var body: some View {
        // MARK: - 읽고 있는 책
        VStack(alignment: .leading, spacing: 0) {
            // 등록된 책이 있다면
            if (viewModel.readingBooksCount >= 1) {
                ReadingRowView(viewModel: viewModel)
            }
            // 등록된 책이 없다면
            else {
                HStack(spacing: 5) {
                    Text("읽고 있는 책")
                        .font(.thirdTitle)
                        .foregroundStyle(.black0)
                    Text("0")
                        .font(.thirdTitle)
                        .fontDesign(.rounded)
                        .foregroundStyle(.black0)
                }
                .padding([.leading, .bottom], 16)
                
                notRegisteredBook()
            }
        }
        
        // MARK: - 읽고 싶은 책
        VStack(alignment: .leading, spacing: 0) {
            // 등록된 책이 있다면
            if (viewModel.wantToReadBooksCount >= 1) {
                WantToReadRowView(wantToReadBooksList: viewModel.wantToReadBooksList)
            }
            // 등록된 책이 없다면
            else {
                HStack(spacing: 5) {
                    Text("읽고 싶은 책")
                        .font(.thirdTitle)
                        .foregroundStyle(.black0)
                    Text("0")
                        .font(.thirdTitle)
                        .fontDesign(.rounded)
                        .foregroundStyle(.black0)
                }
                .padding([.leading, .bottom], 16)
                
                notRegisteredBook()
            }
        }
        
        // MARK: - 다 읽은 책
        VStack(alignment: .leading, spacing: 0) {
            // 등록된 책이 있다면
            if (viewModel.finishReadBooksCount >= 1) {
                FinishReadRowView(finishReadBooksList: viewModel.finishReadBooksList)
            }
            // 등록된 책이 없다면
            else {
                HStack(spacing: 5) {
                    Text("다 읽은 책")
                        .font(.thirdTitle)
                        .foregroundStyle(.black0)
                    Text("0")
                        .font(.thirdTitle)
                        .fontDesign(.rounded)
                        .foregroundStyle(.black0)
                }
                .padding([.leading, .bottom], 16)
                
                notRegisteredBook()
            }
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
                        .toolbar(.hidden, for: .tabBar) // toolbar 숨기기
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
    MainPage(viewModel: MainPageViewModel())
}
