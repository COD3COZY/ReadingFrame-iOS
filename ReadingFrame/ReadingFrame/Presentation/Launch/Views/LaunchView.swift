//
//  LaunchView.swift
//  ReadingFrame
//
//  Created by 석민솔 on 1/30/24.
//

import SwiftUI

struct LaunchView: View {
    var body: some View {
        SplashScreenView
    }
}

// MARK: - 스플래시 스크린
extension LaunchView {
    var SplashScreenView: some View {
        VStack {
            Spacer()
            Image("icon_temp")
                .resizable()
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 40))
                .frame(width: 213, height: 213)
            Text("ReadingFrame")
                .font(.title)
                .fontWeight(.light)
            Spacer()
        }
    }
}

#Preview {
    LaunchView()
}
