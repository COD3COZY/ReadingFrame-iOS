//
//  BookLocationListView.swift
//  ReadingFrame
//
//  Created by 석민솔 on 7/3/24.
//

import SwiftUI

struct BookLocationListView: View {
    @State var locationInfos: [LocationInfo] = BookLocationData.locationInfos
    
    /// 선택된 한 개의 위치정보
    @Binding var selectedLocationInfo: LocationInfo?
    
//    /// sheet 크기 결정용 변수
//    @State var sheetSize: PresentationDetent
//    
//    func updateSheetSize(to newSize: PresentationDetent) {
//        sheetSize = newSize
//    }
    
    var body: some View {
        VStack {
            if let selectedLocation = selectedLocationInfo {
                BookLocationListRow(locationInfo: selectedLocation)
            } else {
                locationList
            }
        }
//        .presentationDetents([sheetSize])
//        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
}

extension BookLocationListView {
    private var locationList: some View {
        ScrollView {
        Text("최근 읽은")
            .font(.headline)
            .padding(.top, 16)
            .padding(.bottom, 16)
        
            LazyVStack {
                ForEach(locationInfos) { locationInfo in
                    BookLocationListRow(locationInfo: locationInfo)
                        .onTapGesture {
                            // 특정 위치정보 선택
                            withAnimation {
                                self.selectedLocationInfo = locationInfo
                            }
                        }
                }
                
                // TODO: 더보기 버튼 추가
            }
        }
        // TODO: 일단 hidden으로 숨겨놓고 나중에 필요할 것 같으면 보이도록 바꾸기
        .scrollIndicators(.hidden)
    }
}


//// MARK: - Preview: sheet 형태로 확인 시 필요
//struct ForButtonPreview: View {
//    @State private var viewPresented: Bool = false
//    
//    var body: some View {
//        Button {
//            viewPresented.toggle()
//        } label: {
//            Text("최근 읽은 리스트 띄우기")
//        }
//        .sheet(isPresented: $viewPresented) {
//            BookLocationListView( selectedLocationInfo: $nil)
//        }
//    }
//}
//
//struct BookLocationListView_Previews: PreviewProvider {
//    static var previews: some View {
//        ForButtonPreview()
//    }
//}
