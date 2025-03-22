//
//  BookshelfCategoryResponse.swift
//  ReadingFrame
//
//  Created by 석민솔 on 3/22/25.
//

import Foundation

struct BookshelfCategoryResponse: Codable {
    let categoryCode: Int
    let categoryCount: Int
    let totalPage: [Int]
}
