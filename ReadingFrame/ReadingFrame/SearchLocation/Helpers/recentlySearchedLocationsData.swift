//
//  recentlySearchedLocationsData.swift
//  ReadingFrame
//
//  Created by 석민솔 on 7/23/24.
//

import MapKit

class RecentLocationData {
    static var locations: [recentlySearchedLocation]? = [
        recentlySearchedLocation(placeName: "서울여대 구내안경점", address: "대한민국 서울특별시 노원구 공릉동 126, 01797", coordinate: CLLocationCoordinate2D(latitude: 37.628000, longitude: 127.090230)),
        recentlySearchedLocation(placeName: "티티푸드", address: "대한민국 서울특별시 노원구 공릉동 254, 01821", coordinate: CLLocationCoordinate2D(latitude: 37.624777, longitude: 127.084938)),
        recentlySearchedLocation(placeName: "버거아이엔지", address: "대한민국 서울특별시 노원구, 01797", coordinate: CLLocationCoordinate2D(latitude: 37.628556, longitude: 127.090513)),
        recentlySearchedLocation(placeName: "노원로3", address: "대한민국 서울특별시 노원구 노원로3, 01827", coordinate: CLLocationCoordinate2D(latitude: 37.621888, longitude: 127.086690)),
        recentlySearchedLocation(placeName: "원자력병원", address: "원자력병원, 대한민국 서울특별시 노원구 노원로 75, 01812", coordinate: CLLocationCoordinate2D(latitude: 37.628785, longitude: 127.082764))
    ]
}

