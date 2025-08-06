//
//  BookInfo.swift
//  ReadingFrame
//
//  Created by 석민솔 on 2/16/24.
//

import SwiftUI

/// 도서정보와 리뷰 간략하게 조회하는 페이지.
struct BookInfo: View {
    // MARK: - Parameters
    @StateObject var vm: BookInfoViewModel
    
    /// RegisterBook modal 띄워줄 변수
    @State var isRegisterSheetAppear: Bool = false
    
    // MARK: - init
    init(isbn: String) {
        _vm = StateObject(wrappedValue: BookInfoViewModel(isbn: isbn))
    }
    
    
    // MARK: - View
    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 25) {
                    // MARK: 책 기본정보
                    basicBookInfo
                    
                    // MARK: 책설명
                    descriptionSection
                    
                    // MARK: 키워드 리뷰
                    VStack (alignment: .leading, spacing: 15) {
                        Text("이 책의 키워드 리뷰")
                            .font(.headline)
                        
                        // 키워드 리뷰가 한개도 없을 경우
                        if (vm.selectReviews.count == 0) {
                            // 리뷰 없음 뷰
                            zeroReview(isForKeyword: true)
                            
                        // 키워드 리뷰가 있을 경우
                        } else {
                            // 너비 끝나면 다음줄로 넘어가는 선택리뷰
                            SelectReviewClusterView(selectReviews: vm.bookInfo?.selectedReviewList ?? [])
                        }
                        
                    }
                    
                    
                    
                    // MARK: 한줄평 리뷰
                    VStack (spacing: 15) {
                        // 독자들의 한줄평 bar
                        HStack {
                            Text("독자들의 한줄평")
                                .font(.headline)
                            
                            Spacer()
                            
                            // 한줄평 페이지 링크용 right chevron
                            NavigationLink {
                                // 한줄평 페이지로 이동
                                BookInfo_Review()
                                    .toolbarRole(.editor)   // 이전 버튼 뒤에 화면 이름 표기 없음
                                    .toolbar(.hidden, for: .tabBar)
                            } label: {
                                Image(systemName: "chevron.forward")
                                    .font(.headline)
                                    .foregroundStyle(Color.black)
                            }
                            
                        }
                        // 한줄평이 한개도 없을 경우
                        if (vm.bookInfo?.commentCount == 0) {
                            // 리뷰 없음 뷰
                            zeroReview(isForKeyword: false)
                                .padding(.bottom, 80)
                            
                            
                        // 한줄평이 있을 경우
                        } else {
                            // 한줄평 가로스크롤뷰
                            CommentHScrollView(comments: vm.bookInfo?.commentList ?? [])
                            // 내서재 추가하기 버튼 위로까지 컨텐츠 보여주기
                                .padding(.bottom, 120)
                            // 화면상 뜨는 공간 없이 가로스크롤
                                .padding(.horizontal, -16)
                        }
                        
                    }
                    
                }
                // LazyVStack 패딩
                .padding([.leading, .top, .trailing], 16)
                .padding(.bottom, 50)
                
                
            }
            // MARK: 고정위치 버튼 뷰
            bookInfoBottomBar

        }
        // MARK: 네비게이션 바 설정
        .navigationTitle("도서 정보")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: View Components
extension BookInfo {
    /// 도서정보 상단 기초정보 보여주는 뷰
    private var basicBookInfo: some View {
        HStack(spacing: 20) {
            // MARK: 커버 이미지
            LoadableBookImage(bookCover: vm.bookInfo?.cover ?? "")
                .clipShape(RoundedRectangle(cornerRadius: 15))
                // 크기 적용
                .frame(maxWidth: 170, maxHeight: 260)
                // 그림자
                .shadow(color: Color(red: 0.47, green: 0.47, blue: 0.47).opacity(0.3), radius: 7.5, x: 0, y: 0)
            
            // 오른쪽 책정보
            VStack(alignment: .leading, spacing: 0) {
                // MARK: 책정보 태그
                Tag_Info(category: vm.bookInfo?.categoryName)
                    .padding(.bottom, 12)
                
                // MARK: 제목
                Text(vm.bookInfo?.title ?? "제목없음")
                    .font(.thirdTitle)
                    .padding(.bottom, 5)
                
                // MARK: 저자
                Text(vm.bookInfo?.author ?? "저자없음")
                    .font(.footnote)
                    .padding(.bottom, 10)
                
                // MARK: 리뷰 개수(한줄평 페이지 연결)
                NavigationLink {
                    // 한줄평 페이지로 연결
                    BookInfo_Review()
                        .toolbarRole(.editor)   // 이전 버튼 뒤에 화면 이름 표기 없음
                        .toolbar(.hidden, for: .tabBar)
                } label: {
                    HStack(alignment: .center, spacing: 5) {
                        Image(systemName: "bubble")
                            .resizable()
                            .scaledToFit()
                            .fontWeight(.medium)
                            .foregroundStyle(Color.black)
                            .frame(width: 20)
                        
                        Text(String(vm.bookInfo?.commentCount ?? 0))
                            .font(.caption)
                            .foregroundStyle(Color.black)
                        
                        Image(systemName: "chevron.right")
                            .font(.caption)
                            .fontWeight(.medium)
                            .foregroundStyle(Color.black0)
                            .padding(.leading, -2)
                    }
                    .padding(.vertical, 5)
                }
                
                Spacer()
                
                // MARK: 출판사
                simpleBarInfo(key: "출판사", value: vm.bookInfo?.publisher ?? "")
                    .padding(.bottom, 6)
                
                // MARK: 발행일
                simpleBarInfo(key: "발행일", value: vm.bookInfo?.publicationDate ?? "")
                    .padding(.bottom, 6)

                // MARK: 페이지
                simpleBarInfo(key: "페이지", value: String(vm.bookInfo?.totalPage ?? 0))

            }
            .padding(.vertical)
        }
        .frame(maxHeight: 260)
    }
    
