//
//  EditReviewViewModel.swift
//  ReadingFrame
//
//  Created by 석민솔 on 9/11/25.
//

import Foundation

class EditReviewViewModel: ObservableObject {
    // MARK: - Properties
    /// 작성하는 리뷰의 페이지를 위한 페이지 숫자
    @Published var currentPage: Int
    
    /// 작성할 리뷰 객체
    @Published var review: Review
    
    // MARK: - init
    init(review: Review?) {
        if review == nil {
            self.currentPage = ReviewTypeDestination.select.rawValue
        } else {
            self.currentPage = ReviewTypeDestination.check.rawValue
        }

        if let existingReview = review {
            self.review = existingReview
        } else {
            self.review = .init()
        }
    }
    
    // MARK: - Methods
    func moveToNextPage() {
        if (currentPage + 1) <= ReviewTypeDestination.selectEdit.rawValue {
            currentPage += 1
        } else {
            return
        }
    }
    
    func moveToPreviousPage() {
        if (currentPage - 1) >= ReviewTypeDestination.select.rawValue {
            currentPage -= 1
        }
    }
    
    func moveToLastPage() {
        currentPage = ReviewTypeDestination.check.rawValue
    }
}
