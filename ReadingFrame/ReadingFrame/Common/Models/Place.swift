//
//  Place.swift
//  ReadingFrame
//
//  Created by 석민솔 on 2/3/25.
//

/// 위치를 주고받을 때 필요한 기본정보들
struct PlaceInfo: Codable {
    /// 위치 이름
    var placeName: String
    
    /// 주소
    var address: String
    
    /// 위도
    var latitude: Double
    
    /// 경도
    var longitude: Double

}
