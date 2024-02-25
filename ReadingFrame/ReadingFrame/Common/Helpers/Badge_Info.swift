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
///
/// - 기존에 사용하던 책 관련 enum을 그대로 사용해서 재사용성을 높였습니다.
struct Badge_Info: View {
    
    /// 입력받은 책유형
    var bookType: BookType?
    
    /// 입력받은 카테고리(장르)
    var category: CategoryName?
    
    /// 입력받은 소장여부
    var isMine: Bool?
        
    
    var body: some View {
        HStack(spacing: 6) {
            // MARK: 책유형
            // 책유형 값이 있다면 종류에 따라 배지 보여주기
            if let existBookType = bookType {
                switch existBookType {
                case .paperbook:
                    Badge(text: "종이책", color: .blue)
                case .eBook:
                    Badge(text: "전자책", color: .yellow)
                case .audioBook:
                    Badge(text: "오디오북", color: .green)
                }
            }
            
            
            // MARK: 카테고리(장르)
            // 카테고리 값이 있다면 종류에 따라 카테고리 보여주기
            if let existCategory = category {
                switch existCategory {
                case .humanSocial:
                    Badge(text: "인문사회", color: .black0)
                case .literature:
                    Badge(text: "문학", color: .black0)
                case .essays:
                    Badge(text: "에세이", color: .black0)
                case .science:
                    Badge(text: "과학", color: .black0)
                case .selfImprovement:
                    Badge(text: "자기계발", color: .black0)
                case .art:
                    Badge(text: "예술", color: .black0)
                case .foreign:
                    Badge(text: "원서", color: .black0)
                case .etc:
                    Badge(text: "기타", color: .black0)
                }
            }
            
            // MARK: 소장
            // 소장한 책이라면 소장 배지 보여주기
            if let isMine = isMine {
                if isMine {
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
            
        }
    }

    /// 반복해서 사용할 단일 배지 컴포넌트를 뷰로 만들었습니다.
    struct Badge: View {
        var text: String
        var color: Color
        
        var body: some View {
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
    }
}


#Preview {
    Badge_Info(category: .literature)
}
