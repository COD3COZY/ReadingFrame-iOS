//
//  LoadableBookImage.swift
//  ReadingFrame
//
//  Created by 이윤지 on 2/14/24.
//

import SwiftUI

/// 책 이미지를 불러오는 뷰
struct LoadableBookImage: View {
    
    /// 책  표지 이미지 URL
    var bookCover: String
    
    var body: some View {
        // MARK: 비동기적으로 이미지 로드하기
        let bookCoverUrl = URL(string: bookCover) // 책 커버 이미지 타입 변경
        AsyncImage(url: bookCoverUrl) { phase in
            // 이미지 로드를 성공한 경우
            if let image = phase.image {
                image
                    .resizable()
                    .scaledToFit()
            }
            // 이미지 로드를 실패한 경우
            else if phase.error != nil {
                VStack {
                    Image("cover_temp")
                        .resizable()
                        .scaledToFit()
                }
            }
            // 이미지 로드 중 애니메이션 띄우기
            else {
                ProgressView()
            }
        }
    }
}

#Preview {
    LoadableBookImage(bookCover: "https://image.aladin.co.kr/product/31911/97/cover500/k942833843_1.jpg")
}
