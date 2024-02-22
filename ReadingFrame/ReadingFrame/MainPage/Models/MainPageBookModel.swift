//
//  MainPageBookModel.swift
//  ReadingFrame
//
//  Created by 이윤지 on 2/22/24.
//

import Foundation
import Observation

/// 홈 화면에서 사용하는 모든 책 Model
@Observable
class MainPageBookModel {
    /// 책
    var book: RegisteredBook
    
    /// 독서 상태 변경 여부
    var isStatusChange: Bool = false
    
    /// 초기화
    init(book: RegisteredBook, isStatusChange: Bool) {
        self.book = book
        self.isStatusChange = isStatusChange
    }
}
