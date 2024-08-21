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
    var topPadding: CGFloat // 상단 여백 값
    var bottomPadding: CGFloat // 하단 여백 값
    
    // MARK: - BODY
    var body: some View {
        VStack(alignment: .center, spacing: 9) {
            // MARK: - 배지 이미지
            VStack(alignment: .center) {
                switch badge.badgeCode {
                // 서재에 등록한 책
                case 0:
                    Image(badge.isGotBadge ? .badge1Fill : .badge1)
                        .padding(.vertical, topPadding)
                case 1:
                    Image(badge.isGotBadge ? .badge10Fill : .badge10)
                        .padding(.vertical, topPadding)
                case 2:
                    Image(badge.isGotBadge ? .badge50Fill : .badge50)
                        .padding(.vertical, topPadding)
                case 3:
                    Image(badge.isGotBadge ? .badge100Fill : .badge100)
                        .padding(.vertical, topPadding)
                case 4:
                    Image(badge.isGotBadge ? .badge200Fill : .badge200)
                        .padding(.vertical, topPadding)
                case 5:
                    Image(badge.isGotBadge ? .badge500Fill : .badge500)
                        .padding(.vertical, topPadding)
                
                // 완독가
                case 10:
                    Image(badge.isGotBadge ? .finisher1Fill : .finisher1)
                        .padding(.top, topPadding)
                        .padding(.bottom, bottomPadding)
                case 11:
                    Image(badge.isGotBadge ? .finisher2Fill : .finisher2)
                        .padding(.top, topPadding)
                        .padding(.bottom, bottomPadding)
                case 12:
                    Image(badge.isGotBadge ? .finisher3Fill : .finisher3)
                        .padding(.top, topPadding)
                        .padding(.bottom, bottomPadding)
                case 13:
                    Image(badge.isGotBadge ? .finisher4Fill : .finisher4)
                        .padding(.top, topPadding)
                        .padding(.bottom, bottomPadding)
                    
                // 기록 MVP
                case 20:
                    Image(badge.isGotBadge ? .record1Fill : .record1)
                        .padding(.vertical, topPadding)
                case 21:
                    Image(badge.isGotBadge ? .record2Fill : .record2)
                        .padding(.vertical, topPadding)
                case 22:
                    Image(badge.isGotBadge ? .record3Fill : .record3)
                        .padding(.vertical, topPadding)
                    
                // 리뷰 마스터
                case 30:
                    Image(badge.isGotBadge ? .review1Fill : .review1)
                        .padding(.vertical, topPadding)
                case 31:
                    Image(badge.isGotBadge ? .review30Fill : .review30)
                        .padding(.vertical, topPadding)
                case 32:
                    Image(badge.isGotBadge ? .review100Fill : .review100)
                        .padding(.vertical, topPadding)
                    
                // 장르 애호가
                case 40:
                    Image(badge.isGotBadge ? .artFill : .art)
                        .padding(.vertical, topPadding)
                case 41:
                    Image(badge.isGotBadge ? .bulbFill : .bulb)
                        .padding(.vertical, topPadding)
                case 42:
                    Image(badge.isGotBadge ? .glassesFill : .glasses)
                        .padding(.vertical, topPadding)
                case 43:
                    Image(badge.isGotBadge ? .scienceFill : .science)
                        .padding(.vertical, topPadding)
                case 44:
                    Image(badge.isGotBadge ? .brainFill : .brain)
                        .padding(.vertical, topPadding)
                case 45:
                    Image(badge.isGotBadge ? .globeFill : .globe)
                        .padding(.vertical, topPadding)
                
                default:
                    Image("오류")
                        .padding(.vertical, topPadding)
                }
            }
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 5)
                    .fill(.grey1)
            )
            
            // MARK: - 배지 이름
            Text(BadgeName(badgeCode: badge.badgeCode))
                .font(.system(size: 15, weight: .semibold))
                .foregroundStyle(badge.isGotBadge ? .black0 : .greyText)
            
            // MARK: - 배지 정보
            switch badge.badgeCode {
            // 서재에 등록한 책
            case 0...5:
                Text(bookCountText(bookCount: BadgeCount(badgeCode: badge.badgeCode)))
                    .font(.caption)
                    .foregroundStyle(badge.isGotBadge ? .black0 : .greyText)
                    .multilineTextAlignment(.center)
            
            // 완독가
            case 10...13:
                Text(finisherText(bookCount: BadgeCount(badgeCode: badge.badgeCode)))
                    .font(.caption)
                    .foregroundStyle(badge.isGotBadge ? .black0 : .greyText)
                    .multilineTextAlignment(.center)
            
            // 기록 MVP
            case 20:
                Text(badge.isGotBadge ? "모든 기록 1개 이상 등록 완료\n\(badge.date ?? "")" : "모든 기록 1개 이상 등록하면\n이 배지를 받을 수 있어요")
                    .font(.caption)
                    .foregroundStyle(badge.isGotBadge ? .black0 : .greyText)
                    .multilineTextAlignment(.center)
                
            case 21:
                Text(recordText(bookCount: BadgeCount(badgeCode: badge.badgeCode), record: "인물사전"))
                    .font(.caption)
                    .foregroundStyle(badge.isGotBadge ? .black0 : .greyText)
                    .multilineTextAlignment(.center)
                
            case 22:
                Text(recordText(bookCount: BadgeCount(badgeCode: badge.badgeCode), record: "책갈피"))
                    .font(.caption)
                    .foregroundStyle(badge.isGotBadge ? .black0 : .greyText)
                    .multilineTextAlignment(.center)
            
            // 리뷰 마스터
            case 30:
                Text(badge.isGotBadge ? "모든 리뷰 1개 이상 등록 완료\n\(badge.date ?? "")" : "모든 리뷰 1개 이상 등록하면\n이 배지를 받을 수 있어요")
                    .font(.caption)
                    .foregroundStyle(badge.isGotBadge ? .black0 : .greyText)
                    .multilineTextAlignment(.center)
                
            case 31...32:
                Text(reviewText(bookCount: BadgeCount(badgeCode: badge.badgeCode)))
                    .font(.caption)
                    .foregroundStyle(badge.isGotBadge ? .black0 : .greyText)
                    .multilineTextAlignment(.center)
                
            // 장르 애호가
            case 40:
                Text(genreText(bookText: BadgeCount(badgeCode: badge.badgeCode)))
                    .font(.caption)
                    .foregroundStyle(badge.isGotBadge ? .black0 : .greyText)
                    .multilineTextAlignment(.center)
                
            case 41:
                Text(badge.isGotBadge ? "에세이 독서 완료\n\(badge.date ?? "")" : "에세이를 읽으면\n이 배지를 받을 수 있어요")
                    .font(.caption)
                    .foregroundStyle(badge.isGotBadge ? .black0 : .greyText)
                    .multilineTextAlignment(.center)
                
            case 42...44:
                Text(genreText(bookText: BadgeCount(badgeCode: badge.badgeCode)))
                    .font(.caption)
                    .foregroundStyle(badge.isGotBadge ? .black0 : .greyText)
                    .multilineTextAlignment(.center)
                
            case 45:
                Text(badge.isGotBadge ? "원서 독서 완료\n\(badge.date ?? "")" : "원서를 읽으면\n이 배지를 받을 수 있어요")
                    .font(.caption)
                    .foregroundStyle(badge.isGotBadge ? .black0 : .greyText)
                    .multilineTextAlignment(.center)
            
            default:
                Text("오류")
                    .font(.caption)
                    .foregroundStyle(badge.isGotBadge ? .black0 : .greyText)
                    .multilineTextAlignment(.center)
            }
        }
    }
    
    // MARK: - FUNCTION
    // 서재에 등록한 책 배지 텍스트
    func bookCountText(bookCount: String) -> String {
        let isGotBadge = badge.isGotBadge
        
        if isGotBadge {
            return "서재에 \(bookCount)권 등록 완료\n\(badge.date ?? "")"
        }
        else {
            return "서재에 \(bookCount)권이 등록되면\n이 배지를 받을 수 있어요"
        }
    }
    
    // 완독가 배지 텍스트
    func finisherText(bookCount: String) -> String {
        let isGotBadge = badge.isGotBadge
        
        if isGotBadge {
            return "다 읽은 책 \(bookCount)권 등록 완료\n\(badge.date ?? "")"
        }
        else {
            return "책 \(bookCount)권을 다 읽으면\n이 배지를 받을 수 있어요"
        }
    }
    
    // 기록 MVP 배지 텍스트
    func recordText(bookCount: String, record: String) -> String {
        let isGotBadge = badge.isGotBadge
        
        if isGotBadge {
            return "\(record) \(bookCount)개 등록 완료\n\(badge.date ?? "")"
        }
        else {
            return "\(record) \(bookCount)개가 되면\n이 배지를 받을 수 있어요"
        }
    }
    
    // 리뷰 마스터 배지 텍스트
    func reviewText(bookCount: String) -> String {
        let isGotBadge = badge.isGotBadge
        
        if isGotBadge {
            return "리뷰 \(bookCount)개 등록 완료\n\(badge.date ?? "")"
        }
        else {
            return "리뷰 \(bookCount)개가 등록 되면\n이 배지를 받을 수 있어요"
        }
    }
    
    // 장르 애호가 배지 텍스트
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
    BadgeView(badge: Badge(badgeCode: 10, isGotBadge: true, date: "2024.08.08"), topPadding: 12, bottomPadding: 12)
}
