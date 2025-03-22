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
    
    /// 책지도 modal용
    @State private var showSheet: Bool = false
    
    /// modal 크기
    @State var detents: PresentationDetent = .height(45)
    

    // MARK: - 뷰
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                mapLayer
                    .tint(.accentColor)
                    .onTapGesture {
                        // annotation 외 지도 탭하면 선택해제
                        if !bookMapVM.isAnnotationSelected {
                            bookMapVM.deselectAll()
                        } else {
                            bookMapVM.isAnnotationSelected = false
                            print("selected false")
                        }
                    }
                
                
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
                BookmapSheetView(bookmapVM: bookMapVM, 
                                 detents: $detents,
                                 parentGeometrySize: geometry.size)
                    .padding(.top, 16)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                    // modal 크기
                    .presentationDetents(
                        // 한 row만 보이는 뷰일 때는 .height(100), .large만 남기도록
                        // 다른 뷰에서는 다양한 높이 지원
                        ((bookMapVM.foundInfoList == nil && bookMapVM.selectedLocation != nil) ? [.height(100), .large] : [.height(45), .fraction(1/3), .large]),
                        selection: $detents // 이 기특한 친구가 modal 크기 정해줌
                    )
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
}

extension BookMap {
    private var mapLayer: some View {
        // FIXME: deprecated 문제 해결하기..
        Map(coordinateRegion: $bookMapVM.mapRegion,
            showsUserLocation: true,
            userTrackingMode: .none,
            // annotation
            annotationItems: bookMapVM.locations,
            annotationContent: { location in
            MapAnnotation(coordinate: location.coordinates) {
                AnnotationView(type: location.locationType, isSelected: bookMapVM.selectedLocation == location)
                    .onTapGesture {
                        // MARK: annotation 탭했을 때 실행
                        self.bookMapVM.isAnnotationSelected = true
                        
                        // 0.1초 후에 isAnnotationSelected를 false로 설정
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            self.bookMapVM.isAnnotationSelected = false
                        }
                        
                        withAnimation {
                            // 지도 위치 이동
                            bookMapVM.movetoSelectLocation(location: location)
                            
                            // 위치에 맞는 리스트 띄우기
                            bookMapVM.findInfoList(by: location)
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
