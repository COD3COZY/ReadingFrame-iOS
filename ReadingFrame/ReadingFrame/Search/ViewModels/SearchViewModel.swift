//
//  SearchViewModel.swift
//  ReadingFrame
//
//  Created by 이윤지 on 12/22/24.
//

import Foundation

/// 검색 화면의 뷰모델
final class SearchViewModel: ObservableObject {
    /// 총 검색 결과
    @Published var bookCount: Int = -1
    
    /// 검색 결과 리스트
    @Published var searchBooks: [SearchBookResponse] = []
    
    /// 로딩 여부
    @Published var isLoading: Bool = false
    
    /// 검색
    func searchBooks(searchText: String, completion: @escaping (Bool) -> (Void)) {
        self.isLoading = true
        SearchAPI.shared.searchBooks(searchText: searchText) { response in
            self.isLoading = false
            switch response {
            case .success(let data):
                if let data = data as? SearchResponse {
                    // 총 검색 결과
                    self.bookCount = data.totalCount
                    
                    // 검색 결과 리스트
                    self.searchBooks = data.searchList
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
