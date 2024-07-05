//
//  BookMap.swift
//  ReadingFrame
//
//  Created by 석민솔 on 2/13/24.
//

import SwiftUI

import SwiftUI
import MapKit

struct BookMap: View {
    @StateObject private var bookMapVM = BookMapViewModel()
    
    /// 책지도 bottomsheet용
    @State private var showSheet: Bool = false
    
    var annotations : [Location] {
        return bookMapVM.locations
    }

    // MARK: - 뷰
    var body: some View {
        ZStack {
            mapLayer
//                .ignoresSafeArea()
                .tint(.accentColor)
                        
            VStack {
                Text("책 지도")
                    .font(.headline)
                    .frame(maxWidth: .infinity, maxHeight: 40, alignment: .center)
                    .background(.white)
                
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
            BookLocationListView()
                .padding(.top, 16)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .presentationDetents([.height(45), .medium, .large])
                .presentationCornerRadius(20)
                .presentationBackground(
                    .white
                )
                .presentationBackgroundInteraction(.enabled(upThrough: .large))
                .interactiveDismissDisabled()
                .bottomMaskForSheet() // 탭바 위에 sheet 뜨도록 함
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
                        bookMapVM.movetoSelectLocation(location: location)
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
