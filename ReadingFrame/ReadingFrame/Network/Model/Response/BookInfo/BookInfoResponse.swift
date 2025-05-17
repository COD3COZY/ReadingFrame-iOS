//
//  BookInfoResponse.swift
//  ReadingFrame
//
//  Created by 석민솔 on 4/28/25.
//

import Foundation

/// 도서정보 초기조회 
struct BookInfoResponse: Codable {
    let cover: String
    let title: String
    let author: String
    let categoryName: Int
    let readingStatus: Int
    let publisher: String
    let publicationDate: String
    let totalPage: Int
    let description: String
    let commentCount: Int
    let selectedReviewList: [Int]?
    let commentList: [CompactComment]?
}


extension BookInfoResponse {
    /// 도서정보 뷰에서 활용하는 entity로 전환시켜주기
    func toEntity(isbn: String) -> BookInfoModel {
        return BookInfoModel(
            isbn: isbn,
            cover: self.cover,
            title: self.title,
            author: self.author,
            categoryName: CategoryName(rawValue: self.categoryName) ?? .etc,
            publisher: self.publisher,
            publicationDate: self.publicationDate,
            totalPage: self.totalPage,
            description: self.description,
            commentCount: self.commentCount,
            selectedReviewList: self.toSelectReviewCodeList(selectedReviewList),
            commentList: self.commentList
        )
    }
        
    /// 리뷰 코드 정수값 배열을 selectReviewCode enum 객체 배열로 바꿔주기
    func toSelectReviewCodeList(_ intList: [Int]?) -> [SelectReviewCode]? {
        var selectReviewCodeList: [SelectReviewCode] = []
        
        if let intList {
            for value in intList {
                if let reviewCode = SelectReviewCode(rawValue: value) {
                    selectReviewCodeList.append(reviewCode)
                }
            }
            
            return selectReviewCodeList
        }
        else { return nil }
    }
}
