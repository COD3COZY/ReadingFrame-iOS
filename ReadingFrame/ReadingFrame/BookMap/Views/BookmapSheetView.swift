//
//  BookmapSheetView.swift
//  ReadingFrame
//
//  Created by 석민솔 on 7/3/24.
//

import SwiftUI

/// 경우에 따라 sheet 형태로 보여줘야 할 정보 띄워주는 뷰
struct BookmapSheetView: View {
    @ObservedObject var bookmapVM: BookMapViewModel
    
    @State var showSingleInfoView: Bool = false
    
    @Binding var detents: PresentationDetent
    
    let parentGeometrySize: CGSize
    
    
//    /// sheet 크기 결정용 변수
//    @State var sheetSize: PresentationDetent
//    
//    func updateSheetSize(to newSize: PresentationDetent) {
//        sheetSize = newSize
//    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                // MARK: 1. SingleInfoView
                if let selectedLocationInfo = bookmapVM.selectedLocationInfo, showSingleInfoView {
                    SingleBookLocationInfoView(bookInfo: selectedLocationInfo, showSingleInfoView: $showSingleInfoView)
                        .task {
                            detents = .large
                        }
                        .onChange(of: geometry.size.height) {
                            // 1/3 이상 화면 작아지면 SingleInfoView 취소하고 이전 화면으로
                            if geometry.size.height < (parentGeometrySize.height / 3) {
                                withAnimation {
                                    showSingleInfoView = false
                                }
                            }
                        }
                    
                // MARK: 2. 위치별 리스트
                } else if bookmapVM.foundInfoList != nil {
                    foundLocationList
                        .task {
                            detents = .fraction(1/3)
                        }
                        .onChange(of: geometry.size.height) {
                            // 절반 이상 화면 커지면 SingleInfoView 보여주기
                            if bookmapVM.foundInfoList!.count == 1, geometry.size.height > (parentGeometrySize.height / 2) {
                                withAnimation {
                                    bookmapVM.selectedLocationInfo = bookmapVM.foundInfoList?.first!
                                    showSingleInfoView = true
                                }
                            }
                        }
                        .onChange(of: bookmapVM.foundInfoList) {
                            // 다른 위치 annotation 클릭해서 검색된 리스트가 바뀌면 다시 detents 1/3로 설정
                            detents = .fraction(1/3)
                        }
                    
                // MARK: 3. 리스트상 하나만 선택된 상태
                } else if let selectedLocation = bookmapVM.selectedLocationInfo {
                    BookLocationListRow(locationInfo: selectedLocation)
                        .task {
                            detents = .height(100)
                        }
                        .onChange(of: geometry.size.height) {
                            // 절반 이상 화면 커지면 SingleInfoView 보여주기
                            if geometry.size.height > (parentGeometrySize.height / 2) {
                                withAnimation {
                                    showSingleInfoView = true
                                }
                            }
                        }
                    
                // MARK: 4(초기). 최근 읽은 리스트
                } else {
                    recentLocationList
                        .task {
                            detents = .height(45)
                        }
                }
            }
        }
    }
}

extension BookmapSheetView {
    /// 최근 읽은 전체 리스트
    private var recentLocationList: some View {
        LazyVStack {
            Text("최근 읽은")
                .font(.headline)
                .padding(.top, 16)
                .padding(.bottom, 16)
            
            ScrollView {
                LazyVStack {
                    ForEach(Array(bookmapVM.recentlocationInfos.enumerated()), id: \.element.id) { index, locationInfo in
                        VStack(spacing: 0) {
                            BookLocationListRow(locationInfo: locationInfo)
                                .onTapGesture {
                                    // 특정 위치정보 선택
                                    withAnimation {
                                        bookmapVM.selectedLocationInfo = locationInfo
                                    }
                                }
                            if index < bookmapVM.recentlocationInfos.count - 1 {
                                Divider()
                            }
                        }
                    }
                    
                    // TODO: 더보기 버튼 추가
                }
            }
        }
        // TODO: 일단 hidden으로 숨겨놓고 나중에 필요할 것 같으면 보이도록 바꾸기
        .scrollIndicators(.hidden)
    }    
    
    /// 위치기반 검색 리스트
    private var foundLocationList: some View {
        LazyVStack {
            // TODO: placename 보여주는건 어떤감? 회의때 얘기해보고 정하기
            Text(bookmapVM.foundInfoList!.first!.placeName)
                .font(.headline)
                .padding(.top, 16)
            
            ScrollView {
                LazyVStack {
                    ForEach(Array(bookmapVM.foundInfoList!.enumerated()), id: \.element.id) { index, locationInfo in
                        VStack(spacing: 0) {
                            BookLocationListRow(locationInfo: locationInfo)
                                .onTapGesture {
                                    // foundInfoList 항목이 1개 초과일 경우, 탭하면 SingleInfoView 보기
                                    if bookmapVM.foundInfoList!.count > 1 {
                                        withAnimation {
                                            bookmapVM.selectedLocationInfo = locationInfo
                                            showSingleInfoView = true
                                        }
                                    }
                                }
                            if index < bookmapVM.foundInfoList!.count - 1 {
                                Divider()
                            }
                        }
                    }
                    
                    // TODO: 더보기 버튼 추가
                }
            }
        }
        // TODO: 일단 hidden으로 숨겨놓고 나중에 필요할 것 같으면 보이도록 바꾸기
        .scrollIndicators(.hidden)
    }
}
