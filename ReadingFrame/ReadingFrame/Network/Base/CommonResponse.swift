//
//  CommonResponse.swift
//  ReadingFrame
//
//  Created by 이윤지 on 8/20/24.
//

import Foundation

// 공통 API 응답 모델
struct CommonResponse<T: Codable>: Codable {
    var status: Int
    var message: String
    var data: T?
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case message = "message"
        case data = "data"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = (try? values.decode(Int.self, forKey: .status)) ?? -1
        message = (try? values.decode(String.self, forKey: .message)) ?? ""
        data = (try? values.decode(T.self, forKey: .data)) ?? nil
    }
}
