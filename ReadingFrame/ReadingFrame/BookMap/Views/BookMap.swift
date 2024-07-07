//
//  BookMap.swift
//  ReadingFrame
//
//  Created by 석민솔 on 2/13/24.
//

import SwiftUI
import MapKit

struct BookMap: View {
    @StateObject private var bookMapVM = BookMapViewModel()
    
    /// 책지도 bottomsheet용
    @State private var showSheet: Bool = false
    
    var annotations : [Location] {
        return bookMapVM.locations
    }
    
    var selectedLocationInfo: LocationInfo? {
        bookMapVM.selectedLocationInfo
    }

    // MARK: - 뷰
    var body: some View {
        ZStack {
            mapLayer
                .tint(.accentColor)
            
                        
            VStack {
                Text("책 지도")
                    .font(.headline)
                    .frame(maxWidth: .infinity, maxHeight: 40, alignment: .center)
                    .background(.white)
                
                // TODO: 선택해제 방법 찾아서 대체하기
                // 선택해제 임시버튼
                Button {
                    bookMapVM.deactivateAll()
                } label: {
                    Text("선택해제")
                        .padding(15)
                        .background(
                            RoundedRectangle(cornerRadius: 30)
                                .foregroundStyle(Color.white)
                        )
                }
                
                Spacer()
                
                moveCurrentLocationButton
                    .padding(.bottom, 60)
                    .padding(.trailing, 14)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
        // 책위치정보List bottom sheet 부분
        .task {
            // BookMap 열릴 때 sheet도 같이 보이도록
            showSheet = true
        }
        .onDisappear() {
            // BookMap 사라질 때 sheet도 없애기
            showSheet = false
        }
        .sheet(isPresented: $showSheet) {
            BookLocationListView(selectedLocationInfo: $bookMapVM.selectedLocationInfo)
                .padding(.top, 16)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                // TODO: modal 크기 안정화
                // 선택된 게 있으면 modal 크기 100으로 보여주도록 설정
                // 선택된 게 없으면 modal 크기 다양하게 보여주도록 설정
                .presentationDetents(selectedLocationInfo != nil ? [.height(100), .large] : [.height(45), .medium, .large])
                .presentationCornerRadius(20)
                .presentationBackground(
                    .white
                )
                .presentationBackgroundInteraction(.enabled(upThrough: .large))
                .interactiveDismissDisabled()
                .bottomMaskForSheet() // 탭바 위에 sheet 뜨도록 함
                .onChange(of: bookMapVM.selectedLocationInfo) { oldValue, newValue in
                    // 리스트에서 LocationInfo 선택되면 지도상에도 반영하기
                    if let locationInfo = selectedLocationInfo {
                        bookMapVM.moveSelectLocation(id: locationInfo.id)
                    }
                }
        }
    }
}

extension BookMap {
    private var mapLayer: some View {
        Map(coordinateRegion: $bookMapVM.mapRegion,
            showsUserLocation: true,
            userTrackingMode: .none,
            annotationItems: bookMapVM.locations,
            annotationContent: { location in
            MapAnnotation(coordinate: location.coordinates) {
                AnnotationView(type: location.locationType, isSelected: bookMapVM.selectedLocation == location)
                    .onTapGesture {
                        // 지도 위치 이동
                        withAnimation {
                            bookMapVM.movetoSelectLocation(location: location)
                            // 리스트에서 id가 동일한 항목 선택
                            bookMapVM.selectedLocationInfo = BookLocationData.locationInfos.first(where: { $0.id == location.id })
                        }
                    }
            }
        })

    }
    
    private var moveCurrentLocationButton: some View {
        Button(action: {
            bookMapVM.movetoCurrentLocation()
        }, label: {
            Image("Ic-bookmap-target")
                .font(.title2)
                .padding(10)
                .background(Color.white)
                .clipShape(Circle())
        })

    }
}

#Preview {
    BookMap()
}
