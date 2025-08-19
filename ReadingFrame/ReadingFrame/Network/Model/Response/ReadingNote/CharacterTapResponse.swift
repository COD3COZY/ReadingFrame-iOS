//
//  CharacterTapResponse.swift
//  ReadingFrame
//
//  Created by 석민솔 on 8/20/25.
//

import Foundation

struct CharacterTapResponse: Decodable {
    let emoji: Int
    let name: String
    let preview: String?
    let description: String?
}
