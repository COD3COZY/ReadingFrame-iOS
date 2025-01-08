//
//  Character.swift
//  ReadingFrame
//
//  Created by 이윤지 on 5/29/24.
//

import Foundation

/// 등록된 책(읽고 있는 책, 다 읽은 책)의 인물사전 모델
struct Character: Codable {
    /// 이모지
    var emoji: Int
    
    /// 인물 이름
    var name: String
    
    /// 한줄 소개
    var preview: String
    
    /// 메모
    var description: String
}
