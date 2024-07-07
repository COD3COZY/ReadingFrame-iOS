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
    
    static let locationInfos: [LocationInfo] = [
        LocationInfo(locationType: .bookmark, bookTitle: "천 개의 파랑0", date: "2023.11.02", readPage: 104, placeName: "서울여자대학교 도서관", id: 0),
        LocationInfo(locationType: .main, bookTitle: "천 개의 파랑1", date: "2023.11.02", readPage: 104, placeName: "화랑대 근처", id: 1),
        LocationInfo(locationType: .bookmark, bookTitle: "천 개의 파랑2", date: "2023.11.02", readPage: nil, placeName: "과기대", id: 2),
        LocationInfo(locationType: .main, bookTitle: "천 개의 파랑3", date: "2023.11.02", readPage: 104, placeName: "콜로세움", id: 3),
        LocationInfo(locationType: .bookmark, bookTitle: "천 개의 파랑4", date: "2023.11.02", readPage: nil, placeName: "판테온", id: 4),
        LocationInfo(locationType: .main, bookTitle: "천 개의 파랑5", date: "2023.11.02", readPage: nil, placeName: "트레비 분수", id: 5),
    ]
}

