//
//  HomeSegmentedControl.swift
//  ReadingFrame
//
//  Created by 이윤지 on 2/13/24.
//

import SwiftUI

/// 홈 화면 및 책장 화면에서 사용되는 Segmented Control
struct HomeSegmentedControl: View {
    
    /// Default 메뉴 값 (홈 화면)
    @Binding var selection: String
    
    /// Segmented Control에 들어갈 메뉴 값 (홈 화면, 책장 화면)
    let filterOptions: [String] = [
        "book.closed", "books.vertical"
    ]
    
    var body: some View {
        Picker(selection: $selection,
               label: Text("Picker"),
               content: {
                ForEach(filterOptions.indices, id: \.self) { index in
                    Image(systemName: filterOptions[index])
                        .font(.system(size: 13).weight(.semibold))
                        .foregroundStyle(.black)
                        .tag(filterOptions[index])
            }
        })
        .pickerStyle(SegmentedPickerStyle())
    }
}
