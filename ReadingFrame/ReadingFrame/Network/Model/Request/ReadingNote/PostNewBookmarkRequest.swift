//
//  PostNewBookmarkRequest.swift
//  ReadingFrame
//
//  Created by 석민솔 on 3/17/25.
//

import Foundation

struct PostNewBookmarkRequest: Encodable {
    let date: String
    let markPage: Int
    let mainLocation: PlaceInfo?
    let uuid: String = UUID().uuidString
}
