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
    let AlamofireManager: Session = {
        var session = AF
        let configuration = URLSessionConfiguration.af.default
        configuration.timeoutIntervalForRequest = TimeInterval(TimeOut.requestTimeOut)
        configuration.timeoutIntervalForResource = TimeInterval(TimeOut.resourceTimeOut)
        
        // 로그 출력
        let eventLogger = APIEventLogger()
        session = Session(configuration: configuration, eventMonitors: [eventLogger])
        
        return session
    }()
}
