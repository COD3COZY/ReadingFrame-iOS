//
//  MainPageReadingBookItem.swift
//  ReadingFrame
//
//  Created by 이윤지 on 2/21/24.
//

import SwiftUI

/// 홈 화면의 읽고 있는 책 리스트에 들어가는 개별 뷰
struct ReadingItemView: View {
    /// 홈 화면 뷰모델
    @ObservedObject var viewModel: MainPageViewModel
    
    /// 책 아이템 인덱스 값
    var bookIndex: Int
    
    /// 보여줄 책정보
    var currentBookInfo: HomeBookModel? {
        viewModel.homeReadingBooks?[bookIndex]
    }
    
    /// 다 읽음 Alert이 띄워졌는지 확인하기 위한 변수
    @State private var isShowFinishReadAlert = false
    
    /// 숨기기 Alert이 띄워졌는지 확인하기 위한 변수
    @State private var isShowHidBookAlert = false
    
    /// 소장 Alert이 띄워졌는지 확인하기 위한 변수(소장O)
    @State private var isShowMineTrueAlert = false
    
    /// 소장 Alert이 띄워졌는지 확인하기 위한 변수(소장X)
    @State private var isShowMineFalseAlert = false
    
    /// sheet가 띄워져 있는지 확인하는 변수
    @State var isSheetAppear: Bool = false
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            // MARK: 책 표지
            NavigationLink {
                // 책 정보 화면으로 이동
                BookInfo(isbn: currentBookInfo!.isbn)
                    .toolbarRole(.editor) // back 텍스트 표시X
                    .toolbar(.hidden, for: .tabBar) // toolbar 숨기기
            } label: {
                LoadableBookImage(bookCover: currentBookInfo?.cover ?? "")
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .frame(width: 144, height: 220)
                    .shadow(color: Color(white: 0, opacity: 0.2), radius: 18, x: 2, y: 2)
            }
            
            // MARK: 책 이름
            Text("\(currentBookInfo?.title ?? "")")
                .font(.headline)
                .foregroundStyle(.black0)
                .padding(.top, 20)
            
            // MARK: 저자
            Text("\(currentBookInfo?.author ?? "")")
                .font(.footnote)
                .foregroundStyle(.greyText)
                .padding(.top, 2)
            
            // MARK: 막대 그래프 및 퍼센트
            ReadingPercentBar(
                readPage: currentBookInfo?.readPage ?? 0,
                totalPage: currentBookInfo?.totalPage ?? 0,
                readingPercent: currentBookInfo?.readingPercent ?? 0
            )
            .padding(.horizontal, 45)
            .frame(height: 55)
            
            HStack(spacing: 10) {
                // MARK: 책갈피 버튼
                Button {
                    isSheetAppear.toggle() // sheet 보이기
                } label: {
                    ReadingLabel(label: "책갈피", image: "bookmark")
                }
                
                // MARK: 독서노트 버튼
                NavigationLink {
                    // 독서노트 화면으로 이동
                    ReadingNote(isbn: currentBookInfo!.isbn)
                        .toolbarRole(.editor) // back 텍스트 표시X
                        .toolbar(.hidden, for: .tabBar) // toolbar 숨기기
                } label: {
                    ReadingLabel(label: "독서노트", image: "magazine")
                }
                
                // MARK: - Menu
                Menu {
                    // MARK: 다 읽음 버튼
                    Button {
                        isShowFinishReadAlert.toggle()
                    } label: {
                        Label("다 읽음", systemImage: "book.closed")
                    }
                    
                    // MARK: 홈 화면에서 숨기기 버튼
                    Button {
                        isShowHidBookAlert.toggle()
                    } label: {
                        Label("홈 화면에서 숨기기", systemImage: "eye.slash")
                    }
                    
                    // MARK: 리뷰 남기기 버튼
                    Button {
                        // TODO: 리뷰 등록 화면으로 이동
                    } label: {
                        Label("리뷰 남기기 버튼", systemImage: "bubble")
                    }
                    
                    // MARK: 소장 버튼
                    Button {
                        if let isMine = currentBookInfo?.isMine {
                            // 이미 소장한 책인 경우
                            if (isMine) {
                                isShowMineTrueAlert.toggle()
                            }
                            // 소장하지 않은 책인 경우
                            else {
                                isShowMineFalseAlert.toggle()
                            }
                        }
                    } label: {
                        Label("소장", systemImage: "square.and.arrow.down")
                    }
                } label: {
                    Image(systemName: "ellipsis")
                        .font(.body)
                        .foregroundStyle(.black0)
                }
            }
            .padding(.top, 15)
            // MARK: 책갈피 버튼 클릭 시 나타나는 Sheet
            .sheet(isPresented: $isSheetAppear) {
                bookmarkRegisterSheet
            }
            // MARK: 다 읽음 버튼 클릭 시 나타나는 Alert
            .alert(
                "책을 다 읽으셨나요?",
                isPresented: $isShowFinishReadAlert
            ) {
                Button("확인") {
                    // 독서 상태 변경 API 호출
                    viewModel.changeReadingStatus(
                        isbn: currentBookInfo!.isbn,
                        request: ChangeReadingStatusRequest(
                            readingStatus: ReadingStatus.finishRead.rawValue
                        )
                    ) { success in
                            if success {
                                viewModel.homeReadingBooks?[bookIndex].readingStatus = .finishRead
                            }
                        }
                }
                
                Button("취소", role: .cancel) { }
            } message: {
                Text("다읽은 책으로 표시됩니다.")
            }
            // MARK: 숨기기 버튼 클릭 시 나타나는 Alert
            .alert(
                "읽는 중인 책을 숨깁니다",
                isPresented: $isShowHidBookAlert
            ) {
                Button("확인") {
                    // 읽고 있는 책 숨기기 & 꺼내기 API 호출
                    viewModel.hiddenReadBook(
                        isbn: currentBookInfo!.isbn,
                        request: HiddenReadBookRequest(isHidden: true)) { success in
                            viewModel.homeReadingBooks?[bookIndex].isHidden = true
                        }
                }
                
                Button("취소", role: .cancel) { }
            } message: {
                Text("읽는 중인 책 전체보기에서\n확인하실 수 있습니다.")
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
                Button("확인") {
                    // 소장 여부 변경 API 호출
                    viewModel.changeIsMine(
                        isbn: currentBookInfo!.isbn,
                        request: ChangeIsMineRequest(isMine: true)) { success in
                            if success {
                                viewModel.homeReadingBooks?[bookIndex].isMine = true
                            }
                        }
                }
            }
        }
        .padding(.top, 18)
    }
}

// MARK: - View Components
extension ReadingItemView {
    /// 책갈피 등록 Sheet
    private var bookmarkRegisterSheet: some View {
        EditAllRecord(
            book: EditRecordBookModel(
                bookType: currentBookInfo?.bookType ?? .paperbook,
                totalPage: currentBookInfo?.totalPage ?? 0,
                isbn: currentBookInfo?.isbn ?? ""
            ),
            isSheetAppear: $isSheetAppear,
            selectedTab: RecordType.bookmark.rawValue,
            isForEditing: false,
            isPickerAppear: false
        )
    }
}

#Preview {
    ReadingItemView(viewModel: MainPageViewModel(), bookIndex: 0)
}
