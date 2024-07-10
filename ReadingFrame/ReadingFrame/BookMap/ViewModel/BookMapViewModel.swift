//
//  BookMapViewModel.swift
//  ReadingFrame
//
//  Created by 석민솔 on 6/30/24.
//

import Foundation
import MapKit
import SwiftUI


class BookMapViewModel: ObservableObject {
    /// 모든 위치 정보 배열
    var locations: [Location] = []
    
    /// 현재 강조되는 한 개 위치
    @Published var selectedLocation: Location? {
        didSet {
            guard let selected = selectedLocation else { return }
            updateMapRegion(location: selected)
        }
    }
    
    /// 현재 리스트에서 선택된 하나의 위치정보
    @Published var selectedLocationInfo: LocationInfo?
    
    /// 지도 영역 보여주기 위한 MKCoordinateRegion
    @Published var mapRegion: MKCoordinateRegion = MKCoordinateRegion()
    /// 기본 mapSpan
    let mapSpan = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    
    /// 현재 위치 구하기용 location manager
    @Published var locationManager = LocationManager()
    
    var currentLocation: CLLocationCoordinate2D? {
        self.locationManager.currentLocation
    }
    
    /// annotation과 지도가 동시에 눌렸을 때 선택해제되지 않고 annotation 선택되도록 하기 위한 변수
    @Published var isAnnotationSelected: Bool = false
        
    
    init() {
        let locations = BookLocationData.locations
        self.locations = locations

        // TODO: 현위치 지도 초기화면 띄우기(비동기..)
        self.mapRegion = MKCoordinateRegion(center: locations.first!.coordinates, span: mapSpan)
    }
    
    /// location 객체로 지도 이동
    private func updateMapRegion(location: Location) {
        withAnimation(.easeInOut) {
            mapRegion = MKCoordinateRegion(
                center: location.coordinates,
                span: mapRegion.span)
        }
    }
    
    /// 위경도로 지도 이동
    private func updateMapRegion(location: CLLocationCoordinate2D) {
        withAnimation(.easeInOut) {
            mapRegion = MKCoordinateRegion(
                center: location,
                span: mapRegion.span)
        }
    }
    
    /// 선택한 Location 위치로 이동
    func movetoSelectLocation(location: Location) {
        selectedLocation = location
    }
    
    /// 현재 위치로 지도 이동
    func movetoCurrentLocation() {
        locationManager.getCurrentLocation()
        print("현재 위치: \(self.currentLocation?.latitude), \(self.currentLocation?.latitude)")
        if let currentLocation = self.currentLocation {
            updateMapRegion(location: currentLocation)
        }
    }
    
    
    /// id 바탕으로 위치 선택하고 이동
    func moveSelectLocation(id: Int) {
        if let matchIndex = locations.firstIndex(where: { $0.id == id
        }) {
            withAnimation(.easeInOut) {
                selectedLocation = locations[matchIndex]
            }
        }
    }
    

    // annotation 밖 지도 누르면 모두 annotation 모두 비활성화
    func deselectAll() {
        withAnimation {
            selectedLocation = nil
            selectedLocationInfo = nil
        }
    }
    
}

