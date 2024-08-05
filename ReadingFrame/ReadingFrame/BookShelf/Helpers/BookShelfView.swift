//
//  BookShelfView.swift
//  ReadingFrame
//
//  Created by 석민솔 on 7/24/24.
//

import SwiftUI

struct BookShelfView: View {
    // MARK: - Properties

    // TODO: 환경설정에서 가져와야 함. 아마도 UserDefaults에 저장시켜두고 가져와서 사용할 것 같음
    // 참고용ex. let appleIdentifier = UserDefaults.standard.string(forKey: "appleUID")
    /// 책장 색상
    let shelfColor = Color.main
    
    /// 책장 바닥 색상
    let floorColor = Color(red: 0.3, green: 0.2, blue: 0)
    
    /// 책장에 꽃여있을 책 개수
    let categoryCount: Int
    
    @State var rowCounts: [Int] = []
    
    /// 각 책당 몇페이지짜리의 책인지만 있는 배열
    // 일단 더미값 넣어둠
    var pageWidths: [CGFloat] {
        // 랜덤 페이지값
        var randomInts: [Int] = []
        for _ in 0..<categoryCount {
            randomInts.append(Int.random(in: 100...400))
        }
        
        // 책 한권 width에 해당하는 값으로 바꾼 배열
        let pages: [CGFloat] = randomInts.map { value in
            switch value {
            case 0...199:
                return 15
            case 200...299:
                return 20
            case 300...399:
                return 30
            case 400...499:
                return 40
            case 400...799:
                return 50
            default:
                return 80
            }
        }
        return pages
    }
    
    /// 책 한 권의 높이를 이 중에 랜덤으로 선택하기 위한 배열
    let pageHeights: [CGFloat] = [90, 95, 100, 105, 110]
    
    /// 책들만 있는 레이아웃 크기 측정을 위한 변수
    @State private var contentHeight: CGFloat = 0
    
    
    
    // MARK: - View
    var body: some View {
        // 참고용 wrap layout 예제
        VStack(alignment: .leading, spacing: 0) {
                
                ZStack(alignment: .top) {
                    
                    // MARK: 책장 바닥 UI only
                    VStack(spacing: 0) {
                        // 0권부터 1줄까지
                        if contentHeight < 120 {
                            Rectangle()
                                .frame(width: .infinity, height: 10)
                                .foregroundStyle(floorColor)
                                .padding(.top, 110)

                        // 서가 2줄 이상부터 여기로 적용됨
                        } else {
                            ForEach(0..<Int(contentHeight / 120), id: \.self) { index in
                                Rectangle()
                                    .frame(width: .infinity, height: 10)
                                    .foregroundStyle(floorColor)
                                    .padding(.top, index == 0 ? 110 : 130)
                            }
                        }
                    }
                    
                    // MARK: 책들 UI only
                    // 레이아웃 사용해서 책들 줄바꿈
                    WrapLayout(alignment: .bottom, horizontalSpacing: 0, verticalSpacing: 30, isForBookshelf: true) {
                        ForEach(Array(pageWidths.enumerated()), id: \.offset) { index, width in
                            VStack(spacing: 0) {
                                // 책 한 권용 사각형 모양
                                RoundedRectangle(cornerRadius: 2)
                                    .frame(
                                        width: width, // 페이지수 따라서 달라질 두께
                                        height: pageHeights.randomElement() ?? 100
                                    )
                                    .foregroundColor(shelfColor)
                                // 구분되도록 투명도 번갈아가면서 연하게-진하게
                                    .opacity(index % 2 == 0 ? Double.random(in: 0.3...0.4) : Double.random(in: 0.5...1.0))
                                
                                
                            }
                        }
                    }
                    // bookshelfLayout 자체 height 측정용
                    .background(GeometryReader { geometry in
                        Color.clear
                            .preference(key: HeightPreferenceKey.self, value: geometry.size.height)
                    })
                    .onPreferenceChange(HeightPreferenceKey.self) { height in
                        self.contentHeight = height
                    }
                }
        }
    }
}

#Preview {
    BookShelfView(categoryCount: 50)
}


struct HeightPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = max(value, nextValue())
    }
}
