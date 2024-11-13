//
//  EditReview_CheckReviews.swift
//  ReadingFrame
//
//  Created by 석민솔 on 9/23/24.
//

import SwiftUI

/// 3종리뷰 전체 확인하는 화면
struct EditReview_CheckReviews: View {
    // MARK: - Properties
    /// 완성된 리뷰 객체
    @StateObject var review: Review
    
    /// 수정 가능한 키워드
    @State var keyword: String = ""
    
    /// 리뷰에 아무것도 없는지 체크하는 변수
    private var isReviewAllEmpty: Bool {
        // 한줄평이 nil일 때
        if review.comment == nil {
            // 선택리뷰 없음 체크
            // 키워드 없음 체크
            return review.selectReviews.isEmpty && keyword.isEmpty
        } else {
            // 한줄평 nil이 아니라면 비어있는지 체크 & 2종 리뷰도 없는지 체크
            let comment = review.comment!
            return review.selectReviews.isEmpty && keyword.isEmpty && comment.isEmpty
        }
    }
    
    /// 리뷰 등록이 가능한지 버튼 활성화여부 체크용 변수
    private var isUploadEnabled: Bool {
        // 필수인 선택리뷰 존재하는지 체크
        !review.selectReviews.isEmpty
    }
    
    /// 한줄평 수정용 sheet 띄우기 변수
    @State var isCommentSheetAppear: Bool = false
    
    /// 전체삭제 진짜로 할건지 물어보는 알람 띄우는 변수
    @State var showDeleteAlert: Bool = false
    
    // MARK: - View
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottom) {
                ScrollView {
                    VStack(alignment: .leading) {
                        // 전체 리뷰 확인 & 전체 삭제 버튼
                        titleBar
                            .padding(.top, 10)
                        
                        // 선택한 키워드
                        selectReviewSection
                            .padding(.top, 30)

                        // 이 책을 기억하고 싶은 단어 한 가지
                        keywordSection(parentViewWidth: geometry.size.width)
                            .padding(.top, 20)
                        
                        // 한줄평
                        commentSection
                            .padding(.top, 30)
                    }
                    .padding(.horizontal, 16)
                }
                .padding(.horizontal, -16)
                // 리뷰 등록하기 버튼이랑 안겹치게
                .padding(.bottom, 70)
                
                // 리뷰 등록하기 버튼
                registerReviewButton
                    .padding(.bottom, 15)
            }
            .padding(.horizontal, 16)
        }
        .navigationTitle("리뷰 작성") // 네비게이션 바 타이틀
        .navigationBarTitleDisplayMode(.inline) // 상단에 바 뜨는 모양
        .sheet(isPresented: $isCommentSheetAppear) {
            CheckReviews_EditComment(parentComment: $review.comment, isCommentSheetAppear: $isCommentSheetAppear)
        } // 한줄평 수정
        .alert(isPresented: $showDeleteAlert) {
            /// 전체삭제 alert의 "예" 버튼
            let doDeleteButton = Alert.Button.destructive(Text("예")) {
                // 리뷰 삭제하기
                withAnimation(.easeOut) {
                    review.selectReviews.removeAll()
                    keyword.removeAll()
                    review.comment?.removeAll()
                }
            }
            
            return Alert(title: Text("삭제하시겠습니까?"),
                         message: Text("한번 삭제한 리뷰는 복구할 수 없습니다."),
                         primaryButton: .default(Text("아니요")),
                         secondaryButton: doDeleteButton)
            
        }// 삭제 버튼 눌렀을 때 띄워줄 alert
        .task {
            // 키워드 있으면 입력시켜두기
            if let keyword = review.keyword {
                self.keyword = keyword
            }
        }
        .onChange(of: keyword) { oldValue, newValue in
            // review 객체의 키워드에 뷰에서 편집하는 키워드 바로 입력하기
            review.keyword = newValue
        }

    }
}

#Preview {
    EditReview_CheckReviews(review: .init())
}

extension EditReview_CheckReviews {
    /// 전체 리뷰 확인 & 전체 삭제 버튼
    private var titleBar: some View {
        HStack {
            Text("전체 리뷰 확인")
                .font(.thirdTitle)
            
            Spacer()
            
            Button {
                // 정말 삭제할거냐고 alert 띄우기
                showDeleteAlert.toggle()
                
            } label: {
                Text("전체 삭제")
                    .font(.subheadline)
                    // 삭제할 게 없으면 회색(greytext)으로, 있다면 빨간색
                    .foregroundStyle(isReviewAllEmpty ? Color.greyText : Color.red0)
            }
            // 삭제할 게 아무것도 없으면 비활성화
            .disabled(isReviewAllEmpty)

        }
        .padding(.vertical, 9)
    }
    
