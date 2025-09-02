//
//  PostNewMemoRequest.swift
//  ReadingFrame
//
//  Created by 석민솔 on 9/2/25.
//

import Foundation

struct PostNewMemoRequest: Encodable {
    let uuid: String = UUID().uuidString
    let date: String
    let markPage: Int?
    let memoText: String
}
