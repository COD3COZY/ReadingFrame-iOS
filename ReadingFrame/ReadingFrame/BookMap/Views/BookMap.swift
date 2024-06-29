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
    
    var annotations : [Location] {
        return bookMapVM.locations
    }

    // MARK: - 뷰
    var body: some View {
        ZStack {
            mapLayer
//                .ignoresSafeArea()
                .tint(.accentColor)
            
            // TODO: 책위치정보 List 띄우기
            
            VStack {
                Spacer()
                moveCurrentLocationButton
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding()
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

