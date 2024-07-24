//
//  ReadingItemDetailView.swift
//  ReadingFrame
//
//  Created by 이윤지 on 3/17/24.
//

import SwiftUI

/// 모든 책 상세 페이지의 리스트에 들어갈 아이템 뷰
struct BookItemDetailView: View {
    
    /// 책 객체
    @Bindable var book: RegisteredBook
    
    /// 독서 상태 여부
    var readingStatus: ReadingStatus
    
    /// 읽고 있는 책 관련 변수
    /// 다 읽음 Popup 띄움 여부 확인
    @State private var isShowFinishReadAlert = false
    
    /// 홈 화면에서 숨기기 Popup 띄움 여부 확인
    @State private var isShowHideBookAlert = false
    
    /// 소장 Popup 띄움 여부 확인
    @State private var isShowMineTrueAlert = false
    
    /// 미소장 Popup 띄움 여부 확인
    @State private var isShowMineFalseAlert = false
    
    /// 읽고 싶은 책 관련 변수
    /// sheet가 띄워져 있는지 확인하는 변수
    @State var isRegisterSheetAppear: Bool = false
    
    /// sheet를 띄우기 위한 기본 값
    @State var sheetReadingStatus: ReadingStatus = .reading
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .top, spacing: 0) {
                // MARK: - 책 표지
                LoadableBookImage(bookCover: book.book.cover)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .frame(width: 80, height: 120)
                    .padding(.trailing, 10)
                
                VStack(alignment: .leading, spacing: 0) {
                    HStack {
                        // MARK: - 배지
                        Badge_Info(
                            bookType: book.bookType,
                            category: book.book.categoryName,
                            isMine: book.isMine
                        )
                        
                        Spacer()
                        
                        // MARK: - Menu
                        // MARK: - 읽고 싶은 책인 경우
                        if (readingStatus == .wantToRead) {
                            Menu {
                                // MARK: 읽는 중 버튼
                                // 버튼 클릭시 등록 sheet 띄우기
                                Button {
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
                            } label: {
                                Image(systemName: "ellipsis")
                                    .font(.subheadline)
                                    .foregroundStyle(.black0)
                            }
                        }
                        // MARK: - 읽고 있는 책인 경우
                        else if (readingStatus == .reading) {
                            Menu {
                                // MARK: 다 읽음 버튼
                                Button {
                                    isShowFinishReadAlert.toggle()
                                } label: {
                                    Label("다 읽음", systemImage: "book.closed")
                                }
                                
                                // MARK: 정보 버튼
                                NavigationLink {
                                    // 책 정보 화면으로 이동
                                    BookInfo(modelData: BookInfoModel(book: book.book as! InitialBook))
                                        .toolbarRole(.editor) // back 텍스트 표시X
                                        .toolbar(.hidden, for: .tabBar) // toolbar 숨기기
                                } label: {
                                    Label("정보", systemImage: "info.circle")
                                }
                                
                                // MARK: 리뷰 남기기 or 확인하기 버튼
                                Button {
                                    // TODO: 리뷰 남기기 화면 연결
                                } label: {
                                    Label("리뷰 남기기", systemImage: "bubble")
                                }
                                
                                // MARK: 소장 버튼
                                Button {
                                    // 소장한 책인 경우
                                    if (book.isMine) {
                                        isShowMineTrueAlert.toggle()
                                    }
                                    // 소장하지 않은 책인 경우
                                    else {
                                        isShowMineFalseAlert.toggle()
                                    }
                                } label: {
                                    Label("소장", systemImage: "square.and.arrow.down")
                                }
                                
                                // MARK: 꺼내기 or 홈 화면에서 숨기기 버튼
                                if (book.isHidden) {
                                    Button {
                                        book.isHidden = false
                                    } label: {
                                        Label("꺼내기", systemImage: "tray.and.arrow.up")
                                    }
                                }
                                else {
                                    Button {
                                        isShowHideBookAlert.toggle()
                                    } label: {
                                        Label("홈 화면에서 숨기기", systemImage: "eye.slash")
                                    }
                                }
                                
                            } label: {
                                Image(systemName: "ellipsis")
                                    .font(.subheadline)
                                    .foregroundStyle(.black0)
                            }
                        }
                        // MARK: - 다 읽은 책인 경우
                        else {
                            Menu {
                                // MARK: 정보 버튼
                                NavigationLink {
                                    // 책 정보 화면으로 이동
                                    BookInfo(modelData: BookInfoModel(book: book.book as! InitialBook))
                                        .toolbarRole(.editor) // back 텍스트 표시X
                                        .toolbar(.hidden, for: .tabBar) // toolbar 숨기기
                                } label: {
                                    Label("정보", systemImage: "info.circle")
                                }
                                
                                // MARK: 소장 버튼
                                Button {
                                    // 소장한 책인 경우
                                    if (book.isMine) {
                                        isShowMineTrueAlert.toggle()
                                    }
                                    // 소장하지 않은 책인 경우
                                    else {
                                        isShowMineFalseAlert.toggle()
                                    }
                                } label: {
                                    Label("소장", systemImage: "square.and.arrow.down")
                                }
                                
                                // MARK: 리뷰 남기기 or 확인하기 버튼
                                Button {
                                    // TODO: 리뷰 남기기 화면 연결
                                } label: {
                                    Label("리뷰 남기기", systemImage: "bubble")
                                }
                                
                            } label: {
                                Image(systemName: "ellipsis")
                                    .font(.subheadline)
                                    .foregroundStyle(.black0)
                            }
                        }
                    }
                        
                    // MARK: 책 이름
                    Text("\(book.book.title)")
                        .font(.headline)
                        .foregroundStyle(.black0)
                        .padding(.top, 10)
                    
                    // MARK: 저자
                    Text("\(book.book.author)")
                        .font(.footnote)
                        .foregroundStyle(.black0)
                        .padding(.top, 3)
                    
                    // MARK: 진행률
                    if (readingStatus == .reading) {
                        // 읽고 있는 책일 때만 진행률 띄우기
                        ReadingPercentBar(book: book)
                            .frame(height: 55)
                    }
                }
                // MARK: - 책 등록 sheet
                .sheet(isPresented: $isRegisterSheetAppear) {
                    RegisterBook(book: book.book as! InitialBook,
                                 readingStatus: $sheetReadingStatus,
                                 isSheetAppear: $isRegisterSheetAppear)
                }
                // MARK: 다 읽음 버튼 클릭 시 나타나는 Alert
                .alert(
                    "책을 다 읽으셨나요?",
                    isPresented: $isShowFinishReadAlert
                ) {
                    Button("확인") {
                        book.book.readingStatus = .finishRead
                    }
                    Button("취소", role: .cancel) { }
                } message: {
                    Text("다읽은 책으로 표시됩니다.")
                }
                // MARK: 소장 버튼 클릭 시 팝업 띄우기(소장한 책인 경우)
                .alert(
                    "이미 소장된 책입니다",
                    isPresented: $isShowMineTrueAlert
                ) {
                    Button("확인") { }
                }
                // MARK: 소장 버튼 클릭 시 팝업 띄우기(소장하지 않은 책인 경우)
                .alert(
                    "책을 소장했습니다",
                    isPresented: $isShowMineFalseAlert
                ) {
                    Button("확인") {
                        book.isMine = true
                    }
                }
                // MARK: 홈 화면에서 숨기기 버튼 클릭 시 팝업 띄우기
                .alert(
                    "읽는 중인 책을 숨깁니다",
                    isPresented: $isShowHideBookAlert
                ) {
                    Button("확인") {
                        book.isHidden = true
                    }
                    Button("취소", role: .cancel) { }
                } message: {
                    Text("읽는 중인 책 전체보기에서\n확인하실 수 있습니다.")
                }
            }
                
            // MARK: Line
            Rectangle()
                .foregroundStyle(.grey2)
                .frame(height: 1)
                .padding(.top, 16)
        }
        .padding(.top, 16)
        .background(
            // 책 아이템 클릭 시, 각 화면으로 이동하기
            NavigationLink("", destination: destinationView(book: book))
                .opacity(0)
        )
    }
    
    // 아이템 클릭 시 이동하는 화면 함수
    @ViewBuilder
    func destinationView(book: RegisteredBook) -> some View {
        // 읽고 싶은 책이라면
        if (readingStatus == .wantToRead) {
            // 책 정보 화면으로 이동
            BookInfo(modelData: BookInfoModel(book: book.book as! InitialBook))
                .toolbarRole(.editor) // back 텍스트 표시X
                .toolbar(.hidden, for: .tabBar) // toolbar 숨기기
        }
        // 읽는 중, 다 읽은 책이라면
        else {
            // TODO: 독서노트 화면으로 이동
            ReadingNote(book: book)
                .toolbarRole(.editor) // back 텍스트 표시X
                .toolbar(.hidden, for: .tabBar) // toolbar 숨기기
        }
    }
}

#Preview {
    BookItemDetailView(book: RegisteredBook(), readingStatus: .reading)
}
