//
//  RegisterBookViewModel.swift
//  ReadingFrame
//
//  Created by 석민솔 on 3/30/25.
//

import Foundation
import MapKit

class RegisterBookViewModel: ObservableObject {
    // MARK: - Properties
    @Published var registerBookData: RegisterBookModel
    
    /// 읽기 시작한 날 정할 수 있는 범위(100년 전 ~ 현재)
    /// - 설마 100년전에 읽던 책까지 우리 앱에 기록하지는 않을거잖아요?
    var startDateRange: ClosedRange<Date> {
        DateUtils().dateRange(date: registerBookData.startDate)
    }
    
    /// 다읽은 날 정할 수 있는 범위(읽기 시작한 날 ~ 현재)
    var recentDateRange: ClosedRange<Date> {
        let min = registerBookData.startDate
        let max = Date()
        return min...max
    }
    
    // MARK: - init
    init(isbn: String, bookInfo: RegisterBookInfoModel?) {
        self.registerBookData = .init(
            isbn: isbn,
            readingStatus: .reading,
            bookType: .paperbook,
            mainLocation: nil,
            isMine: false,
            startDate: Date(),
            recentDate: Date(),
            bookInformation: bookInfo
        )
    }
    
    // MARK: - Methods
    /// 책등록 API 호출
    func registerBook(completion: @escaping (Bool) -> (Void)) {
        let request = RegisterBookRequest(
            readingStatus: self.registerBookData.readingStatus,
            bookType: self.registerBookData.bookType,
            mainLocation: self.registerBookData.mainLocation,
            isMine: self.registerBookData.isMine,
            startDate: self.registerBookData.startDate,
            recentDate: self.registerBookData.readingStatus == .finishRead ? self.registerBookData.recentDate : nil,
            bookInformation: self.registerBookData.bookInformation
        )
        
        BookInfoAPI.shared.postRegisterBook(isbn: self.registerBookData.isbn, request: request) { response in
            switch response {
            case .success(let data):
                print("책 등록 성공 \(data)")
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
