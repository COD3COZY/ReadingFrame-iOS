//
//  BookmarkTapResponse.swift
//  ReadingFrame
//
//  Created by 석민솔 on 8/7/25.
//

import Foundation

struct BookmarkTapResponse: Decodable {
    let date: String
    let markPage: Int
    let markPercent: Int
    let loaction: LocationDTO?
    let uuid: String
}
