//
//  LocationDTO.swift
//  ReadingFrame
//
//  Created by 석민솔 on 8/7/25.
//

/// 서버와 주고받는 위치정보 DTO
struct LocationDTO: Codable {
    let placeName: String
    let address: String
    let latitude: String
    let longitude: String
}
