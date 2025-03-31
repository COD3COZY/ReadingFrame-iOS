//
//  RegisterBookModel.swift
//  ReadingFrame
//
//  Created by 석민솔 on 3/28/25.
//

import Foundation
import MapKit

/// 책등록을 위한 데이터 모델
struct RegisterBookModel {
    let isbn: String
    var readingStatus: ReadingStatus
    var bookType: BookType
    var mainLocation: MKPlacemark?
    var isMine: Bool
    var startDate: Date
    var recentDate: Date
    let bookInformation: RegisterBookInfoModel
}

/// 책등록 시 서버에 보내줄 책의 정보들
struct RegisterBookInfoModel {
    let cover: String
    let title: String
    let author: String
    let categoryName: String
    let totalPage: Int
    let publisher: String
    let publicationDate: String
}
