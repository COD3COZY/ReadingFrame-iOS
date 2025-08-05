//
//  DateUtils.swift
//  ReadingFrame
//
//  Created by 이윤지 on 2/28/24.
//

import Foundation

/// 모든 화면에서 사용하는 날짜 관련 파일

struct DateUtils {
    
    /// 날짜 범위 반환 함수
    public func dateRange(date: Date) -> ClosedRange<Date> {
        let min = Calendar.current.date(byAdding: .year, value: -100, to: date)!
        let max = Date()
        
        return min...max
    }
    
    /// 날짜 스타일 반환 함수(date -> string)
    static func dateToString(date: Date = Date(), style: String = "yyyy.MM.dd") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = style
        
        let dateToString = dateFormatter.string(from: date)
        
        return dateToString
    }
    
    /// String날짜를 Date 객체로 변환
    static func stringToDate(_ dateString: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        
        let stringToDate = dateFormatter.date(from: dateString)
        
        return stringToDate ?? Date()
    }
}
