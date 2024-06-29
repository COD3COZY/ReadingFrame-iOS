//
//  BookLocationData.swift
//  ReadingFrame
//
//  Created by 석민솔 on 6/30/24.
//

import MapKit

/// 데이터 직접 들어오기 전에 샘플 데이터 개념으로 가지고 있는 코드!
class BookLocationData {
    static let locations: [Location] = [
        // 학교 근처
        Location(CLLocationCoordinate2D(latitude: 37.628000, longitude: 127.090230), .bookmark),
        Location(CLLocationCoordinate2D(latitude: 37.624777, longitude: 127.084938), .main),
        Location(CLLocationCoordinate2D(latitude: 37.637752, longitude: 127.078139), .bookmark),
        // 이탈리아 로마
        Location(CLLocationCoordinate2D(latitude: 41.8902, longitude: 12.4922), .main),
        Location(CLLocationCoordinate2D(latitude: 41.8986, longitude: 12.4769), .bookmark),
        Location(CLLocationCoordinate2D(latitude: 41.9009, longitude: 12.4833), .main)
    ]
}

