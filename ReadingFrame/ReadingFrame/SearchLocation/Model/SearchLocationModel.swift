//
//  SearchLocationModel.swift
//  ReadingFrame
//
//  Created by 석민솔 on 7/23/24.
//

import MapKit

struct recentlySearchedLocation: Identifiable {
    let placeName: String
    let address: String
    let coordinate: CLLocationCoordinate2D
    
    var id: String {
        self.placeName
    }
}
