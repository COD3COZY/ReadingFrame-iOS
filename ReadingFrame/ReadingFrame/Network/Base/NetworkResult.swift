//
//  NetworkResult.swift
//  ReadingFrame
//
//  Created by 이윤지 on 8/20/24.
//

import Foundation

/// 서버 통신 결과를 핸들링하기 위한 열거형
enum NetworkResult<T> {
    /// 성공
    case success(T)
    
    /// 요청 에러
    case requestErr(T)
    
    /// 디코딩 실패
    case pathErr
    
    /// 서버 내부 에러
    case serverErr(T)
    
    /// 네트워크 연결 실패
    case networkFail(T)
    
    /// 알 수 없는 오류
    case unknown(T)
}
