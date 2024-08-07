//
//  SingleBookLocationInfoView.swift
//  ReadingFrame
//
//  Created by 석민솔 on 7/17/24.
//

import SwiftUI

struct SingleBookLocationInfoView: View {
    let bookInfo: LocationInfo
    
    var infoList: [(label: String, value: String?)] {
        [("날짜", bookInfo.date),
         ("페이지", bookInfo.readPage == nil ? nil : String(bookInfo.readPage!)),
         ("위치", bookInfo.placeName)]
    }
    
    @Binding var showSingleInfoView: Bool
    
    
    var body: some View {
        VStack(spacing: 0) {
            // TODO: SingleBookLocationInfoView에서는 네비게이션 버튼 빼는 거 논의하고 확정짓기
//            HStack {
//                // 최근 읽은 네비게이션 바
//                Button {
//                    // SingleInfoView직전 뷰로 넘어가도록
//                    showSingleInfoView = false
//                } label: {
//                    Image(systemName: "chevron.left")
////                    Text("최근 읽은")
//                }
//                
//                Spacer()
//            }
//            .padding(.bottom, 40)
            
            HStack {
                // 아이콘
                Image(systemName: bookInfo.locationType == .bookmark ? "bookmark.fill" : "book.fill")
                    .foregroundStyle(bookInfo.locationType == .bookmark ? Color.green : Color.yellow)
                    .font(.title)
                    .scaledToFit()
                    .frame(width: 32, height: 32)
                
                // 책 제목
                Text(bookInfo.bookTitle)
                    .font(.SecondTitle)
                
                Spacer()
            }
            .padding(.vertical, 20)
            
            // 정보 리스트
            List {
                ForEach(infoList, id: \.label) { info in
                    // 페이지 수 대표위치일 때는 없어서 안띄우도록
                    if let value = info.value {
                        HStack {
                            Text(info.label)
                            Spacer()
                            Text(value)
                        }
                    }
                }
            }
            .listStyle(.plain)
            .padding(.horizontal, -16)
        }
        .padding(.horizontal, 16)
        .onDisappear(perform: {
            showSingleInfoView = false
        })
    }
}

#Preview {
    SingleBookLocationInfoView(bookInfo: BookLocationData.locationInfos[2], showSingleInfoView: .constant(true))
}
