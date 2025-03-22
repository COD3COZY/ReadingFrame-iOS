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
    /// 서재 정렬 어떤 타입으로 할건지 분류기준(책 종류별, 독서상태별, 장르별)
    @Binding var bookshelfSort: BookshelfSort
        
    var body: some View {
        VStack {
            Picker("서재 보기", selection: $bookshelfSort) {
                ForEach(BookshelfSort.allCases, id: \.self) { shelfType in
                    Text(shelfType.name)
                }
            }
            .pickerStyle(.menu)
            .padding()
            .tint(Color.black0)
        }
    }

}
