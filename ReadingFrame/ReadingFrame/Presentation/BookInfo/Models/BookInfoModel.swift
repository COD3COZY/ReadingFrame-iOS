//
//  BookInfoModel.swift
//  ReadingFrame
//
//  Created by 석민솔 on 2/19/24.
//

import Foundation

/// 도서정보 뷰에서 보여줄 정보 모델
/// - 도서정보 초기조회 API에서 readingStatus 제외한 
struct BookInfoModel {
    /// isbn
    let isbn: String
    /// 책 표지 이미지 URL
    let cover: String
    /// 책 제목
    let title: String
    /// 저자
    let author: String
    /// 카테고리
    let categoryName: CategoryName
    /// 출판사
    let publisher: String
    /// 발행일
    let publicationDate: String
    /// 전체 페이지
    let totalPage: Int
    /// 설명 텍스트
    let description: String
    
    /// 한줄 평 전체 개수
    let commentCount: Int
    
    /// 선택리뷰 top 10
    let selectedReviewList: [SelectReviewCode]?
    
    /// 한줄평 최신순 5개
    let commentList: [CompactComment]?
}
