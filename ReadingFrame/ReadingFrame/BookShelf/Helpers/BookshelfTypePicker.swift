//
//  BookshelfTypePicker.swift
//  ReadingFrame
//
//  Created by 석민솔 on 8/24/24.
//

import Foundation
import SwiftUI

/// 메인 > 서재 화면 보여줄 때 서재 타입을 선택하는 picker
struct BookshelfTypePicker: View {
    /// 서재 정렬 어떤 타입으로 할건지(책 종류별, 독서상태별, 장르별)
    @Binding var bookshelfType: BookshelfType
    
    /// 서재 타입
    let bookshelfTypes: [BookshelfType] = [.booktype, .readingStatus, .genre]
    
    var body: some View {
        VStack {
            Picker("서재 보기", selection: $bookshelfType) {
                ForEach(bookshelfTypes, id: \.self) { shelfType in
                    Text(getBookshelfTypeName(shelfType))
                }
            }
            .pickerStyle(.menu)
            .padding()
            .tint(Color.black0)
        }
    }
    
    func getBookshelfTypeName(_ shelftype: BookshelfType) -> String {
        switch shelftype {
        case .booktype:
            return "책 유형별"
        case .readingStatus:
            return "독서상태별"
        case .genre:
            return "장르별"
        }
    }

}
