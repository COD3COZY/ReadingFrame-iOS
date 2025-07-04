//
//  DetailBookModel.swift
//  ReadingFrame
//
//  Created by 석민솔 on 7/2/25.
//

import Foundation

/// 메인 상세 페이지의 책에서 사용될 책정보
protocol DetailBookModel {
    var isbn: String { get }
    var cover: String { get }
    var title: String { get }
    var author: String { get }
    var category: CategoryName { get }
    var readingStatus: ReadingStatus { get }
}
