//
//  BookShelfViewModel.swift
//  ReadingFrame
//
//  Created by 석민솔 on 3/22/25.
//

import Foundation
import Alamofire

class BookShelfViewModel: ObservableObject {
    // MARK: - Properties
    /// 서재 정렬 어떤 타입으로 할건지 분류기준(책 종류별, 독서상태별, 장르별)
    @Published var bookshelfSort: BookshelfSort
    
    /// 핵심데이터: 각 책장에 꽃혀있는 책이 몇 페이지인지 저장하는 배열
    /// 1. 읽고싶은(3권): 200, 150, 230 / 읽는중(1권): 300 / 다읽음(2권): 130, 150 이라면
    /// 2. [[200, 150, 230], [300], [130, 150]]
    @Published var totalPages: [[Int]]?
    
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
    
    /// UserDefault에 저장된 책장 테마색상
    var bookshelfColor: ThemeColor {
        if let themeColor = UserDefaults.standard.string(forKey: "ThemeColor") {
            ThemeColor(rawValue: themeColor) ?? .main
        } else {
            .main
        }
    }
    
    // MARK: - init
    init(_ bookshelfSort: BookshelfSort) {
        self.bookshelfSort = bookshelfSort
        fetchBookshelfData(type: bookshelfSort) { isSuccess in
            if !isSuccess {
                print("책장 데이터 조회 실패")
            }
        }
    }
    
    // MARK: - Methods
    /// bookshelfSort 업데이트 함수
    func updateBookshelfSort(_ newSort: BookshelfSort) {
        if bookshelfSort != newSort {
            fetchBookshelfData(type: newSort) { isSuccess in
                if isSuccess {
                    print("책장 데이터 조회 성공: \(newSort)")
                    self.bookshelfSort = newSort
                } else {
                    print("책장 데이터 조회 실패")
                }
            }
        }
    }
    
    /// 책장 초기 조회 API 호출
    func fetchBookshelfData(type: BookshelfSort, completion: @escaping (Bool) -> (Void)) {
        let bookshelfType: String = String(type.rawValue)
        var tempTotalPages: [[Int]] = []
        
        BookshelfAPI.shared.getBookshelf(type: bookshelfType) { response in
            switch response {
            case .success(let data):
                if let categories = data as? [BookshelfCategoryResponse] {
                    for categoryData in categories {
                        tempTotalPages.append(categoryData.totalPage)
                    }
                    
                    self.totalPages = tempTotalPages
                }
                completion(true)
                
            case .requestErr(let message):
                print("Request Err: \(message)")
                completion(false)
            case .pathErr:
                print("Path Err")
                completion(false)
            case .serverErr(let message):
                print("Server Err: \(message)")
                completion(false)
            case .networkFail(let message):
                print("Network Err: \(message)")
                completion(false)
            case .unknown(let error):
                print("Unknown Err: \(error)")
                completion(false)
            }
        }
    }
}
