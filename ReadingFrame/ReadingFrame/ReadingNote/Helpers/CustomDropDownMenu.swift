//
//  CustomDropDownMenu.swift
//  ReadingFrame
//
//  Created by 이윤지 on 6/7/24.
//

import SwiftUI

/// 커스텀 드롭다운 메뉴
struct CustomDropDownMenu: View {
    /// 메뉴 이름
    var label: String
    
    /// 아이콘
    var icon: String
    
    var body: some View {
        HStack(alignment: .center, spacing: 7) {
            Image(systemName: icon)
                .font(.headline)
                .foregroundStyle(.white)
            Text(label)
                .foregroundStyle(.white)
        }
        .padding(.vertical, 18)
        .frame(maxWidth: .infinity)
        .background(.black0)
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}

#Preview {
    CustomDropDownMenu(label: "읽는중", icon: "book")
}
