//
//  Badge.swift
//  ReadingFrame
//
//  Created by 이윤지 on 8/7/24.
//

import Foundation

/// 배지 모델
struct Badge: Codable {
    /// 배지 분류코드
    let badgeCode: Int
    
    /// 배지 획득 여부
    var isGotBadge: Bool
    
    /// 배지 획득 날짜
    var date: String?
}

/*enum BadgeName: Int {
    case bookCount0 = 0
    case bookCount10 = 1
    case bookCount50 = 2
    case bookCount100 = 3
    case bookCount200 = 4
    case bookCount500 = 5
    
    case finisher1 = 10
    case finisher2 = 11
    case finisher3 = 12
    case finisher4 = 13
    
    case recordMVP1 = 20
    case recordMVP2 = 21
    case recordMVP3 = 22
    
    case review1 = 30
    case review30 = 31
    case review100 = 32
    
    case art = 40
    case essay = 41
    case humanities = 42
    case science = 43
    case selfImprovment = 44
    case originalEdition = 45

    var badgeName: String {
        switch self {
        // 서재에 등록한 책
        case .bookCount0:
            return "역사적인 첫 발걸음"
        case .bookCount10:
            return "서가"
        case .bookCount50:
            return "책장"
        case .bookCount100:
            return "동네책방"
        case .bookCount200:
            return "작은 도서관"
        case .bookCount500:
            return "도서관장"
            
        // 완독가
        case .finisher1:
            return "시작이 절반"
        case .finisher2:
            return "완독가의 자질"
        case .finisher3:
            return "엄연한 완독가"
        case .finisher4:
            return "완독 마스터"
            
        // 기록 MVP
        case .recordMVP1:
            return "첫 기록"
        case .recordMVP2:
            return "두꺼운 인물사전"
        case .recordMVP3:
            return "책갈피의 산"
            
        // 리뷰 마스터
        case .review1:
            return "리뷰계의 라이징스타"
        case .review30:
            return "리뷰 마스터"
        case .review100:
            return "리뷰 인플루언서"
            
        // 장르애호가
        case .art:
            return "예술적인 형상가"
        case .essay:
            return "자유로운 발상가"
        case .humanities:
            return "탐구하는 학문가"
        case .science:
            return "관찰적인 연구가"
        case .selfImprovment:
            return "독창적인 성장가"
        case .originalEdition:
            return "폭넓은 여행가"
        }
    }
}*/

/// 배지 이름 조회
func BadgeName(badgeCode: Int) -> String {
    switch badgeCode {
    // 서재에 등록한 책
    case 0: return "역사적인 첫 발걸음"
    case 1: return "서가"
    case 2: return "책장"
    case 3: return "동네책방"
    case 4: return "작은 도서관"
    case 5: return "도서관장"
    
    // 완독가
    case 10: return "시작이 절반"
    case 11: return "완독가의 자질"
    case 12: return "엄연한 완독가"
    case 13: return "완독 마스터"
    
    // 기록 MVP
    case 20: return "첫 기록"
    case 21: return "두꺼운 인물사전"
    case 22: return "책갈피의 산"
        
    // 리뷰 마스터
    case 30: return "리뷰계의 라이징스타"
    case 31: return "리뷰 마스터"
    case 32: return "리뷰 인플루언서"
    
    // 장르애호가
    case 40: return "예술적인 형상가"
    case 41: return "자유로운 발상가"
    case 42: return "탐구하는 학문가"
    case 43: return "관찰적인 연구가"
    case 44: return "독창적인 성장가"
    case 45: return "폭넓은 여행가"
        
    default: return "배지 이름 조회 오류"
    }
}

/// 배지 숫자 조회
func BadgeCount(badgeCode: Int) -> String {
    switch badgeCode {
    // 서재에 등록한 책
    case 0: return "1"
    case 1: return "10"
    case 2: return "50"
    case 3: return "100"
    case 4: return "200"
    case 5: return "500"
    
    // 완독가
    case 10: return "1"
    case 11: return "10"
    case 12: return "50"
    case 13: return "100"
    
    // 기록 MVP
    case 20: return "1"
    case 21: return "100"
    case 22: return "100"
        
    // 리뷰 마스터
    case 30: return "1"
    case 31: return "30"
    case 32: return "100"
    
    // 장르애호가
    case 40: return "문학 책"
    case 41: return "에세이"
    case 42: return "인문 책"
    case 43: return "과학 책"
    case 44: return "자기계발 책"
    case 45: return "원서"
        
    default: return "조회 오류"
    }
}
