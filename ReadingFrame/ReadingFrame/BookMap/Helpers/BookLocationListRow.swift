//
//  BookLocationListRow.swift
//  ReadingFrame
//
//  Created by 석민솔 on 7/3/24.
//

import SwiftUI

struct BookLocationListRow: View {
    let locationInfo: LocationInfo
    
    /// 책갈피 or 대표위치 아이콘
    var locationType: LocationType {
        locationInfo.locationType
    }
    
    /// 책제목
    var bookTitle: String {
        locationInfo.bookTitle
    }
    
    /// 기록 날짜
    var date: String {
        locationInfo.date
    }
    
    /// (책갈피에만) 기록된 페이지
    var readPage: Int? {
        locationInfo.readPage
    }
    
    /// 장소 이름(대표 주소 이름)
    var placeName: String {
        locationInfo.placeName
    }
    
    /// 마커랑 연결하기 위한 ID
    var placeID: Int {
        locationInfo.id
    }
    
    var body: some View {
        VStack {
            HStack(alignment: .center, spacing: 0) {
                // 책갈피 or 대표위치 아이콘
                Image(systemName: locationType == .bookmark ? "bookmark.fill" : "book.fill")
                    .foregroundStyle(locationType == .bookmark ? Color.green : Color.yellow)
                    .font(.title)
                    .scaledToFit()
                    .frame(width: 32, height: 32)
                
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 5) {
                        // 제목
                        Text(bookTitle)
                            .font(.thirdTitle)
                        
                        // 기록된 페이지 | 위치 이름(place name)
                        HStack(alignment: .center, spacing: 3) {
                            // 책갈피일 경우, 기록된 페이지 보여주기
                            if let readPage = self.readPage {
                                Text("\(String(readPage))p")
                                    .font(.footnote)
                                    .fontWeight(.semibold)
                                Text("|")
                                    .font(.footnote)
                            }
                            Text(placeName)
                                .font(.footnote)
                                .foregroundStyle(Color.greyText)
                        }
                    }
                    .padding(.leading, 10)
                    
                    Spacer()
                    
                    // 날짜
                    Text(date)
                        .font(.caption)
                        .foregroundStyle(Color.greyText)
                }
            }
            .padding(16)
            
            Divider() // TODO: VStack 말고 리스트로 구현하게 되면 빼주기
        }
    }
}

#Preview {
    ZStack {
        Color.blue.opacity(0.3)
            .ignoresSafeArea()
        
            BookLocationListRow(locationInfo: LocationInfo(locationType: .main, bookTitle: "천 개의 파랑", date: "2023.11.02", readPage: nil, placeName: "서울여자대학교 도서관", id: 3))
            .background(Color.white)
    }
}
