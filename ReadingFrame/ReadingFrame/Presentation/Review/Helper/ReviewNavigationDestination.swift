//
//  ReviewNavigationDestination.swift
//  ReadingFrame
//
//  Created by 석민솔 on 1/15/25.
//

import Foundation

/// 리뷰 화면의 네비게이션 스택 관리용 열거형
enum ReviewNavigationDestination: Hashable {
    case editReview_select_make
    case editReview_select_edit(data: Review)
    case editReview_keyword(data: Review)
    case editReview_comment(data: Review)
    case editReview_checkReviews(data: Review)
    
    var identifier: String {
        switch self {
        case .editReview_select_make:
            "EditReview_Select_Make"
        case .editReview_select_edit:
            "EditReview_Select_Edit"
        case .editReview_keyword:
            "EditReview_Keyword"
        case .editReview_comment:
            "EditReview_Comment"
        case .editReview_checkReviews:
            "EditReview_CheckReviews"
        }
    }
}
