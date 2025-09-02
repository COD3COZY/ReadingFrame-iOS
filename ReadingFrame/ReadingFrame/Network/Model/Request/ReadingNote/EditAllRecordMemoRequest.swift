//
//  EditAllRecordMemoRequest.swift
//  ReadingFrame
//
//  Created by 석민솔 on 9/2/25.
//

import Foundation

/// 메모 등록 및 수정을 위한 DTO 모델
struct EditAllRecordMemoRequest: Encodable {
    let uuid: String
    let date: String
    let markPage: Int?
    let memoText: String
}
