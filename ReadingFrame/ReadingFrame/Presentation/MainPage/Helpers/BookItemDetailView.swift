//
//  ReadingItemDetailView.swift
//  ReadingFrame
//
//  Created by 이윤지 on 3/17/24.
//

import SwiftUI

// TODO: 책 정보랑 액션을 위한 클로저 전달하는 방식으로 수정하기
/// 모든 책 상세 페이지의 리스트에 들어갈 아이템 뷰
struct BookItemDetailView: View {
    // MARK: - Property
    /// 받아오는 책정보
    let book: any DetailBookModel
    
    // 읽고 있는 책 관련 변수
    /// 다 읽음 Popup 띄움 여부 확인
    @State private var isShowFinishReadAlert = false
    
    /// 홈 화면에서 숨기기 Popup 띄움 여부 확인
    @State private var isShowHideBookAlert = false
    
    /// 소장 Popup 띄움 여부 확인
    @State private var isShowMineTrueAlert = false
    
    /// 미소장 Popup 띄움 여부 확인
    @State private var isShowMineFalseAlert = false
    
    // 읽고 싶은 책 관련 변수
    /// sheet가 띄워져 있는지 확인하는 변수
    @State var isRegisterSheetAppear: Bool = false
    
    /// sheet를 띄우기 위한 기본 값
    @State var sheetReadingStatus: ReadingStatus = .reading
    
    // MARK: - Actions
    // 독서 상태 변경 API 호출
    var changeReadingStatus: () -> Void = {
//        viewModel.changeReadingStatus(
//            isbn: viewModel.readingBooks[index].isbn,
//            request: ChangeReadingStatusRequest(
//                readingStatus: ReadingStatus.finishRead.rawValue,
//                uuid: UUID().uuidString
//            )
//        ) { success in
//            if success {
//                viewModel.readingBooks[index].readingStatus = .finishRead
//            }
//        }
    }
    
    // 소장 여부 변경 API 호출
    var toggleIsMine: () -> Void = {
//        if readingStatus == .reading {
//            if let index = viewModel.readingBooks.firstIndex(where: { $0.isbn == bookIsbn }) {
//                viewModel.changeIsMine(isbn: viewModel.readingBooks[index].isbn, request: ChangeIsMineRequest(isMine: true)) { success in
//                    if success {
//                        viewModel.readingBooks[index].isMine = true
//                    }
//                }
//            }
//        }
//        else {
//            viewModel.changeIsMine(isbn: viewModel.finishReadBooks[bookIndex].isbn, request: ChangeIsMineRequest(isMine: true)) { success in
//                if success {
//                    viewModel.finishReadBooks[bookIndex].isMine = true
//                }
//            }
//        }
    }
    
    // 읽고 있는 책 숨기기 & 꺼내기 API 호출
    var toggleHiddenReadingBook: (Int) -> Void = { _ in
//        viewModel.hiddenReadBook(
//            isbn: viewModel.books[index].isbn,
//            request: HiddenReadBookRequest(isHidden: true)
//        ) { success in
//            viewModel.books[index].isHidden = true
//        }
    }
    
    // MARK: - View
    var body: some View {
        // 기본 리스트 네비게이션 링크는 자동으로 chevron 추가됨 이슈로 ZStack으로 감싸서 구현
        ZStack(alignment: .topTrailing) {
            VStack(spacing: 0) {
                BookItemDetailContentView(book: book)
                    .padding(.vertical, 16)
                
                Rectangle()
                    .foregroundStyle(.grey2)
                    .frame(height: 1)
            }
            
            NavigationLink {
                if book.readingStatus == .wantToRead {
                        // BookInfo로 연결
                        BookInfo(isbn: book.isbn)
                            .toolbarRole(.editor) // back 텍스트 표시X
                            .toolbar(.hidden, for: .tabBar) // toolbar 숨기기
                    } else {
                        // ReadingNote로 연결
                        ReadingNote(isbn: book.isbn)
                            .toolbarRole(.editor) // back 텍스트 표시X
                            .toolbar(.hidden, for: .tabBar) // toolbar 숨기기
                    }
            } label: {
                EmptyView()
            }
            .opacity(0)
            
            // Menu
            // TODO: 여기에 엄청 클로저 많이 들어갈 예정
            BookItemDetailMenuView(readingStatus: book.readingStatus)

        }
    }
}

#Preview {
    BookItemDetailView(
        book: WantToReadBookModel(
        isbn: "",
        cover: "",
        title: "제목",
        author: "저자",
        category: .art)
    )
}
