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
    // MARK: - Properties
    
    /// 모든 annotation 위치 정보 배열
    var locations: [Location]
    
    /// 최근위치 정보
    var recentlocationInfos: [LocationInfo]
    
    /// 현재 선택된 하나의 위치
    @Published var selectedLocation: Location? {
        didSet {
            // 위치 선택되면 실행
            guard let selected = selectedLocation else { return }
            
            // 지도 위치 바꾸기
            updateMapRegion(location: selected)
        }
    }
    
    /// 현재 리스트에서 선택된 하나의 위치정보
    @Published var selectedLocationInfo: LocationInfo? {
        didSet {
            // 리스트에서 한 항목 선택되면 실행
            guard let selected = selectedLocationInfo else { return }
            
            // 위치정보에서 가지고 있던 위치 ID로 선택하기
            movetoSelectLocation(id: selected.locationID)
        }
    }
    
    /// 위치별 정보로 검색된 리스트
    @Published var foundInfoList: [LocationInfo]?
    
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
        
    // MARK: - init
    init() {
        // TODO: 지도 마크 조회 API 호출하기
        // 일단은 더미 데이터로 입력해둠
        self.locations = BookLocationData.locations
        
        // TODO: 전체 위치 조회 API 호출하기
        // 일단은 더미 데이터로 입력해둠
        self.recentlocationInfos = BookLocationData.locationInfos

        // TODO: 현위치 지도 초기화면 띄우기(비동기..)
        self.mapRegion = MKCoordinateRegion(center: locations.first!.coordinates, span: mapSpan)
//        Task {
//            await initializeMapRegion()
//        }
//        self.movetoCurrentLocation()
    }
    
    // MARK: - Methods
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
    
    /// 위경도로, 지정한 span으로 지도 이동
    private func updateMapRegion(location: CLLocationCoordinate2D, span: MKCoordinateSpan) {
        withAnimation(.easeInOut) {
            mapRegion = MKCoordinateRegion(
                center: location,
                span: span)
        }
    }
    
    
    /// 현재 위치로 지도 이동
    func movetoCurrentLocation() {
        locationManager.getCurrentLocation()
        print("현재 위치: \(self.currentLocation?.latitude), \(self.currentLocation?.latitude)")
        if let currentLocation = self.currentLocation {
            updateMapRegion(location: currentLocation)
        }
    }
    
    
    /// 선택한 Location 위치로 이동
    func movetoSelectLocation(location: Location) {
        selectedLocation = location
    }
    
    
    /// id 바탕으로 위치 선택하고 이동
    func movetoSelectLocation(id: Int) {
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
            foundInfoList = nil
        }
    }
    
    // TODO: 나중에 API 호출로 바꾸기
    /// 선택한 location과 id가 일치하는 정보 리스트 항목 찾기
    /// 지금은 일단 data안에서 찾는걸로
    func findInfoList(by location: Location) {
        var infoList: [LocationInfo] = []
        
        for info in BookLocationData.locationInfos {
            if location.id == info.locationID {
                infoList.append(info)
            }
        }
        
        // TODO: found
        self.foundInfoList = infoList
    }
    
     // 초기위치 유저위치로
//    private func initializeMapRegion() async {
//        let locations = BookLocationData.locations
//        self.locations = locations
//        
//        if let currentLocation = await locationManager.getCurrentLocationAsync() {
//            updateMapRegion(location: currentLocation, span: mapSpan)
//        } else {
//            // 현재 위치를 가져오지 못한 경우, 기본 위치 설정
//            self.mapRegion = MKCoordinateRegion(center: locations.first!.coordinates, span: mapSpan)
//        }
//    }
    
}

