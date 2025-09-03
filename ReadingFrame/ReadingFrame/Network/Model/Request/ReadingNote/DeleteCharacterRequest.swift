//
//  DeleteCharacterRequest.swift
//  ReadingFrame
//
//  Created by 석민솔 on 9/3/25.
//

import Foundation

/// 인물사전 삭제용 DTO
struct DeleteCharacterRequest: Encodable {
    let name: String
}
