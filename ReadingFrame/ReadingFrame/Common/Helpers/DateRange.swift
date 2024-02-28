//
//  DateRange.swift
//  ReadingFrame
//
//  Created by 이윤지 on 2/28/24.
//

import Foundation

/// 모든 화면에서 사용하는 날짜 관련 파일

public struct DateRange {
    
    /// 날짜 범위 반환 함수
    public func dateRange(date: Date) -> ClosedRange<Date> {
        let min = Calendar.current.date(byAdding: .year, value: -100, to: date)!
        let max = Date()
        
        return min...max
    }
}
