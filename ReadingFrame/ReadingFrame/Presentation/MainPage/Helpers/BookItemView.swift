//
//  BookView.swift
//  ReadingFrame
//
//  Created by 이윤지 on 2/14/24.
//

import SwiftUI

/// 홈 화면의 읽고 싶은 책, 다 읽은 책 리스트에 들어가는 개별 뷰
struct BookItemView: View {
    /// 홈 화면 뷰모델
    @ObservedObject var viewModel: MainPageViewModel
    
    /// 책 아이템 인덱스 값
    var bookIndex: Int
    
    /// 책 유형
    var bookReadingStatus: ReadingStatus
    
    /// sheet를 띄우기 위한 기본 값
    @State var sheetReadingStatus: ReadingStatus = .reading
    
    /// sheet가 띄워져 있는지 확인하는 변수
    @State var isRegisterSheetAppear: Bool = false
    
    /// 소장 Alert이 띄워졌는지 확인하기 위한 변수(소장O)
    @State private var isShowMineTrueAlert = false
    
    /// 소장 Alert이 띄워졌는지 확인하기 위한 변수(소장X)
    @State private var isShowMineFalseAlert = false
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 0) {
                // MARK: 책 표지
                NavigationLink {
                    // 읽고 싶은 책이라면
                    if (bookReadingStatus == .wantToRead) {
                        // 책 정보 화면으로 이동
                        BookInfo(isbn: matchReadingStatus(readingStatus: bookReadingStatus)?.isbn ?? "")
                            .toolbarRole(.editor) // back 텍스트 표시X
                            .toolbar(.hidden, for: .tabBar) // toolbar 숨기기
                    }
                    // 다 읽은 책 이라면
                    else if (bookReadingStatus == .finishRead) {
                        // 독서 노트 화면으로 이동
                        ReadingNote(isbn: matchReadingStatus(readingStatus: bookReadingStatus)?.isbn ?? "")
                            .toolbarRole(.editor) // back 텍스트 표시X
                    }
                } label: {
                    LoadableBookImage(bookCover: matchReadingStatus(readingStatus: bookReadingStatus)?.cover ?? "")
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .frame(width: 173, height: 260)
                }
                
                // MARK: 책 이름
                Text(matchReadingStatus(readingStatus: bookReadingStatus)?.title ?? "")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundStyle(.black0)
                    .lineLimit(2)
                    .padding(.top, 12)
                
                // 저자 글자 개수에 따른 뷰 처리
                // 저자가 2줄 이상인 경우 bottom 정렬, 저자가 1줄인 경우 center 정렬
                HStack(alignment: matchReadingStatus(readingStatus: bookReadingStatus)?.author.count ?? 0 >= 14 ? .bottom : .center) {
                    // MARK: 저자
                    Text(matchReadingStatus(readingStatus: bookReadingStatus)?.author ?? "")
                        .font(.caption)
                        .lineLimit(2)
                        .foregroundStyle(.greyText)
                    
                    Spacer()
                    
                    // MARK: 더보기 버튼
                    Menu {
                        // 읽고 싶은 책이라면
                        if (bookReadingStatus == .wantToRead) {
                            // MARK: 읽는 중 버튼
                            Button {
                                // 버튼 누르면 sheet present되도록 만들기
                                isRegisterSheetAppear.toggle()
                                sheetReadingStatus = .reading
                            } label: {
                                Label("읽는 중", systemImage: "book")
                            }
                            // MARK: 다 읽음 버튼
                            Button {
                                isRegisterSheetAppear.toggle()
                                sheetReadingStatus = .finishRead
                            } label: {
                                Label("다 읽음", systemImage: "book.closed")
                            }
                        }
                        // 다 읽은 책 이라면
                        else if (bookReadingStatus == .finishRead){
                            // MARK: 정보 버튼
                            NavigationLink {
                                // 책 정보 화면으로 이동
                                BookInfo(isbn: matchReadingStatus(readingStatus: bookReadingStatus)?.isbn ?? "")
                                    .toolbarRole(.editor) // back 텍스트 표시X
                                    .toolbar(.hidden, for: .tabBar) // toolbar 숨기기
                            } label: {
                                Label("정보", systemImage: "info.circle")
                            }
                            
                            // MARK: 소장 버튼
                            Button {
                                // 이미 소장한 책인 경우
                                if (matchReadingStatus(readingStatus: bookReadingStatus)?.isMine ?? false) {
                                    isShowMineTrueAlert.toggle()
                                }
                                // 소장하지 않은 책인 경우
                                else {
                                    // 책 소장 API 호출
                                    viewModel.changeIsMine(
                                        isbn: viewModel.homeFinishReadBooks![bookIndex].isbn,
                                        request: ChangeIsMineRequest(isMine: true)) { success in
                                            if success {
                                                viewModel.homeFinishReadBooks?[bookIndex].isMine = true
                                                isShowMineFalseAlert.toggle()
                                            }
                                        }
                                }
                            } label: {
                                Label("소장", systemImage: "square.and.arrow.down")
                            }
                            // MARK: 리뷰 남기기 버튼
                            Button {
                                // TODO: 리뷰 등록 화면으로 이동
                            } label: {
                                Label("리뷰 남기기", systemImage: "ellipsis.bubble")
                            }
                        }
                    } label: {
                        Image(systemName: "ellipsis")
                            .font(.caption)
                            .foregroundStyle(.black0)
                    }
                    // sheet modal 보여주기 위한 코드
                    .sheet(isPresented: $isRegisterSheetAppear) {
                        // Sheet 뷰
                        if let book = matchReadingStatus(readingStatus: bookReadingStatus) {
                            RegisterBook(
                                isSheetAppear: $isRegisterSheetAppear,
                                readingStatus: $sheetReadingStatus,
                                isbn: book.isbn
                            )
                        }
                    }
                    // MARK: 소장 버튼 클릭 시 나타나는 Alert(소장한 책인 경우)
                    .alert(
                        "이미 소장된 책입니다",
                        isPresented: $isShowMineTrueAlert
                    ) {
                        Button("확인") { }
                    }
                    // MARK: 소장 버튼 클릭 시 나타나는 Alert(소장하지 않은 책인 경우)
                    .alert(
                        "책을 소장했습니다",
                        isPresented: $isShowMineFalseAlert
                    ) {
                        Button("확인") { }
                    }
                }
                .frame(height: matchReadingStatus(readingStatus: bookReadingStatus)?.author.count ?? 0 >= 14 ? 32 : 16)
                .padding(.top, 5)
            }
            .fixedSize(horizontal: false, vertical: true)
        }
        .frame(width: 173)
        .padding(.trailing, 12)
        .padding(.bottom, 20)
    }
    
    /// 전달받은 정보가 읽고 싶은 책 or 다 읽은 책인지 판단 후 값을 반환하는 함수
    func matchReadingStatus(readingStatus: ReadingStatus) -> HomeBookModel? {
        if readingStatus == .wantToRead {
            return viewModel.homeWantToReadBooks?[bookIndex]
        }
        else if readingStatus == .finishRead {
            return viewModel.homeFinishReadBooks?[bookIndex]
        }
        return nil
    }
}

#Preview {
    BookItemView(viewModel: MainPageViewModel(), bookIndex: 0, bookReadingStatus: .wantToRead)
}
