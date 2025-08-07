//
//  PostNewBookmarkRequest.swift
//  ReadingFrame
//
//  Created by 석민솔 on 3/17/25.
//

import Foundation

/// 책갈피 등록 DTO
struct PostNewBookmarkRequest: Encodable {
    let date: String
    let markPage: Int
    let mainLocation: LocationDTO?
    let uuid: String = UUID().uuidString
}
