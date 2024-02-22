//
//  BookInfoBottomButtonView.swift
//  ReadingFrame
//
//  Created by 석민솔 on 2/19/24.
//

import SwiftUI

/// 도서정보 페이지 bottom 버튼
struct BookInfoBottomButtonView: View {
    // MARK: - Property
    /// 독서상태 전달해줄 책 인스턴스
    @Bindable var book: InitialBook
    
    /// 이 뷰에서 바꿔서 book 객체에 전달해줄 독서상태
    @State var readingStatus: ReadingStatus = .reading
    
    /// RegisterBook modal 띄워줄 변수
    @State var isRegisterSheetAppear: Bool = false
    
    /// 독서 상태가 변경되었는지 확인하기 위한 변수
    @Binding var isReadingStatusChange: Bool
    
    /// readingStatus값 따라서 독서노트 있는지 아닌지 알려주는 변수
    ///
    /// - 미등록, 읽고싶은 : 하트 버튼, 내서재 추가하기 조합
    /// - 읽는중, 다읽음: 독서노트로 이동하기버튼이냐
    var haveReadingNote: Bool {
        switch self.book.readingStatus {
        case .unregistered, .wantToRead:    // 독서노트 없음
            return false
        case .reading, .finishRead:         // 독서노트 있음
            return true
        }
    }
    
    // MARK: - View
    var body: some View {
        HStack {
            // MARK: 읽고싶어요 버튼
            // 독서노트 없을 때 띄워주기
            if (!haveReadingNote) {
                Button {
                    // 미등록, 읽고싶어요 토글 readingStatus 조건문으로 구현
                    if (book.readingStatus != .wantToRead) {
                        // 읽고싶은 책으로
                        book.readingStatus = .wantToRead
                        
                        // TODO: 읽고싶어요 API로 보내주기
                    } else {
                        // 미등록으로
                        book.readingStatus = .unregistered
                        
                        // TODO: 미등록 API로 보내주기
                    }
                    
                } label: {
                    // 미등록일 때 빈 검은색 테두리 하트
                    // 읽고싶어요일 때는 차있는 자주색 하트
                    Image(systemName: book.readingStatus == .wantToRead ? "heart.fill" : "heart")
                        .foregroundStyle(book.readingStatus == .wantToRead ? Color.accentColor : Color.black0)
                        .font(.title2)
                }
                .animation(.bouncy, value: book.readingStatus)
                
            }
            
            
            // MARK: 내 서재에 추가하기 버튼
            Button(action: {
                if (!haveReadingNote) {
                    // 미등록, 읽고싶은) 내 서재에 추가하기 -> RegisterBook 모달 띄워주기
                    isRegisterSheetAppear.toggle()
                } else {
                    // 읽는중, 다읽음) 등록된 책이면 독서노트 보러가기
                    // TODO: 독서노트 연결하기
                    print("독서노트 띄웠습니다")
                }
            }, label: {
                // 미등록, 읽고싶은) 내 서재에 추가하기
                // 읽는중, 다읽음) 등록된 책이면 독서노트 보러가기
                Text(haveReadingNote ? "독서노트 보러가기" : "내 서재에 추가하기")
                    .font(.headline)
                    .padding(10)
                    .frame(maxWidth: .infinity, alignment: .center)
            })
            .tint(.accentColor)
            .buttonStyle(.borderedProminent)
            .clipShape(.capsule)
            .sheet(isPresented: $isRegisterSheetAppear) {
                RegisterBook(book: book, 
                             readingStatus: $readingStatus,
                             isSheetAppear: $isRegisterSheetAppear, isReadingStatusChange: $isReadingStatusChange)
            }
        }
        .animation(.easeInOut, value: haveReadingNote)
        .padding(16)
        .background(
            ZStack(alignment: .bottom) {
                RoundedRectangle(cornerRadius: 25.0)
                    .foregroundStyle(Color.white)
                    .shadow(color: .black.opacity(0.12), radius: 3, x: 0, y: -1)
                Rectangle()
                    .foregroundStyle(Color.white)
                    .frame(height: 70)
            }
            .ignoresSafeArea()
        )

    }
}


// MARK: - Preview
struct BottomRegisterButtomPreview: PreviewProvider {
    static var previews: some View {
        BookInfoBottomButtonView(book: InitialBook(), isReadingStatusChange: .constant(false))
    }
}
