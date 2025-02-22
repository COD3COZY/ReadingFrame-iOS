//
//  Badge-Info.swift
//  ReadingFrame
//
//  Created by 석민솔 on 2/17/24.
//

import SwiftUI

/// 책정보 배지가 필요한 경우 책유형, 카테고리, 소장여부 중 배지를 원하는 정보를 전달인자로 입력해주면 그에 맞는 배지를 한번에 출력해줍니다.
///
/// - 파라미터를 모두 옵셔널로 지정해둬서 필요한 배지 정보만 입력해서 사용할 수 있습니다.
/// - 기존에 사용하던 책 관련 enum을 그대로 사용해서 재사용성을 높였습니다.
struct Tag_Info: View {
    // MARK: - Properties
    /// 입력받은 책유형
    var bookType: BookType?
    
    /// 입력받은 카테고리(장르)
    var category: CategoryName?
    
    /// 입력받은 소장여부
    var isMine: Bool?
        
    // MARK: - View
    var body: some View {
        HStack(spacing: 6) {
            // MARK: 책유형
            // 책유형 값이 있다면 종류에 따라 배지 보여주기
            if let existBookType = bookType {
                switch existBookType {
                case .paperbook:
                    tag(text: existBookType.name, color: .blue)
                case .eBook:
                    tag(text: existBookType.name, color: .yellow)
                case .audioBook:
                    tag(text: existBookType.name, color: .green)
                }
            }
            
            
            // MARK: 카테고리(장르)
            // 카테고리 값이 있다면 종류에 따라 카테고리 보여주기
            if let existCategory = category {
                tag(text: existCategory.name, color: .black0)
            }
            
            // MARK: 소장
            // 소장한 책이라면 소장 태그 보여주기
            if let isMine = isMine {
                if isMine {
                    ownedTag
                }
            }
            
        }
    }
}

extension Tag_Info {
    /// 반복해서 사용할 단일 태그 컴포넌트
    private func tag(text: String, color: Color) -> some View {
        Text(text)
            .font(.caption)
            .foregroundStyle(color)
            .padding(.vertical, 2)
            .padding(.horizontal, 11)
            .background(
                RoundedRectangle(cornerRadius: 40)
                    .stroke(color, lineWidth: 1)
            )
    }
    
    /// 소장 태그
    private var ownedTag: some View {
        Text("소장")
            .font(.caption)
            .foregroundStyle(Color.white)
            .padding(.vertical, 2)
            .padding(.horizontal, 11)
            .background(
                RoundedRectangle(cornerRadius: 40)
                    .fill(Color.black0)
                    .stroke(Color.black0, lineWidth: 1)
            )
    }
}


#Preview {
    Tag_Info(bookType: .paperbook)
}
