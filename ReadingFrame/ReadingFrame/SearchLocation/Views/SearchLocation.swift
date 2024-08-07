//
//  SearchLocation.swift
//  ReadingFrame
//
//  Created by 석민솔 on 2/14/24.
//

import SwiftUI
import MapKit

/// 위치검색 화면
/// - 불러낼 때 pickedPlacemark Binding으로 불러내서 선택한 위치 정보 전달받으면 됩니다~
struct SearchLocation: View {
    // MARK: - Properties
    @StateObject var locationManager: SearchLocationManager = .init()
    
    /// SearchLocation(현재 화면) 모달 취소 버튼 누르면 없어지도록 하기 위한 변수
    @Binding var showingSearchLocation: Bool
    
    /// 위치 선택 모달 띄우기 위한 변수
    @State private var showingMapViewSelection = false
    
    /// 부모 뷰에 선택위치 전달해주기 위한 변수
    @Binding var pickedPlaceMark: MKPlacemark?
    
    
    // MARK: - body
    var body: some View {
        VStack {
            // 위치 검색 박스
            locationSearchBox
                .padding(.bottom, 10)
            
            List {
                // MARK: 현재 위치
                currentLocationRowButton
                
                // MARK: 위치검색결과 리스트
                if let places = locationManager.fetchedPlaces, !places.isEmpty {
                    Section("지도 위치") {
                        ForEach(places, id: \.self) { place in
                            Button {
                                // Setting Map Region
                                if let coordinate = place.location?.coordinate {
                                    locationManager.pickedLocation = .init(latitude: coordinate.latitude, longitude: coordinate.longitude)
                                    locationManager.mapView.region = .init(center: coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
                                    locationManager.addPin(at: coordinate)
                                    locationManager.updatePlacemark(placemark: place)
                                }
                                
                                // Navigating to MapView
                                showingMapViewSelection = true
                                
                            } label: {
                                VStack(alignment: .leading, spacing: 6.0) {
                                    // 장소 이름
                                    Text(place.name ?? "")
                                        .font(.headline)
                                        .foregroundStyle(Color.black)
                                    // 주소
                                    Text(place.title ?? "")
                                        .font(.caption)
                                        .foregroundStyle(Color.gray)
                                }
                            }
                        }
                    }
                }
                // MARK: 최근 검색 위치 리스트
                else if var recentLocations = RecentLocationData.locations, !recentLocations.isEmpty {
                    Section("최근 위치") {
                        ForEach(recentLocations) { place in
                            Button {
                                // Setting Map Region
                                let coordinate = place.coordinate
                                locationManager.pickedLocation = .init(latitude: coordinate.latitude, longitude: coordinate.longitude)
                                locationManager.mapView.region = .init(center: coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
                                locationManager.addPin(at: coordinate)
                                locationManager.updatePlacemark(location: .init(latitude: coordinate.latitude, longitude: coordinate.longitude))
                                
                                
                                // Navigating to MapView
                                showingMapViewSelection = true
                                
                            } label: {
                                VStack(alignment: .leading, spacing: 6.0) {
                                    // 장소 이름
                                    Text(place.placeName)
                                        .font(.headline)
                                        .foregroundStyle(Color.black)
                                    // 주소
                                    Text(place.address)
                                        .font(.caption)
                                        .foregroundStyle(Color.gray)
                                }
                            }
                            // 리스트에서 이미지 모양으로 밀어서 없애기
                            .swipeActions(edge: .trailing) {
                                Button(role: .destructive) {
                                    // UI상에서 없애기
                                    if let index = RecentLocationData.locations?.firstIndex(where: { $0.id == place.id }) {
                                        print("index: \(index)")
                                        withAnimation {
                                            recentLocations.remove(at: index)
                                            RecentLocationData.locations?.remove(at: index)
                                        }
                                    }
                                    
                                    // TODO: API 최근위치 삭제 호출하기
                                } label: {
                                    Image(systemName: "trash.fill")
                                }
                                .tint(.red)
                            }
                        }
                        .onDelete { IndexSet in
                            print("onDelete")
                            recentLocations.remove(atOffsets: IndexSet)
                            RecentLocationData.locations?.remove(atOffsets: IndexSet)
                        }
                    }
                }
            }
            .listStyle(.plain)
            .padding(.leading, -10) // 리스트가 지나치게 왼쪽 여백이 많아서
            .padding(.trailing, -15) // delete 할 때 오른쪽이 붕떠서..^^
        }
        .padding()
        .frame(maxHeight: .infinity, alignment: .top)
        .navigationBarItems(trailing: Button("취소") {
            showingSearchLocation = false
        })
        .navigationBarTitle(Text("위치 검색"), displayMode: .inline)
        // SearchLocationMap sheet로 보여주기
        .sheet(isPresented: $showingMapViewSelection) {
            SearchLocationMap(showingSearchLocation: $showingSearchLocation, showingMapViewSelection: $showingMapViewSelection)
                .environmentObject(locationManager)
                .toolbarRole(.editor)
        }
        .onDisappear {
            // 페이지 닫힐 때 선택값 전달
            // MapViewSelection에서 확정한 위치가 있다면 그 위치로 입력, 없다면 비워서 전달
            if let pickedPlaceMark = locationManager.pickedPlaceMark {
                self.pickedPlaceMark = pickedPlaceMark
            } else {
                self.pickedPlaceMark = nil
            }
        }
    }
}

#Preview {
    SearchLocation(showingSearchLocation: .constant(true), pickedPlaceMark: .constant(nil))
}

extension SearchLocation {
    private var locationSearchBox: some View {
        HStack(spacing: 10) {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(Color.gray)
            
            TextField("위치", text: $locationManager.searchText)
        }
        .padding(.vertical, 12)
        .padding(.horizontal)
        .background(
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .foregroundStyle(Color(red: 0.96, green: 0.96, blue: 0.96))
        )
    }
    
    private var currentLocationRowButton: some View {
        Button {
            // MARK: Setting Map Region
            if let coordinate = locationManager.userLocation?.coordinate {
                locationManager.mapView.region = .init(center: coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
                locationManager.addPin(at: coordinate)
                locationManager.updatePlacemark(location: .init(latitude: coordinate.latitude, longitude: coordinate.longitude))
                
                // MARK: Navigating to MapView
                showingMapViewSelection = true
            }
            
        } label: {
            HStack {
                // 유저 위치 안구해졌을 때는 버튼 disable 시키고 텍스트 옆에 로딩 표시
                if (locationManager.userLocation == nil) {
                    ProgressView()
                } else {
                    Image(systemName: "location.circle.fill")
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(.blue, Color(red: 209/255, green: 209/255, blue: 214/255))
                        .font(.title2)
                }
                Text("현재 위치")
                            
            }

        }
        .disabled(locationManager.userLocation == nil)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
