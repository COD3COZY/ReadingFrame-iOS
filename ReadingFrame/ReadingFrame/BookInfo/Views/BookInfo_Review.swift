//
//  BookInfo_Review.swift
//  ReadingFrame
//
//  Created by 석민솔 on 2/25/24.
//

import SwiftUI

/// 독자들의 한줄평 페이지
struct BookInfo_Review: View {
    // MARK: - Property
    /// API 통해서 받아올 한줄평 데이터들. 지금은 일단 더미 데이터로 입력해두었습니다.
    @State var modelData = BookInfo_ReviewModel(comments:
                                                    [Comment(commentText: "베스트셀러인 이유가 있는 것 같아요. 한 번쯤 읽어 보시기를 추천합니다!", nickname: "시나모롤", heartCount: 2, goodCount: 5),
                                                     Comment(commentText: "3번째 읽고 있습니다. 읽을 때마다 감동이 오는 것 같아요! 같은 책을 여러 번 읽는 건 처음이네요. 인생 책을 만난 기분입니다!", nickname: "독서왕", heartCount: 2, goodCount: 5),
                                                     Comment(commentText: "흠.. 저는 기대했던 것 보다는 별로였던 것 같아요.", nickname: "비니", goodCount: 1, wowCount: 2, sadCount: 5, angryCount: 2),
                                                     Comment(commentText: "베스트셀러인 이유가 있는 것 같아요. 한 번쯤 읽어 보시기를 추천합니다!", nickname: "시나모롤", heartCount: 2, goodCount: 5),
                                                      Comment(commentText: "3번째 읽고 있습니다. 읽을 때마다 감동이 오는 것 같아요! 같은 책을 여러 번 읽는 건 처음이네요. 인생 책을 만난 기분입니다!", nickname: "독서왕", heartCount: 2, goodCount: 5),
                                                      Comment(commentText: "흠.. 저는 기대했던 것 보다는 별로였던 것 같아요.", nickname: "비니", heartCount: 2, goodCount: 5)])
    
    /// 정렬방식
    @State var orderType: OrderType = .reaction
    
    /// 몇번째 API 호출(조회)인지
    var orderNumber: Int = 0
    
    /// 한줄평 데이터들
    var comments: [Comment] {
        return modelData.comments
    }

    
    
    // MARK: - View
    var body: some View {
        VStack {
            // MARK: 반응순 최신순 버튼
            HStack {
                Spacer()
                sortTypeView(orderType: $orderType)
            }
            .padding([.top, .horizontal], 16)
    
            // MARK: 한줄평 리스트
            List(comments) { comment in
                // TODO: 한줄평 하나 표시할 Row마다 View 만들어서 List로 보여주기
                CommentRowView(comment: comment)
            }
            .listStyle(.plain)
        }        
        // MARK: 네비게이션 바 설정
        .navigationTitle("독자들의 한줄평")
        .navigationBarTitleDisplayMode(.inline)
    }
    
}

/// 반응순/최신순 선택하기 버튼
struct sortTypeView: View {
    
    /// 정렬방식 받아와서 바꿔주기
    @Binding var orderType: OrderType
    
    var body: some View {
        HStack(spacing: 5) {
            // 반응순 버튼
            Button(action: {
                orderType = .reaction
                
                // TODO: 모델 다시 API 호출
                // ex. modelData.fetchData()
            }) {
                Text("반응순")
                    .font(.caption)
                    .foregroundStyle(orderType == .reaction ? .black0 : .greyText)
            }
            
            // 구분점
            Circle()
                .frame(width: 3, height: 3)
                .foregroundStyle(Color.greyText)
            
            // 최신순 버튼
            Button(action: {
                orderType = .latest
                
                // TODO: 모델 다시 API 호출
                // ex. modelData.fetchData()
            }) {
                Text("최신순")
                    .font(.caption)
                    .foregroundStyle(orderType == .latest ? .black0 : .greyText)
            }
            
        }
    }
}


// MARK: - Preview: 네비게이션 바까지 확인 시 필요
struct BookInfoReviewNavigate_Preview: PreviewProvider {
    static var previews: some View {
        // 네비게이션 바 연결해주기 위해 NavigationStack 사용
        NavigationStack {
            NavigationLink("한줄평 페이지로 이동") {
                BookInfo_Review()
                    .toolbarRole(.editor)   // 이전 버튼 뒤에 화면 이름 표기 없음
            }
            .navigationTitle("Home")
        }
        // 이전 버튼(<) 색 검은색으로
        .tint(.black0)
    }
}

// MARK: - 기본 Preview
struct BookInfoReview_Preview: PreviewProvider {
    static var previews: some View {
        BookInfo_Review()
    }
}