    /// 이 책을 기억하고 싶은 단어 한 가지 섹션 UI
    @ViewBuilder
    func keywordSection(parentViewWidth: Double) -> some View {
        VStack {
            // 제목 & 삭제 버튼
            nameAndDeleteBar(reviewType: .keyword)
            
            // 입력된 키워드
            KeywordTextField(text: $keyword, parentViewWidth: parentViewWidth)
                .frame(height: 45, alignment: .topLeading)
        }
    }
    
    /// 선택한 키워드  섹션 UI
    private var selectReviewSection: some View {
        VStack(alignment: .leading) {
            // 제목 & 전체 삭제 버튼
            nameAndDeleteBar(reviewType: .select)
            
            // 키워드 한줄로 보여주기
            ForEach(review.selectReviews, id: \.self) { selected in
                Text(selected.text)
                    .font(.subheadline)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .background(
                        RoundedRectangle(cornerRadius: 40)
                            .fill(Color.white)
                            .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 0)
                    )
                    .padding(.bottom, 7)
            }
            
            // 추가하기 버튼
            // 5개 미만일 때만
            if review.selectReviews.count < 5 {
                NavigationLink {
                    EditReview_Select(review: self.review, isEditMode: true)
                        .toolbarRole(.editor)
                } label: {
                    HStack(spacing: 2) {
                        Image(systemName: "plus")
                            .font(.subheadline)
                        Text("추가하기")
                            .font(.subheadline)
                    }
                    .foregroundStyle(Color.greyText)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .background(
                        RoundedRectangle(cornerRadius: 40)
                            .fill(Color.white)
                            .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 0)
                    )
                }

            }
        }
    }
    
    /// 한줄평 섹션 UI
    private var commentSection: some View {
        VStack {
            // 제목 & 삭제 버튼
            nameAndDeleteBar(reviewType: .comment)
            
            if let commentText = review.comment, !commentText.isEmpty {
                Text(commentText)
                    .font(.subheadline)
                    .lineLimit(10, reservesSpace: true)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
            } else {
                Text("책에 대한 생각을 자유롭게 적어주세요")
                    .font(.subheadline)
                    .foregroundStyle(Color.greyText)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
        }
        .onTapGesture {
            // 한줄평 수정 sheet 띄우기
            isCommentSheetAppear.toggle()
        }
    }
    
    /// 리뷰 등록하기 버튼
    private var registerReviewButton: some View {
        VStack {
            Button {
                // TODO: API 연결
                
                // TODO: 쌓여있는 리뷰 화면 다 빠져나가기
            } label: {
                Text("리뷰 등록하기")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.white)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.vertical, 16)
                    .background(
                        RoundedRectangle(cornerRadius: 40)
                            .fill(isUploadEnabled ? Color.main : Color.greyText)
                    )
            }
            .disabled(!isUploadEnabled)
        }
    }
    
    /// 제목 & 삭제 버튼
    @ViewBuilder
    func nameAndDeleteBar(reviewType: ReviewType) -> some View {
        
        let title: String = switch reviewType {
        case .select:
            "선택한 키워드"
        case .keyword:
            "이 책을 기억하고 싶은 단어 한 가지"
        case .comment:
            "한줄평"
        }
        
        HStack(spacing: 5) {
            // 제목
            Text(title)
                .font(.headline)
            
            // 선택한 키워드면 필수 마크 있어야됨
            if reviewType == .select {
                Text("*")
                    .font(.headline)
                    .foregroundStyle(Color.main)
                    .offset(y: -6)
            }
            
            Spacer()
            
            // 삭제 버튼 동작
            Button {
                withAnimation {
                    if reviewType == .select {
                        // 선택리뷰 삭제
                        review.selectReviews.removeAll()
                        
                    } else if reviewType == .keyword {
                        // 키워드 삭제
                        keyword.removeAll()
                        
                    } else {
                        // 한줄평 삭제
                        review.comment?.removeAll()
                    }
                }
            } label: {
                Image(systemName: "trash")
                    .font(.headline)
                    .foregroundStyle(Color.grey2)
            }

        }
        .padding(.vertical, 9)
    }
    
    /// 종류별 리뷰
    enum ReviewType {
        case select
        case keyword
        case comment
    }
}