    /// 바 하나 중간에 두고 간단한 정보 있는 뷰
    private func simpleBarInfo(key: String, value: String) -> some View {
        HStack(alignment: .center , spacing: 5) {
            Text(key)
            
            Rectangle()
                .frame(width: 1, height: 10)
                .foregroundStyle(Color.black0)
            
            Text(value)
        }
        .font(.caption)
    }
    
    /// 책 설명 컴포넌트
    private var descriptionSection: some View {
        VStack(alignment: .leading , spacing: 15) {
            Text("책 설명")
                .font(.headline)
                        
            Text(vm.bookInfo?.description ?? "설명없음")
                .font(.footnote)
            
            Text("정보제공: 알라딘")
                .font(.caption)
                .foregroundStyle(Color.greyText)
        }
    }
    
    /// 책이 등록되지 않았을 때의 뷰
    /// - isForKeyword: 키워드 리뷰가 등록되지 않은 메시지 띄우고 싶을 때는 true, 한줄평 없다고 하고싶을 땐 false
    private func zeroReview(isForKeyword: Bool) -> some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Text("🧐")
                    .font(.system(size: 64))
                    .fontWeight(.medium)
                    .foregroundStyle(.black0)
                
                let reviewType = isForKeyword ? "키워드 리뷰가" : "한줄평이"
                Text("아직 작성된 \(reviewType) 없어요. \n 첫 번째 리뷰어가 되어 보세요!")
                    .font(.footnote)
                    .foregroundStyle(.greyText)
                    .padding(.leading, 15)
                
                Spacer()
            }
        }
        .padding([.leading, .trailing], 16)
    }
    
    /// 도서정보 페이지 하단부 고정바
    private var bookInfoBottomBar: some View {
        HStack {
            // 독서노트 없을 때만: 읽고싶어요 하트 버튼
            if !vm.haveReadingNote {
                wantToReadHeartButton
            }
            
            // 내 서재에 추가하기 버튼
            addToMyBookButton
        }
        .animation(.easeInOut, value: vm.haveReadingNote)
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
    
    /// 읽고싶어요 하트 버튼
    private var wantToReadHeartButton: some View {
        Button {
            // 미등록 -> 읽고싶은 책으로
            if vm.readingStatus != .wantToRead {
                // 읽고싶은 책 등록 API 호출
                vm.postWantToRead()
            }
            // 읽고싶은 책 -> 미등록으로
            else {
                // 독서상태 미등록으로 변경하는 API 호출
                vm.cancelWantToRead()
            }
        } label: {
            // 미등록일 때 빈 검은색 테두리 하트
            // 읽고싶어요일 때는 차있는 자주색 하트
            Image(systemName: vm.readingStatus == .wantToRead ? "heart.fill" : "heart")
                .foregroundStyle(vm.readingStatus == .wantToRead ? Color.main : Color.black0)
                .font(.title2)
        }
        .animation(.bouncy, value: vm.readingStatus)
    }
    
    /// 내 서재에 추가하기 버튼
    private var addToMyBookButton: some View {
        Button(action: {
            if (!vm.haveReadingNote) {
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
            Text(vm.haveReadingNote ? "독서노트 보러가기" : "내 서재에 추가하기")
                .font(.headline)
                .padding(10)
                .frame(maxWidth: .infinity, alignment: .center)
        })
        .tint(Color.main)
        .buttonStyle(.borderedProminent)
        .clipShape(.capsule)
        .sheet(isPresented: $isRegisterSheetAppear) {
            if let bookInfo = vm.bookInfo {
                RegisterBook(
                    isSheetAppear: $isRegisterSheetAppear,
                    readingStatus: $vm.readingStatus,
                    isbn: bookInfo.isbn,
                    bookInfo: RegisterBookInfoModel(
                        cover: bookInfo.cover,
                        title: bookInfo.title,
                        author: bookInfo.author,
                        categoryName: bookInfo.categoryName.name,
                        totalPage: bookInfo.totalPage,
                        publisher: bookInfo.publisher,
                        publicationDate: bookInfo.publicationDate
                    )
                )
            }
        }
    }
    
}



// MARK: - Preview: 네비게이션 바까지 확인 시 필요
struct BookInfoNavigate_Preview: PreviewProvider {
    static var previews: some View {
        // 네비게이션 바 연결해주기 위해 NavigationStack 사용
        NavigationStack {
            NavigationLink("도서 정보 보기") {
                BookInfo(isbn: "")
                    .toolbarRole(.editor)   // 이전 버튼 뒤에 화면 이름 표기 없음
            }
            .navigationTitle("Home")
        }
        // 이전 버튼(<) 색 검은색으로
        .tint(.black0)
    }
}

struct BookInfo_Preview: PreviewProvider {
    static var previews: some View {
        BookInfo(isbn: "")
    }
}

