//
//  GreyLogoAndTextView.swift
//  ReadingFrame
//
//  Created by 석민솔 on 3/16/24.
//

import SwiftUI

/// 데이터가 없을 때 안내 메시지와 로고를 회색으로 보여주는 공통 화면
struct GreyLogoAndTextView: View {
    var text: String
    
    var body: some View {
        VStack(alignment: .center, spacing: 25) {
            Spacer()
            
            Image("character_main")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 90, height: 120)
            
            Text(text)
                .foregroundStyle(Color.greyText)
            
            Spacer()
        }
    }
}

#Preview {
    GreyLogoAndTextView(text: "아직 뭐가 없어요")
}
