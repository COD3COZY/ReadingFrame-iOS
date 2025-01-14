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
    /// 작성할 리뷰 객체
    @StateObject var review: Review = .init()
    
    /// 선택된 선택리뷰
    var selected: [selectReviewCode] {
        review.selectReviews
    }
    
    /// 선택리뷰 카테고리
    var selectReview_categorys: [String] = ["내용 및 구성", "감상", "기타"]
    
    /// 선택리뷰: 내용 및 구성, 감상, 기타
    @State private var selectReviews: [[selectReviewCode]] = [
        [.creative, .fastPaced, .realistic, .socialTheme, .philosophical, .historical, .environmentalIssues, .newPerspective, .specialized, .wellStructured, .convoluted], // 내용 및 구성
        [.touching, .leaveLingering, .comforting, .sad, .difficult, .easyToRead, .entertaining, .insightful, .informative, .immersive, .angering, .intense], // 감상
        [.trustworthyAuthor, .hiddenGem, .polarising, .wantToOwn, .recommend, .readMultiple, .goodForGift, .looksNice, .wantSequel] // 기타
    ]
        
    /// 애니메이션을 위한 Namespace 변수
    @Namespace private var animation
    
    /// 편집 모드인지 여부 (리뷰 편집 모드 또는 초기 생성 모드)
    @State var isEditMode: Bool = false
    
    // MARK: 리뷰 네비게이션 Stack 관리 관련
    /// 리뷰 전체 빠져나가기 위한 클로저
    let popToRootAction: () -> Void
    
    /// 화면 전환용
    @Environment(\.presentationMode) var presentationMode
    
    /// 리뷰 작성 빠져나가기 alert
    @State var exitReviewAlert: Bool = false
    
    
    /// 버튼 활성화 조건: 선택된 토큰이 1개 이상 5개 이하일 때만 활성화
    var isButtonDisabled: Bool {
        selected.count < 1 || selected.count > 5
    }
    
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
            conditionalButton
        }
        .navigationTitle("리뷰 작성") // 네비게이션 바 타이틀
        .navigationBarTitleDisplayMode(.inline) // 상단에 바 뜨는 모양
        // 상단 이전 버튼(리뷰 빠져나가기)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    exitReviewAlert.toggle()
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundStyle(.black0)
                        .fontWeight(.medium)
                }
                // MARK: < 버튼 클릭 시 나타나는 Alert
                .alert(
                    "이 페이지에서 나가시겠습니까?",
                    isPresented: $exitReviewAlert
                ) {
                    Button("아니오", role: .cancel) { }
                    Button("예", role: .destructive) {
                        // 리뷰 작성 빠져나가기
                        popToRootAction()
                    }
                } message: {
                    Text("변경사항이 저장되지 않을 수 있습니다.")
                }
            }
        }
        .task {
            print("---SelectReview 입력 페이지 task ----")
            print("Review객체정보\n- selected: \(selected)\n- keyword: \(review.keyword ?? "없어요. 없다니까요")\n- comment: \(review.comment ?? "없어요, 없다니까요")")
        }
        // 좌측 스와이프하면 이전화면으로 이동
        .gesture(
            DragGesture()
                .onChanged { value in
                    let startLocation = value.startLocation.x
                    
                    // 왼쪽 끝에서 시작된 드래그인지 확인
                    if startLocation < 50 {
                        let dragDistance = value.translation.width
                        // 오른쪽으로의 드래그 거리가 충분한지 확인
                        if dragDistance > 30 {
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                }
        )
    }
}

//#Preview {
//    EditReview_Select()
//}

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
                                review.selectReviews.removeAll { $0 == token }
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
        .background(ignoresSafeAreaEdges: .bottom) // 배경색 적용
    }
    
    // MARK: 다음/완료 버튼 섹션
    /// 다음 단계로 이동하거나 완료하는 버튼 섹션
    private var conditionalButton: some View {
        HStack {
            Spacer()
            
            NavigationLink (
                value: isEditMode
                // 수정모드였으면 전체화면 페이지로 연결
                ? ReviewNavigationDestination.editReview_checkReviews(data: self.review)
                // 초기 입력 모드였으면 키워드리뷰 페이지로 연결
                : ReviewNavigationDestination.editReview_keyword(data: self.review)
            ) {
                moveButton
            }
            .disabled(isButtonDisabled)
        }
        .padding(16)
    }
    
    private var moveButton: some View {
        HStack {
            Text(isEditMode ? "완료" : "다음")
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
        .background(
            RoundedRectangle(cornerRadius: 40)
                .fill(isButtonDisabled ? Color.greyText : Color.main)
        )
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
                                        review.selectReviews.removeAll(where: { $0 == token })
                                    } else {
                                        // 선택 안돼있던 거라면 추가
                                        review.selectReviews.insert(token, at: 0)
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
}
