//
//  BookShelf.swift
//  ReadingFrame
//
//  Created by 석민솔 on 7/24/24.
//

import SwiftUI

struct BookShelf: View {
    // MARK: - Properties
    /// 서재 정렬 어떤 타입으로 할건지 분류기준(책 종류별, 독서상태별, 장르별)
    @Binding var bookshelfSort: BookshelfSort
    
    /// bookshelfType에 따라서 결정되는 서가들
    var bookshelfType: [BookEnum] {
        switch bookshelfSort {
        // 책종류별(종이책, 전자책, 오디오북)
        case .booktype:
            BookType.allCases as [BookType]
        // 독서상태별(읽고싶은, 읽는중, 다읽은)
        case .readingStatus:
            [ReadingStatus.wantToRead, ReadingStatus.reading, ReadingStatus.finishRead] as [ReadingStatus]
        // 장르별(인문사회, 문학, 에세이, 과학, 자기계발, 예술, 원서, 기타)
        case .genre:
            CategoryName.allCases as [CategoryName]
        }
    }
        
    // TODO: API 호출받은 값으로 입력하도록 수정하기
    // API 호출 전에 일단 함수로 서가 개수에 맞는 랜덤 배열 만들어서 할당시켜두었습니다
    /// 각 책장에 꽃혀있는 책이 몇 페이지인지 저장하는 배열
    /// 1. 읽고싶은(3권): 200, 150, 230 / 읽는중(1권): 300 / 다읽음(2권): 130, 150 이라면
    /// 2. [[200, 150, 230], [300], [130, 150]]
    @State var totalPages: [[Int]] = BookShelf.temp_randomTotalPage()
    
    
    // MARK: - View
    var body: some View {
        ScrollView {            
            ForEach(bookshelfType.indices, id: \.self) { index in
                
                let currentBookshelf = bookshelfType[index]
                
                VStack {
                    HStack {
                        // 책장이름
                        Text(currentBookshelf.name)
                        
                        // 해당 책 개수
                        Text(String(totalPages[index].count))
                            .fontDesign(.rounded)
                            .fontWeight(.bold)
                        
                        Spacer()
                        
                        // 버튼-화면연결 chevron
                        NavigationLink {
                            BookShelfListByType(bookshelfSubtype: currentBookshelf)
                                .toolbarRole(.editor) // back 텍스트 표시X
                        } label: {
                            Image(systemName: "chevron.right")
                                .foregroundStyle(Color.black0)
                                .fontWeight(.semibold)

                        }
                    }
                    .padding()
                    
                    // 책 꽃혀있는 책장 부분
                    BookShelfView(totalPages: totalPages[index])
                }
                .padding(.bottom, 25)
                
            }
        }
        .onChange(of: bookshelfSort) { oldValue, newValue in
            // TODO: 책장 보기 타입 변화에 맞춰서 책장 초기조회 API 호출
            totalPages = BookShelf.temp_randomTotalPage(newValue)
        }
    }
}

#Preview {
    BookShelf(bookshelfSort: .constant(.genre))
}

// MARK: - Function
extension BookShelf {
    // TODO: API 호출 구현하면 없애기!
    /// 서가 개수에 따라 랜덤으로 totalPage 배열 만들어주는 함수
    static func temp_randomTotalPage(_ shelfType: BookshelfSort = .booktype) -> [[Int]] {
        print("temp_randomTotalPage() 호출")
        
        var totalPageArray: [[Int]] = []
        
        // 서가 개수
        var shelfCount: Int {
            switch shelfType {
            // 책유형/독서상태별일 때는 3개
            case .booktype, .readingStatus:
                return 3
            // 장르별일 때 8개
            case .genre:
                return 8
            }
        }
        
        // 서가 개수만큼 반복
        for i in 1...8 {
            var tempArray: [Int] = []
            if i <= shelfCount {
                // 책 개수만큼 반복
                for _ in 1...Int.random(in: 5...50) {
                    // 랜덤 페이지 추가
                    tempArray.append(Int.random(in: 80...400))
                }
                totalPageArray.append(tempArray)
            } else {
                // fatal error 방지용. 서가 3개일 때도 0 배열들로 8개 배열 개수 맞추기
                tempArray.append(0)
                totalPageArray.append(tempArray)
            }
        }
        print(totalPageArray)
        return totalPageArray
    }
}
