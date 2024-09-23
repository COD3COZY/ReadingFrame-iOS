//
//  SelectReviewTokenView.swift
//  ReadingFrame
//
//  Created by 석민솔 on 9/23/24.
//

import SwiftUI

struct TEMP_EditReview_Select: View {
    // MARK: - Properties
    
    /// 선택리뷰 카테고리별 제목
    var selectReview_categorys: [String] = ["내용 및 구성", "감상", "기타"]
    
    /// 선택리뷰 카테고리별로 배열로 구분
    @State private var selectReviews: [[selectReviewCode]] = [
        // 내용 및 구성
        [.creative, .fastPaced, .realistic, .socialTheme, .philosophical, .historical, .environmentalIssues, .newPerspective, .specialized, .wellStructured, .convoluted],
        // 감상
        [.touching, .leaveLingering, .comforting, .sad, .difficult, .easyToRead, .entertaining, .insightful, .informative, .immersive, .angering, .intense],
        // 기타
        [.trustworthyAuthor, .hiddenGem, .polarising, .wantToOwn, .recommend, .readMultiple, .goodForGift, .looksNice, .wantSequel]
    ]
    
    /// 선택된 토큰
    @State private var selected: [selectReviewCode] = []

    /// 편집 모드인지, 처음 리뷰 생성 모드인지 확인
    @State var isEditMode: Bool = false
    
    // MARK: - View
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            // 메인 UI
            VStack(alignment: .leading, spacing: 0) {
                // MARK: 선택된 토큰들 보여주는 구역
                Text("이 책은 어떤 내용인가요?")
                    .font(.thirdTitle)
                    .foregroundStyle(Color.black0)
                    .padding(.top, 10)
                    .padding(.leading, 16)
                    .padding(.bottom, 13)
                
                Text("1개 ~ 5개 키워드를 선택해주세요")
                    .font(.caption)
                    .foregroundStyle(Color.greyText)
                    .padding(.leading, 16)
                
                // 선택된 토큰 가로 스크롤 말고 다음 줄로 넘겨서 보여주는 뷰
                VStack {
                    WrapLayout(alignment: .leading) {
                        ForEach(selected, id: \.self) { token in
                            TokenView(token)
                                .onTapGesture {
                                    withAnimation(.snappy) {
                                        selected.removeAll(where: { $0 == token })
                                    }
                                }
                        }
                    }
                }
                .padding(20)
                .background(.white)
                .frame(minHeight: 80)
                
                // MARK: 카테고리별 토큰 선택하는 구역
                ScrollView(.horizontal) {
                    HStack(alignment: .top, spacing: 50) {
                        ForEach(Array(selectReview_categorys).indices, id: \.self) { index in
                            SelectReviewCategoryView(
                                name: selectReview_categorys[index],
                                tokenSet: selectReviews[index]
                            )
                        }
                    }
                }
                .padding(20)
                .scrollClipDisabled(true)
                .scrollIndicators(.hidden)
                .background(Color.grey1)
                .background(ignoresSafeAreaEdges: .bottom)
            }
            
            // 화면 전환 버튼
            moveButton
        }
        .navigationTitle("리뷰 작성")
    }
}

extension TEMP_EditReview_Select {
    /// 토큰 1개 UI
    @ViewBuilder
    func TokenView(_ token: selectReviewCode) -> some View {
        HStack(spacing: 10) {
            Text(token.text)
                .font(.callout)
                .fontWeight(.semibold)
        }
        .foregroundStyle(selected.contains(token) ? Color.white : Color.black0)
        .padding(.vertical, 10)
        .padding(.horizontal, 20)
        .background {
            Capsule()
                .fill(selected.contains(token) ? Color.black0 : Color.white)
                .shadow(color: .black.opacity(0.15), radius: 2, x: 0, y: 0)
        }
    }
    
    /// 한 카테고리에 대한 토큰 선택 UI (세로 한 줄)
    @ViewBuilder
    func SelectReviewCategoryView(name: String, tokenSet: [selectReviewCode]) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            // 선택리뷰 카테고리 제목
            Text(name)
                .font(.headline)
                .foregroundStyle(Color.black0)
                .padding(.bottom, 20)
            
            // 카테고리별 토큰 선택지
            ScrollView {
                VStack(alignment: .leading, spacing: 15) {
                    ForEach(tokenSet, id: \.self) { token in
                        TokenView(token)
                            .onTapGesture {
                                withAnimation(.snappy) {
                                    if selected.contains(token) {
                                        // 이미 선택된 거라면 해제
                                        selected.removeAll(where: { $0 == token })
                                    } else {
                                        // 선택 안돼있던 거라면 추가
                                        selected.insert(token, at: selected.endIndex)
                                    }
                                }
                            }
                    }
                }
                .padding(10) // 리스트 초기에도 그림자까지 보이도록
                .padding(.bottom, 70) // 스크롤 다 올리면 토큰과 화면 이동 버튼이 충돌하지 않도록
            }
            .padding(-10) // 사각형 위치는 왼쪽 정렬에서 벗어나지 않도록
        }
    }
    
    /// 다음/완료 버튼
    private var moveButton: some View {
        HStack {
            Spacer()
            
            // 이동조건 미충족시: 선택이 안 되었거나, 선택이 5개를 초과했을 때 '버튼'으로 disable
            if selected.count < 1 || selected.count > 5 {
                Button(action: {}) {
                    // 수정 모드, 입력 모드 따라 달라지는 버튼 내용
                    if isEditMode {
                        // 수정 모드이면 '완료'
                        Text("완료")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                    } else {
                        // 입력 모드이면 '다음 >'
                        Text("다음")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                        
                        Image(systemName: "chevron.right")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                    }
                }
                .padding(.vertical, 15)
                .padding(.horizontal, 25)
                .background(RoundedRectangle(cornerRadius: 40).fill(Color.greyText))
                .disabled(true)
                
            } else {
                // 이동조건 충족 시: NavigationLink로 연결시켜주기
                // TODO: 화면 맞춰서 이동시키기
                NavigationLink(destination: isEditMode ? BookMap() : BookMap()) {
                    HStack {
                        // 수정 모드, 입력 모드 따라 달라지는 버튼 내용
                        if isEditMode {
                            Text("완료")
                                .font(.headline)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                        } else {
                            Text("다음")
                                .font(.headline)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                            
                            Image(systemName: "chevron.right")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                        }
                    }
                }
                .padding(.vertical, 15)
                .padding(.horizontal, 25)
                .background(RoundedRectangle(cornerRadius: 40).fill(Color.main))
            }
        }
        .padding(16)
    }
}

#Preview {
    TEMP_EditReview_Select()
}
