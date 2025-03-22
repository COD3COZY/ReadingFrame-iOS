//
//  SearchLocationManager.swift
//  ReadingFrame
//
//  Created by 석민솔 on 7/23/24.
//

import SwiftUI
import CoreLocation
import MapKit
// Combine Framework to watch Textfield Change
import Combine

/// SearchLocation을 위한 LocationManager
class SearchLocationManager: NSObject, ObservableObject, MKMapViewDelegate, CLLocationManagerDelegate {
    // MARK: - Properties
    @Published var mapView: MKMapView = .init()
    @Published var manager: CLLocationManager = .init()
    
    // Search Bar Text
    @Published var searchText: String = ""
    var cancellable: AnyCancellable?
    @Published var fetchedPlaces: [MKPlacemark]?
    
    // User Location
    @Published var userLocation: CLLocation?
    
    // Final Location
    @Published var pickedLocation: CLLocation? {
        didSet {
            updateMapRegion(location: pickedLocation)
        }
    }
    
    @Published var pickedPlaceMark: MKPlacemark?
    
    
    override init() {
        super.init()
        // Setting Delegates
        manager.delegate = self
        mapView.delegate = self
        
        // Requesting Location Access
        manager.requestWhenInUseAuthorization()
        
        // Search Textfield Watching
        cancellable = $searchText
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink(receiveValue: { value in
                if value != "" {
                    self.fetchPlaces(value: value)
                } else {
                    self.fetchedPlaces = nil
                }
            })
    }
    
    // MARK: - Methods
    
    /// 위치 검색하기
    func fetchPlaces(value: String) {
        // MARK: Fetching places using MKLocalSearch & Async/Await
        Task {
            do {
                let request = MKLocalSearch.Request()
                request.naturalLanguageQuery = value.lowercased()
                
                // 현재 유저 위치 중심으로 검색(선택구현가능)
                // TODO: 현위치중심검색 여부 확정 짓고 집어넣기
                if let userLocation = self.userLocation {
                    request.region = MKCoordinateRegion(center: userLocation.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
                }
                
                // 위치검색 실행
                let response = try await MKLocalSearch(request: request).start()
                
                // TODO: 현위치중심검색 여부 확정 짓고 집어넣기2
                if let userLocation = self.userLocation {
                    // 가까운 순서대로 리스트
                    // 검색 결과를 유저 위치와의 거리에 따라 정렬
                    let sortedPlaces = response.mapItems.compactMap({ $0.placemark }).sorted {
                        guard let distance1 = $0.location?.distance(from: userLocation),
                              let distance2 = $1.location?.distance(from: userLocation) else {
                            return false
                        }
                        return distance1 < distance2
                    }
                    
                    // 메인 스레드에서 정렬된 결과 업데이트
                    await MainActor.run {
                        self.fetchedPlaces = sortedPlaces
                    }
                    
                } else {
                    // 그냥 검색결과 리스트 보여주기
                    await MainActor.run {
                        self.fetchedPlaces = response.mapItems.compactMap({ item -> MKPlacemark? in
                            return item.placemark
                        })
                    }
                }
            } catch {
                 // Handle Error
            }
        }
        print(value)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        // Handle error
    }
    
    /// 현재 유저 위치 구하기
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let currentLocation = locations.last else {
            print("유저 현재위치 못구함")
            return
        }
        self.userLocation = currentLocation
        print("유저 위치 구함!")
    }
    
    /// Location Authorization
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedAlways: manager.requestLocation()
        case .authorizedWhenInUse: manager.requestLocation()
        case .denied: handleLocationError()
        case .notDetermined: manager.requestWhenInUseAuthorization()
        default: ()
        }
    }
    
    func handleLocationError() {
        // Handle error
    }
    
    /// Add Pin to MapView
    func addPin(at coordinate: CLLocationCoordinate2D) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        mapView.addAnnotation(annotation)
    }
    
    /// Annotation 위치 표시
    func mapView(_ mapView: MKMapView, viewFor annotation: any MKAnnotation) -> MKAnnotationView? {
        let marker = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "DELIVERYPIN")
        marker.canShowCallout = false
        
        return marker
    }
    
    /// 지도 탭하는 곳으로 선택 위치 업데이트하기
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let tappedLocatioin = view.annotation?.coordinate else { return }
        
        // Update the picked location
        self.pickedLocation = CLLocation(latitude: tappedLocatioin.latitude, longitude: tappedLocatioin.longitude)
        
        // Clear existing annotations and add a new one
        mapView.removeAnnotations(mapView.annotations)
        addPin(at: tappedLocatioin)
        
        // Update placemark for the new location
        updatePlacemark(location: CLLocation(latitude: tappedLocatioin.latitude, longitude: tappedLocatioin.longitude))
        
    }
    
    // Location 객체 바탕으로 placemark 업데이트
    func updatePlacemark(location: CLLocation) {
        Task {
            do {
                // MKPlacemark
                guard let place = try await reverseLocationCoordinates(location: location) else { return }
                await MainActor.run {
                    self.pickedPlaceMark = place
                }
            } catch {
                // handle error
            }
        }
    }
    
    func updatePlacemark(placemark: MKPlacemark) {
        self.pickedPlaceMark = placemark
    }
    
    func updateLocationAndPlacemark(coordinate: CLLocationCoordinate2D) {
        self.pickedLocation = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        mapView.removeAnnotations(mapView.annotations)
        addPin(at: coordinate)
        updatePlacemark(location: CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude))
    }

    
    /// placemark name으로 검색해서 조금이라도 더 명확한 이름 가진 placemark 찾기
    func findAccurateName(of placemark: CLPlacemark) async -> MKPlacemark? {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = placemark.name
        request.region = MKCoordinateRegion(center: placemark.location!.coordinate, latitudinalMeters: 5, longitudinalMeters: 5)

        do {
            let response = try await MKLocalSearch(request: request).start()
            let places = response.mapItems
            let closestPlace = places.min(by: {
                ($0.placemark.location?.distance(from: placemark.location ?? CLLocation()) ?? Double.greatestFiniteMagnitude) <
                ($1.placemark.location?.distance(from: placemark.location ?? CLLocation()) ?? Double.greatestFiniteMagnitude)
            })
            return closestPlace?.placemark
        } catch {
            print("Error searching for places: \(error)")
            return nil
        }
    }
    
    
    // MARK: Displaying New Location Data
    // 리버스 지오코딩 -> 장소 이름 조금 더 정확하게 검색 -> return MKPlacemark
    func reverseLocationCoordinates(location: CLLocation) async throws -> MKPlacemark? {
        guard let clplace = try await CLGeocoder().reverseGeocodeLocation(location).first else {
            print("reverseGeocodeLocation 실패")
            return nil
        }
        
        if let mkplace = await findAccurateName(of: clplace) {
            return mkplace
        } else {
            print("MKPlacemark 생성 실패")
            return nil
        }
    }
    
    /// 지도 focus 이동하기
    func updateMapRegion(location: CLLocation?) {
        guard let location = location else { return }
        let region = MKCoordinateRegion(center: location.coordinate, span: mapView.region.span)
        mapView.setRegion(region, animated: true)
    }
}

