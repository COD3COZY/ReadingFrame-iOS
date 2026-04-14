//
//  EditReview.swift
//  ReadingFrame
//
//  Created by 석민솔 on 9/11/25.
//

import SwiftUI

/// 리뷰 작성 플로우 큰 화면단위
/// - 아규먼트를 아무것도 입력하지 않은 상태로 호출 시, 생성모드
/// - review를 입력해서 생성할 시, 편집모드
struct EditReview: View {
    // MARK: - Properties
    @EnvironmentObject private var coordinator: Coordinator

    @ObservedObject var vm: EditReviewViewModel

    @State private var showExitAlert: Bool = false
    
    // MARK: - init
    init(review: Review? = nil) {
        self.vm = .init(review: review)
    }
    
    // MARK: - View
    var body: some View {
        VStack {
            switch vm.currentPage {
            case ReviewTypeDestination.select.rawValue:
                EditReview_Select(
                    confirmedSelected: $vm.review.selectReviews,
                    isEditMode: false,
                    moveToNextPage: vm.moveToNextPage,
                    moveToLastPage: vm.moveToLastPage
                )
                
            case ReviewTypeDestination.keyword.rawValue:
                EditReview_Keyword(
                    confirmedKeyword: $vm.review.keyword,
                    moveToPreviousPage: vm.moveToPreviousPage,
                    moveToNextPage: vm.moveToNextPage
                )
                
            case ReviewTypeDestination.comment.rawValue:
                EditReview_Comment(
                    confirmedComment: $vm.review.comment,
                    moveToPreviousPage: vm.moveToPreviousPage,
                    moveToNextPage: vm.moveToNextPage
                )
                
            case ReviewTypeDestination.check.rawValue:
                EditReview_CheckReviews(
                    review: vm.review,
                    popToRootAction: {
                        coordinator.popLast()
                    },
                    registerReview: vm.registerReview,
                    moveToSelectReviewEdit: vm.moveToNextPage
                )
                
            case ReviewTypeDestination.selectEdit.rawValue:
                EditReview_Select(
                    confirmedSelected: $vm.review.selectReviews,
                    isEditMode: true,
                    moveToNextPage: vm.moveToNextPage,
                    moveToLastPage: vm.moveToLastPage
                )
                
            default:
                GreyLogoAndTextView(text: "잘못된 화면이에요")
                    .onTapGesture {
                        vm.moveToLastPage()
                    }
                
            }
        }
        .navigationTitle("리뷰 작성") // 네비게이션 바 타이틀
        .navigationBarTitleDisplayMode(.inline) // 상단에 바 뜨는 모양
        // 상단 이전 버튼(리뷰 빠져나가기)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    showExitAlert.toggle()
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundStyle(.black0)
                        .fontWeight(.medium)
                }
                // MARK: < 버튼 클릭 시 나타나는 Alert
                .alert(
                    "이 페이지에서 나가시겠습니까?",
                    isPresented: $showExitAlert
                ) {
                    Button("아니오", role: .cancel) { }
                    Button("예", role: .destructive) {
                        // 리뷰 작성 빠져나가기
                        coordinator.popLast()
                    }
                } message: {
                    Text("변경사항이 저장되지 않을 수 있습니다.")
                }
            }
        }
        
    }
}

#Preview("기본 리뷰 생성모드") {
    EditReview()
}

#Preview("리뷰 수정모드") {
    EditReview(review: .init(selectReviews: [.comforting]))
}
