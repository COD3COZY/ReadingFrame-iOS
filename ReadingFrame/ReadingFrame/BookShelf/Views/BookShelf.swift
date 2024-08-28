//
//  BookShelf.swift
//  ReadingFrame
//
//  Created by 석민솔 on 7/24/24.
//

import SwiftUI

struct BookShelf: View {
    // MARK: - Properties
    /// 서재 정렬 어떤 타입으로 할건지(책 종류별, 독서상태별, 장르별)
    @Binding var bookshelfType: BookshelfType
        
    // 책장 이름
    var bookshelfNames: [String] {
        switch bookshelfType {
        case .booktype:
            ["종이책", "전자책", "오디오북"]
        case .readingStatus:
            ["읽고싶은", "읽는 중", "다 읽음"]
        case .genre:
            ["인문사회", "문학", "에세이", "과학", "자기계발", "예술", "원서", "기타"]
        }
    }
    
    /// 각 책장별 책의 개수
    let categoryCount: [Int] = [15, 0, 37, 23, 4, 15, 36, 25]
    
    /// 각 책장에 꽃혀있는 책이 몇 페이지인지 저장하는 배열
    /// 1. 읽고싶은(3권): 200, 150, 230 / 읽는중(1권): 300 / 다읽음(2권): 130, 150 이라면
    /// 2. [[200, 150, 230], [300], [130, 150]]
    let totalPages: [[Int]]
    
    
    // MARK: - View
    var body: some View {
        ScrollView {            
            ForEach(bookshelfNames.indices, id: \.self) { index in
                
                VStack {
                    HStack {
                        // 책장이름
                        Text(bookshelfNames[index])
                        
                        // 해당 책 개수
                        Text(String(categoryCount[index]))
                            .fontDesign(.rounded)
                            .fontWeight(.bold)
                        
                        Spacer()
                        
                        // 버튼-화면연결 chevron
                        NavigationLink {
                            BookShelfListByType()
                        } label: {
                            Image(systemName: "chevron.right")
                                .foregroundStyle(Color.black0)
                                .fontWeight(.semibold)

                        }
                    }
                    .padding()
                    
                    // 책 꽃혀있는 책장 부분
                    BookShelfView(categoryCount: categoryCount[index], totalPages: mapPageWidths(totalPages: totalPages[index]))
                }
                .padding(.bottom, 25)
                
            }
        }
    }
}

#Preview {
    BookShelf(bookshelfType: .constant(.genre), totalPages: [
        [150, 200, 200],    // 인문사회
        [300, 250, 250],    // 문학
        [300, 300, 200],    // 에세이
        [150, 200, 200],    // 과학
        [150, 200, 200],    // 자기계발
        [150, 200, 200],    // 예술
        [150, 200, 200],    // 원서
        [150, 200, 200]     // 기타
    ])
}

// MARK: - Function
extension BookShelf {
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
