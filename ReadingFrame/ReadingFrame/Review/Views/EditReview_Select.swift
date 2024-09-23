//
//  EditReview_Select.swift
//  ReadingFrame
//
//  Created by 석민솔 on 9/22/24.
//

import SwiftUI

/// 선택리뷰 화면
/// - 초기 리뷰 생성 상태와 편집 상태를 isEditMode: Bool로 구분합니다
/// - 리뷰 편집으로 넘어오는 경우 현재 화면을 불러올 때 유저가 선택한 키워드들을 selected 배열에 입력, isEditMode = true 로 입력해서 화면 생성해주시면 됩니다.
struct EditReview_Select: View {
    // MARK: - Properties
    var selectReview_categorys: [String] = ["내용 및 구성", "감상", "기타"]
    
    /// 선택리뷰: 내용 및 구성, 감상, 기타
    @State private var selectReviews: [[selectReviewCode]] = [
        [.creative, .fastPaced, .realistic, .socialTheme, .philosophical, .historical, .environmentalIssues, .newPerspective, .specialized, .wellStructured, .convoluted], // 내용 및 구성
        [.touching, .leaveLingering, .comforting, .sad, .difficult, .easyToRead, .entertaining, .insightful, .informative, .immersive, .angering, .intense], // 감상
        [.trustworthyAuthor, .hiddenGem, .polarising, .wantToOwn, .recommend, .readMultiple, .goodForGift, .looksNice, .wantSequel] // 기타
    ]
    
    /// 선택한 선택지들
    /// - 편집 모드일 때는 여기에 선택했던 리뷰들이 입력됩니다.
    @State private var selected: [selectReviewCode] = []
    
    /// 애니메이션을 위한 Namespace 변수
    @Namespace private var animation
    
    /// 편집 모드인지 여부 (리뷰 편집 모드 또는 초기 생성 모드)
    @State var isEditMode: Bool = false
    
    // MARK: - View
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            VStack(alignment: .leading, spacing: 0) {
                
                // 제목 섹션
                titleSection
                
                // 선택된 토큰들을 보여주는 영역
                selectedTokensSection
                
                // 카테고리별 토큰 선택 영역
                reviewCategoriesSection
            }
            
            // 다음 단계로 이동하거나 완료 버튼
            moveButton
        }
        .navigationTitle("리뷰 작성") // 네비게이션 바 타이틀
    }
}

#Preview {
    EditReview_Select()
}

extension EditReview_Select {
    // MARK: 제목 섹션
    private var titleSection: some View {
        VStack(alignment: .leading, spacing: 0) {
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
        }
    }
    
    // MARK: 선택된 토큰 섹션
    private var selectedTokensSection: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 10) {
                // 선택된 토큰들을 보여주는 ForEach
                ForEach(selected, id: \.self) { token in
                    TokenView(token)
                        .matchedGeometryEffect(id: token, in: animation) // 애니메이션 효과 추가
                        .onTapGesture {
                            // 선택된 토큰을 제거
                            withAnimation(.snappy) {
                                selected.removeAll { $0 == token }
                            }
                        }
                }
            }
            .frame(height: 35)
            .padding(20)
        }
        .scrollClipDisabled(true)
        .scrollIndicators(.hidden)
        .background(.white) // 배경색 흰색
    }
    
    // MARK: 카테고리별 토큰 섹션
    /// 카테고리별로 토큰을 선택할 수 있는 섹션
    private var reviewCategoriesSection: some View {
        ScrollView(.horizontal) {
            HStack(alignment: .top, spacing: 50) {
                ForEach(selectReview_categorys.indices, id: \.self) { index in
                    // 카테고리별 토큰을 보여주는 뷰
                    SelectReviewCategoryView(
                        selectReview_categorys[index],
                        selectReviews[index],
                        selected: $selected, // 선택된 토큰 배열을 바인딩
                        animation: animation // 애니메이션 효과
                    )
                }
            }
        }
        .padding(20)
        .scrollClipDisabled(true)
        .scrollIndicators(.hidden)
        .background(Color.grey1)
        .background(ignoresSafeAreaEdges: .bottom) // 배경색 적용
    }
    
    // MARK: 다음/완료 버튼 섹션
    /// 다음 단계로 이동하거나 완료하는 버튼 섹션
    private var moveButton: some View {
        HStack {
            Spacer()
            
            // 버튼 활성화 조건: 선택된 토큰이 1개 이상 5개 이하일 때만 활성화
            let isDisabled = selected.count < 1 || selected.count > 5
            let buttonText = isEditMode ? "완료" : "다음"
            
            // 이동조건 미충족시 버튼
            if isDisabled {
                Button(action: {}) {
                    HStack {
                        Text(buttonText)
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                        
                        if !isEditMode {
                            Image(systemName: "chevron.right")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                        }
                    }
                }
                .padding(.vertical, 15)
                .padding(.horizontal, 25)
                .background(RoundedRectangle(cornerRadius: 40).fill(Color.greyText))
                .disabled(true)
                
            } else {
                // TODO: 이동조건 충족되면, 모드에 맞춰 화면 이동시키기
                NavigationLink(destination: isEditMode ? BookMap() /* 전체확인 페이지 */ : BookMap() /* 키워드리뷰 페이지 */) {
                    HStack {
                        Text(buttonText)
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                        
                        if !isEditMode {
                            Image(systemName: "chevron.right")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                        }
                    }
                    .padding(.vertical, 15)
                    .padding(.horizontal, 25)
                    .background(RoundedRectangle(cornerRadius: 40).fill(Color.main))
                }
            }
        }
        .padding(16)
    }
}

extension EditReview_Select {
    // MARK: 토큰 뷰
    @ViewBuilder
    func TokenView(_ token: selectReviewCode) -> some View {
        HStack(spacing: 10) {
            Text(token.text)
                .font(.callout)
                .fontWeight(.semibold)
        }
        .foregroundStyle(selected.contains(token) ? Color.white : Color.black0) // 선택된 토큰의 색상을 흰색으로 변경
        .padding(.vertical, 10)
        .padding(.horizontal, 20)
        .background {
            Capsule()
                .fill(selected.contains(token) ? Color.black0 : Color.white) // 선택된 경우 배경을 검정색으로 변경
                .shadow(color: .black.opacity(0.15), radius: 2, x: 0, y: 0)
        }
    }
    
    // MARK: 카테고리별 토큰 선택 뷰
    /// 선택 리뷰 토큰들을 카테고리별로 세로로 나열하여 선택할 수 있는 뷰
    @ViewBuilder
    func SelectReviewCategoryView(_ name: String, _ tokenSet: [selectReviewCode], selected: Binding<[selectReviewCode]>, animation: Namespace.ID) -> some View {
        let filteredTokens = tokenSet.filter { !selected.wrappedValue.contains($0) } // 이미 선택된 토큰을 제외한 나머지 필터링
        
        VStack(alignment: .leading, spacing: 0) {
            Text(name)
                .font(.headline)
                .foregroundStyle(Color.black0)
                .padding(.bottom, 20)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 15) {
                    ForEach(filteredTokens, id: \.self) { token in
                        TokenView(token)
                            .onTapGesture {
                                // 상단 리스트에 선택된 토큰을 추가
                                withAnimation(.snappy) {
                                    selected.wrappedValue.insert(token, at: 0)
                                }
                            }
                            .matchedGeometryEffect(id: token, in: animation) // 애니메이션 효과 추가
                    }
                }
                .padding(10)
                .padding(.bottom, 70) // 스크롤 시 버튼과 겹치지 않도록 여백 추가
            }
            .padding(-10) // 사각형 위치 조정
        }
    }
}
