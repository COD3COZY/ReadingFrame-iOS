//
//  PatchBookmarkRequest.swift
//  ReadingFrame
//
//  Created by 석민솔 on 8/7/25.
//

import Foundation

/// 책갈피 수정을 위한 DTO 모델
struct PatchBookmarkRequest: Encodable {
    let date: String
    let markPage: Int
    let mainLocation: LocationDTO?
    let uuid: String
}
