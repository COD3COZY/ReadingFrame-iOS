//
//  TopRoundedBox.swift
//  ReadingFrame
//
//  Created by 이윤지 on 5/8/24.
//

import SwiftUI

/// 특정 모서리만 둥글게 만들어주는 박스
struct RoundedRadiusBox: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
        
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            
        return Path(path.cgPath)
    }
}

#Preview {
    RoundedRadiusBox()
}
