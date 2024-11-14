//
//  MainPageViewModel.swift
//  ReadingFrame
//
//  Created by 이윤지 on 10/2/24.
//

import Foundation

/// 홈 화면의 뷰모델
final class HomeViewModel: ObservableObject {
    /// 홈 조회
    func getHome(completion: @escaping (Bool) -> (Void)) {
        HomeAPI.shared.getHome { response in
            switch response {
            case .success(let data):
                if let data = data as? HomeResponse {
                    completion(true)
                }
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
            }
        }
    }
}
