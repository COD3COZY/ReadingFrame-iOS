//
//  Badge.swift
//  ReadingFrame
//
//  Created by 이윤지 on 8/7/24.
//

import Foundation

/// 배지 모델
struct Badge {
    /// 배지 분류코드
    let badgeType: BadgeType
    
    /// 배지 획득 여부
    var isGotBadge: Bool
    
    /// 배지 획득 날짜
    var date: String?
    
    /// 배지 코드 이용한 생성자
    init(badgeCode: Int, isGotBadge: Bool, date: String? = nil) {
        self.badgeType = BadgeType(rawValue: badgeCode) ?? .bookCount0
        self.isGotBadge = isGotBadge
        self.date = date
    }
}

/// 배지 구역별 종류
enum BadgeSectionType: String, CaseIterable {
    /// 서재에 등록한 책
    case bookCount = "서재에 등록한 책"
    
    /// 완독가
    case finisher = "완독가"
    
    /// 기록 MVP
    case recordMVP = "기록 MVP"
    
    /// 리뷰 마스터
    case reviewMaster = "리뷰 마스터"
    
    /// 장르 애호가
    case genreFan = "장르 애호가"
    
    /// 구역별 설명
    var desc: String? {
        switch self {
        case .bookCount:
            nil
        case .finisher:
            nil
        case .recordMVP:
            "*’첫 기록’은 책갈피, 인물사전, 메모를 모두 등록해야 합니다."
        case .reviewMaster:
            "*’리뷰계의 라이징스타’는 키워드, 선택, 한줄평 모두 등록해야 합니다."
        case .genreFan:
            nil
        }
    }
    
    /// 구역별 배지 분류코드 범위
    var badgeCodeRange: ClosedRange<Int> {
        switch self {
        case .bookCount:
            return 0...5
        case .finisher:
            return 10...13
        case .recordMVP:
            return 20...22
        case .reviewMaster:
            return 30...32
        case .genreFan:
            return 40...45
        }
    }
    
    /// 배지 배열에서 0번부터 순서대로 구역별 범위
    var badgeArrayRange: ClosedRange<Int> {
        switch self {
        case .bookCount:
            return 0...5
        case .finisher:
            return 6...9
        case .recordMVP:
            return 10...12
        case .reviewMaster:
            return 13...15
        case .genreFan:
            return 16...21
        }
    }
}

enum BadgeType: Int {
    // 서재에 등록한 책
    case bookCount0 = 0
    case bookCount10 = 1
    case bookCount50 = 2
    case bookCount100 = 3
    case bookCount200 = 4
    case bookCount500 = 5
    
    // 완독가
    case finisher1 = 10
    case finisher2 = 11
    case finisher3 = 12
    case finisher4 = 13
    
    // 기록 MVP
    case recordMVP1 = 20
    case recordMVP2 = 21
    case recordMVP3 = 22
    
    // 리뷰 마스터
    case review1 = 30
    case review30 = 31
    case review100 = 32
    
    // 장르 애호가
    case art = 40
    case essay = 41
    case humanities = 42
    case science = 43
    case selfImprovment = 44
    case originalEdition = 45

    /// 배지 이름
    var badgeName: String {
        switch self {
        // 서재에 등록한 책
        case .bookCount0:   return "역사적인 첫 발걸음"
        case .bookCount10:  return "서가"
        case .bookCount50:  return "책장"
        case .bookCount100: return "동네책방"
        case .bookCount200: return "작은 도서관"
        case .bookCount500: return "도서관장"
            
        // 완독가
        case .finisher1:    return "시작이 절반"
        case .finisher2:    return "완독가의 자질"
        case .finisher3:    return "엄연한 완독가"
        case .finisher4:    return "완독 마스터"
            
        // 기록 MVP
        case .recordMVP1:   return "첫 기록"
        case .recordMVP2:   return "두꺼운 인물사전"
        case .recordMVP3:   return "책갈피의 산"
            
        // 리뷰 마스터
        case .review1:      return "리뷰계의 라이징스타"
        case .review30:     return "리뷰 마스터"
        case .review100:    return "리뷰 인플루언서"
            
        // 장르애호가
        case .art:            return "예술적인 형상가"
        case .essay:          return "자유로운 발상가"
        case .humanities:     return "탐구하는 학문가"
        case .science:        return "관찰적인 연구가"
        case .selfImprovment: return "독창적인 성장가"
        case .originalEdition: return "폭넓은 여행가"
        }
    }
 
    /// 배지 획득 기준
    var requirement: String {
         switch self {
         // 서재에 등록한 책
         case .bookCount0:   return "1"
         case .bookCount10:  return "10"
         case .bookCount50:  return "50"
         case .bookCount100: return "100"
         case .bookCount200: return "200"
         case .bookCount500: return "500"
             
         // 완독가
         case .finisher1:    return "1"
         case .finisher2:    return "10"
         case .finisher3:    return "50"
         case .finisher4:    return "100"
             
         // 기록 MVP
         case .recordMVP1:   return "1"
         case .recordMVP2:   return "100"
         case .recordMVP3:   return "100"
             
         // 리뷰 마스터
         case .review1:      return "1"
         case .review30:     return "30"
         case .review100:    return "100"
             
         // 장르애호가
         case .art:            return "문학 책"
         case .essay:          return "에세이"
         case .humanities:     return "인문 책"
         case .science:        return "과학 책"
         case .selfImprovment: return "자기계발 책"
         case .originalEdition: return "원서"
         }
    }
 
    /// 배지별 이미지 이름
    var badgeImageName: String {
        switch self {
        // 서재에 등록한 책
        case .bookCount0:   return "badge_1"
        case .bookCount10:  return "badge_10"
        case .bookCount50:  return "badge_50"
        case .bookCount100: return "badge_100"
        case .bookCount200: return "badge_200"
        case .bookCount500: return "badge_500"

        // 완독가
        case .finisher1:    return "finisher_1"
        case .finisher2:    return "finisher_2"
        case .finisher3:    return "finisher_3"
        case .finisher4:    return "finisher_4"
            
        // 기록 MVP
        case .recordMVP1:   return "record_1"
        case .recordMVP2:   return "record_2"
        case .recordMVP3:   return "record_3"
        
        // 리뷰 마스터
        case .review1:      return "review_1"
        case .review30:     return "review_30"
        case .review100:    return "review_100"
          
        // 장르 애호가
        case .art:            return "art"
        case .essay:          return "lightbulb.max"
        case .humanities:     return "eyeglasses"
        case .science:        return "flask"
        case .selfImprovment: return "brain"
        case .originalEdition: return "globe.desk"
        }
    }
}
