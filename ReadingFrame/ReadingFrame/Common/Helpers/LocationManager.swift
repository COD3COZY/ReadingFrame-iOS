//
//  LocationManager.swift
//  ReadingFrame
//
//  Created by 석민솔 on 6/30/24.
//

import CoreLocation
import MapKit
import SwiftUI

/// 현재 위치 조회용
class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()
    
    @Published var currentLocation: CLLocationCoordinate2D?
    
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    func getCurrentLocation() {
        manager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("didUpdateLocations 함수 호출됨")
        guard let currentLocation = locations.last else {
            print("위치 못불러오겠다~")
            return
        }
        
        self.currentLocation = currentLocation.coordinate
        print("위치 입력됨~")
        
        manager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print(error.localizedDescription)
    }
}

