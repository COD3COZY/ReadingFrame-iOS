//
//  DragIndicator.swift
//  ReadingFrame
//
//  Created by 이윤지 on 2/28/24.
//

import SwiftUI

/// 모든 sheet 화면의 상단에 있는 indicator
struct DragIndicator: View {
    var body: some View {
        // MARK: Drag Indicator
        ZStack {
            Capsule()
                .fill(.grey2)
                .frame(width: 42, height: 5)
                .padding(.top, 10)
        }
        .frame(maxWidth: .infinity, alignment: .center)
    }
}

#Preview {
    DragIndicator()
}
