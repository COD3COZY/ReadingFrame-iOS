//
//  BookLocationListView.swift
//  ReadingFrame
//
//  Created by 석민솔 on 7/3/24.
//

import SwiftUI

struct BookLocationListView: View {
    @State var locationInfos: [LocationInfo] = BookLocationData.locationInfos
    
    var body: some View {
        VStack {
            ScrollView {
            Text("최근 읽은")
                .font(.headline)
                .padding(.top, 16)
                .padding(.bottom, 16)
            
                LazyVStack {
                    ForEach(locationInfos) { locationInfo in
                        BookLocationListRow(locationInfo: locationInfo)
                        // TODO: 누르면 지도랑 연동시켜서 위치 이동하기
                    }
                    
                    // TODO: 더보기 버튼 추가
                }
            }
            // TODO: 일단 hidden으로 숨겨놓고 나중에 필요할 것 같으면 보이도록 바꾸기
            .scrollIndicators(.hidden)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
}


// MARK: - Preview: sheet 형태로 확인 시 필요
struct ForButtonPreview: View {
    @State private var viewPresented: Bool = false
    
    var body: some View {
        Button {
            viewPresented.toggle()
        } label: {
            Text("최근 읽은 리스트 띄우기")
        }
        .sheet(isPresented: $viewPresented) {
            BookLocationListView()
        }
    }
}

struct BookLocationListView_Previews: PreviewProvider {
    static var previews: some View {
        ForButtonPreview()
    }
}
