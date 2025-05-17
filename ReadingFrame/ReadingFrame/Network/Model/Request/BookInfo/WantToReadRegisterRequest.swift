//
//  WantToReadRegisterRequest.swift
//  ReadingFrame
//
//  Created by 석민솔 on 5/17/25.
//

import Foundation

/// 읽고싶은 책 등록 API용 request DTO
struct WantToReadRegisterRequest: Encodable {
    let cover: String
    let title: String
    let author: String
    let categoryName: String
    let totalPage: Int
    let publisher: String
    let publicationDate: String
}
