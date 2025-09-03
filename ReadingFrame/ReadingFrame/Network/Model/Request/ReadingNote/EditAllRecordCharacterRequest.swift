//
//  EditAllRecordCharacterRequest.swift
//  ReadingFrame
//
//  Created by 석민솔 on 9/3/25.
//

import Foundation

struct EditAllRecordCharacterRequest: Encodable {
    let emoji: Int
    let name: String
    let preview: String?
    let description: String?
}
