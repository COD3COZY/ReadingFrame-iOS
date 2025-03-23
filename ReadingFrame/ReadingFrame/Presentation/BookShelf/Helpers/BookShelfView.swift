//
//  BookShelfView.swift
//  ReadingFrame
//
//  Created by 석민솔 on 7/24/24.
//

import SwiftUI

/// 책 페이지 따라서 책등이랑 나무판만 있는 서가 UI
struct BookShelfView: View {
    // MARK: - Properties
    /// 책장 색상
    let shelfColor: ThemeColor
    
    /// 책장 바닥 색상
    let floorColor = Color(red: 0.3, green: 0.2, blue: 0)
    
    /// 각 책당 몇페이지짜리의 책인지 저장하는 배열
    let totalPages: [Int]
    
    /// 책 한 권의 높이를 이 중에 랜덤으로 선택하기 위한 배열
    let pageHeights: [CGFloat] = [90, 95, 100, 105, 110]
    
    /// 책 UI에 보여줄 때의 크기 계산해서 저장하는 배열
    var pageWidths: [CGFloat] {
        mapPageWidths(totalPages: self.totalPages)
    }
    
    /// 책들만 있는 레이아웃 크기 측정을 위한 변수
    @State private var contentHeight: CGFloat = 0
    
    
    
    // MARK: - View
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ZStack(alignment: .top) {
                // MARK: 책장 바닥 UI only
                VStack(spacing: 0) {
                    // 0권부터 1줄까지
                    if contentHeight <= 110 {
                        floorRectangle
                            .padding(.top, 110)
                    // 서가 2줄 이상부터 여기로 적용됨
                    } else {
                        ForEach(0..<Int((contentHeight + 20) / 130), id: \.self) { index in
                            Color.clear
                                .frame(height: index == 0 ? 110 : 130)
                            
                            floorRectangle
                        }
                    }
                }
                
                // MARK: 책들 UI only
                if totalPages.count == 0 {
                    // 서가에 책이 없을 때
                    Text("책을 추가하면 서가에 책이 꽂혀요📚")
                        .frame(maxWidth: .infinity, maxHeight: 110, alignment: .center)
                        .opacity(0.5)
                } else {
                    // 서가에 책이 있을 때
                    WrapLayout(alignment: .bottom, horizontalSpacing: 0, verticalSpacing: 30, isForBookshelf: true) {
                        // 책 한 권 한 권 만들어주는 반복문
                        ForEach(Array(pageWidths.enumerated()), id: \.offset) { index, width in
                            VStack(spacing: 0) {
                                // 책 한 권용 사각형 모양
                                RoundedRectangle(cornerRadius: 2)
                                    .frame(
                                        width: width, // 페이지수 따라서 달라질 두께
                                        height: pageHeights.randomElement() ?? 100
                                    )
                                    .foregroundColor(shelfColor.color)
                                // 구분되도록 투명도 번갈아가면서 연하게-진하게
                                    .opacity(index % 2 == 0 ? Double.random(in: 0.3...0.4) : Double.random(in: 0.5...1.0))
                                
                                
                            }
                        }
                    }
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
}

#Preview {
    BookShelfView(
        shelfColor: .main,
        totalPages: [200, 400, 300, 200, 300, 200, 150, 200, 200, 150, 150, 200, 300, 200, 150, 200, 300]
    )
}


struct HeightPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = max(value, nextValue())
    }
}

extension BookShelfView {
    // MARK: - View Parts
    /// 서가 바닥용 나무판 rectangle UI 요소
    private var floorRectangle: some View {
        Rectangle()
            .frame(width: UIScreen.main.bounds.width, height: 10)
            .foregroundStyle(floorColor)
    }
    
    // MARK: - Methods
    /// 책 페이지 수에 따라 UI에 반영될 책 한 권의 너비 계산해주는 함수
    func mapPageWidths(totalPages: [Int]) -> [CGFloat] {
        // 책 한권 width에 해당하는 값으로 바꾼 배열
        let pages: [CGFloat] = totalPages.map { value in
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
}
