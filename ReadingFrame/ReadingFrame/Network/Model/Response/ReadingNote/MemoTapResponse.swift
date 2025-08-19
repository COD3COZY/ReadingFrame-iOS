//
//  MemoTapResponse.swift
//  ReadingFrame
//
//  Created by 석민솔 on 8/20/25.
//

import Foundation

struct MemoTapResponse: Decodable {
    let date: String
    let markPage: Int?
    let markPercent: Int?
    let memoText: String
    let uuid: String
}
