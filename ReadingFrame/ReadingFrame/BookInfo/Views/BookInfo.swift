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
    @State var modelData = BookInfoModel()
    
    var book: InitialBook {
        return modelData.book
    }
    
    var selectReviews: [selectReviewCode] {
        return modelData.selectReviews
    }
    
    var comments: [Comment] {
        return modelData.comments
    }
    
    // MARK: - View
    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 25) {
                    // MARK: 책 기본정보
                    BasicBookInfoView(book: book, commentCount: comments.count)
                    
                    // MARK: 책설명
                    DescriptionView(description: book.description)
                    
                    // MARK: 키워드 리뷰
                    VStack (alignment: .leading, spacing: 15) {
                        Text("이 책의 키워드 리뷰")
                            .font(.headline)
                        
                        // 키워드 리뷰가 한개도 없을 경우
                        if (selectReviews.count == 0) {
                            // 리뷰 없음 뷰
                            zeroReview(reviewType: "키워드 리뷰")
                            
                        // 키워드 리뷰가 있을 경우
                        } else {
                            // 너비 끝나면 다음줄로 넘어가는 선택리뷰
                            SelectReviewClusterView(selectReviews: selectReviews)
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
                            } label: {
                                Image(systemName: "chevron.forward")
                                    .font(.headline)
                                    .foregroundStyle(Color.black)
                            }
                            
                        }
                        // 한줄평이 한개도 없을 경우
                        if (comments.count == 0) {
                            // 리뷰 없음 뷰
                            zeroReview(reviewType: "키워드 리뷰")
                                .padding(.bottom, 80)
                            
                            
                        // 한줄평이 있을 경우
                        } else {
                            // 한줄평 가로스크롤뷰
                            CommentHScrollView(comments: comments)
                                .padding(.bottom, 120)
                        }
                        
                    }
                    
                }
                // LazyVStack 패딩
                .padding([.leading, .top, .trailing], 16)
                
                
            }
            // MARK: 고정위치 버튼 뷰
            BookInfoBottomButtonView(book: book)

        }
        // MARK: 네비게이션 바 설정
        .navigationTitle("도서 정보")
        .navigationBarTitleDisplayMode(.inline)
    }
}

/// 책설명
struct DescriptionView: View {
    var description: String
    
    var body: some View {
        VStack(alignment: .leading , spacing: 15) {
            Text("책 설명")
                .font(.headline)
                        
            Text(description)
                .font(.footnote)
            
            Text("정보제공: 알라딘")
                .font(.caption)
                .foregroundStyle(Color.greyText)
        }
    }
}

/// 책이 등록되지 않았을 때의 뷰
struct zeroReview: View {
    /// "키워드 리뷰" 인지 "한줄평"을 적어주면 됩니다
    var reviewType: String
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Text("🧐")
                    .font(.system(size: 64))
                    .fontWeight(.medium)
                    .foregroundStyle(.black0)
                
                Text("아직 작성된 \(reviewType)가 없어요. \n 첫 번째 리뷰어가 되어 보세요!")
                    .font(.footnote)
                    .foregroundStyle(.greyText)
                    .padding(.leading, 15)
                
                Spacer()
            }
        }
        .padding([.leading, .trailing], 16)
    }
}




// MARK: - Preview: 네비게이션 바까지 확인 시 필요
struct BookInfoNavigate_Preview: PreviewProvider {
    static var previews: some View {
        // 네비게이션 바 연결해주기 위해 NavigationStack 사용
        NavigationStack {
            NavigationLink("도서 정보 보기") {
                BookInfo()
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
        BookInfo()
    }
}

