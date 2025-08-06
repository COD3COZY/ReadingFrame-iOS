//
//  BaseAPI.swift
//  ReadingFrame
//
//  Created by 이윤지 on 8/19/24.
//

import Foundation
import Alamofire

/// 모든 API의 기본이 되는 클래스
class BaseAPI {
    // TimeOut 시간
    enum TimeOut {
        static let requestTimeOut: Float = 60 // 초
        static let resourceTimeOut: Float = 60 // 초
    }
    
    // 네트워크 요청
    let AFManager: Session = {
        var session = AF
        let configuration = URLSessionConfiguration.af.default
        configuration.timeoutIntervalForRequest = TimeInterval(TimeOut.requestTimeOut)
        configuration.timeoutIntervalForResource = TimeInterval(TimeOut.resourceTimeOut)
        
        // 로그 출력
        let eventLogger = APIEventLogger()
        session = Session(configuration: configuration, eventMonitors: [eventLogger])
        
        return session
    }()
    
    /// API 통신 응답 분기 처리
    func judgeData<T: Decodable>(by statusCode: Int, _ data: Data, _ type: T.Type) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(CommonResponse<T>.self, from: data)
        else {
            return .pathErr // 디코딩 오류
        }
        
        switch statusCode {
        // 성공
        case 200...201:
            print(decodedData.message)
            return .success(decodedData.data ?? decodedData.status)
        case 202..<300:
            return .success(decodedData.status)
        case 400..<500:
            return .requestErr(decodedData.message)
        case 500:
            return .serverErr(decodedData.message)
        default:
            return .unknown(decodedData.message)
        }
    }
}
