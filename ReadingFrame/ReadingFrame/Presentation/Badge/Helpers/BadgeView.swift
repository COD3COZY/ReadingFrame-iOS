//
//  BadgeView.swift
//  ReadingFrame
//
//  Created by 이윤지 on 8/7/24.
//

import SwiftUI

/// 배지 개별 뷰
struct BadgeView: View {
    // MARK: - PROPERTY
    var badge: Badge // 배지
    
    // MARK: - VIEW
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            // MARK: - 배지 이미지
            badgeImage
            
            // MARK: - 배지 이름
            Text(badge.badgeType.badgeName)
                .font(.subheadline)
                .fontWeight(.bold)
                .foregroundStyle(badge.isGotBadge ? .black0 : .greyText)
                .padding(.top, 10)
                .padding(.bottom, 7)
            
            // MARK: - 배지 정보
            Text(getBadgeInfoText())
                .font(.caption)
                .foregroundStyle(badge.isGotBadge ? .black0 : .greyText)
                .multilineTextAlignment(.center)
        }
    }
    
    
}

// MARK: - View Components
extension BadgeView {
    /// 배지 이미지
    private var badgeImage: some View {
        VStack(alignment: .center) {
            let badgeImageName = badge.badgeType.badgeImageName
            
            let baseImage = Image(badgeImageName)
            let greyImage = baseImage.renderingMode(.template).foregroundStyle(.greyText)
            
            switch badge.badgeType.rawValue {
            // 서재에 등록한 책
            case 0...5:
                if badge.isGotBadge {
                    baseImage
                } else {
                    greyImage
                }
            
            // 완독가
            case 10...13:
                if badge.isGotBadge {
                    baseImage
                        .padding(.top, 8)
                        .padding(.bottom, 16)
                } else {
                    greyImage
                        .padding(.top, 8)
                        .padding(.bottom, 16)
                }
            
            // 기록 MVP, 리뷰 마스터, 장르 애호가(문학)
            case 20...22, 30...32, 40:
                if badge.isGotBadge {
                    baseImage
                } else {
                    greyImage
                }
                
            // 에세이 배지
            case 41:
                Image(systemName: badgeImageName)
                    .resizable()
                    .frame(width: 60, height: 70)
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(
                        badge.isGotBadge ? .black0 : .greyText,
                        badge.isGotBadge ? .yellow : .greyText
                    )
                
            // 나머지 장르 배지
            case 42...45:
                Image(systemName: badgeImageName)
                    .font(.system(size: 55))
                    .foregroundStyle(badge.isGotBadge ? .black0 : .greyText)
            
            default:
                Image("오류")
                    .padding(.vertical)
            }
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .frame(height: 124)
        .background(
            RoundedRectangle(cornerRadius: 5)
                .fill(.grey1)
        )
    }
}


// MARK: - FUNCTION
extension BadgeView {
    /// 배지별 정보 텍스트
    func getBadgeInfoText() -> String {
        let requirement = badge.badgeType.requirement
        
        switch badge.badgeType.rawValue {
        // 서재에 등록한 책
        case 0...5:
            return bookCountText(bookCount: requirement)
        
        // 완독가
        case 10...13:
            return finisherText(bookCount: requirement)
        
        // 기록 MVP
        case 20:
            return badge.isGotBadge
                ? "모든 기록 1개 이상 등록 완료\n\(badge.date ?? "")"
                : "모든 기록 1개 이상 등록하면\n이 배지를 받을 수 있어요"
            
        case 21:
            return recordText(bookCount: requirement, record: "인물사전")
            
        case 22:
            return recordText(bookCount: requirement, record: "책갈피")
        
        // 리뷰 마스터
        case 30:
            return badge.isGotBadge
                ? "모든 리뷰 1개 이상 등록 완료\n\(badge.date ?? "")"
                : "모든 리뷰 1개 이상 등록하면\n이 배지를 받을 수 있어요"
            
        case 31...32:
            return reviewText(bookCount: requirement)
            
        // 장르 애호가
        case 40:
            return genreText(bookText: requirement)
            
        case 41:
            return badge.isGotBadge
                ? "에세이 독서 완료\n\(badge.date ?? "")"
                : "에세이를 읽으면\n이 배지를 받을 수 있어요"
            
        case 42...44:
            return genreText(bookText: requirement)
            
        case 45:
            return badge.isGotBadge
                ? "원서 독서 완료\n\(badge.date ?? "")"
                : "원서를 읽으면\n이 배지를 받을 수 있어요"
        
        default:
            return "오류"
        }
    }
    
    /// 서재에 등록한 책 배지 텍스트
    func bookCountText(bookCount: String) -> String {
        let isGotBadge = badge.isGotBadge
        
        if isGotBadge {
            return "서재에 \(bookCount)권 등록 완료\n\(badge.date ?? "")"
        }
        else {
            return "서재에 \(bookCount)권이 등록되면\n이 배지를 받을 수 있어요"
        }
    }
    
    /// 완독가 배지 텍스트
    func finisherText(bookCount: String) -> String {
        let isGotBadge = badge.isGotBadge
        
        if isGotBadge {
            return "다 읽은 책 \(bookCount)권 등록 완료\n\(badge.date ?? "")"
        }
        else {
            return "책 \(bookCount)권을 다 읽으면\n이 배지를 받을 수 있어요"
        }
    }
    
    /// 기록 MVP 배지 텍스트
    func recordText(bookCount: String, record: String) -> String {
        let isGotBadge = badge.isGotBadge
        
        if isGotBadge {
            return "\(record) \(bookCount)개 등록 완료\n\(badge.date ?? "")"
        }
        else {
            return "\(record) \(bookCount)개가 되면\n이 배지를 받을 수 있어요"
        }
    }
    
    /// 리뷰 마스터 배지 텍스트
    func reviewText(bookCount: String) -> String {
        let isGotBadge = badge.isGotBadge
        
        if isGotBadge {
            return "리뷰 \(bookCount)개 등록 완료\n\(badge.date ?? "")"
        }
        else {
            return "리뷰 \(bookCount)개가 등록 되면\n이 배지를 받을 수 있어요"
        }
    }
    
    /// 장르 애호가 배지 텍스트
    func genreText(bookText: String) -> String {
        let isGotBadge = badge.isGotBadge
        
        if isGotBadge {
            return "\(bookText) 독서 완료\n\(badge.date ?? "")"
        }
        else {
            return "\(bookText)을 읽으면\n이 배지를 받을 수 있어요"
        }
    }
}

// MARK: - PREVIEW
#Preview("배지 개별 뷰") {
    BadgeView(badge: Badge(badgeCode: 10,
                           isGotBadge: false,
                           date: "2024.08.08"))
}
