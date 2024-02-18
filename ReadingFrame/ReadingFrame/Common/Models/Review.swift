//
//  Review.swift
//  ReadingFrame
//
//  Created by 석민솔 on 2/18/24.
//

import Foundation

/// 선택리뷰 열거형. raw value는 정수입니다.
enum selectReviewCode: Int {
    // MARK: 내용 및 구성
    /// 창의적이에요
    case creative
    
    /// 전개가 시원해요
    case fastPaced
    
    /// 현실적이에요
    case realistic
    
    /// 사회적 주제를 다뤄요
    case socialTheme
    
    /// 철학적이에요
    case philosophical
    
    /// 역사적인 내용을 다뤄요
    case historical
    
    /// 환경문제를 다뤄요
    case environmentalIssues
    
    /// 새로운 관점을 제공해요
    case newPerspective
    
    /// 전문적이에요
    case specialized
    
    /// 구성이 탄탄해요
    case wellStructured
    
    /// 난해해요
    case convoluted
    
    // MARK: 감상
    /// 감동적이에요
    case touching
    
    /// 여운이 남아요
    case leaveLingering
    
    /// 위로가 되었어요
    case comforting
    
    /// 슬퍼요
    case sad
    
    /// 어려워요
    case difficult
    
    /// 쉽게 읽혀요
    case easyToRead
    
    /// 재미있어요
    case entertaining
    
    /// 통찰력이 있어요
    case insightful
    
    /// 유익해요
    case informative
    
    /// 몰입감 있어요
    case immersive
    
    /// 화가 나요
    case angering
    
    /// 강렬해요
    case intense
    
    // MARK: 기타
    /// 믿고보는 작가에요
    case trustworthyAuthor
    
    /// 숨은 명작이에요
    case hiddenGem
    
    /// 호불호가 갈릴 것 같아요
    case polarising
    
    /// 소장하고 싶어요
    case wantToOwn
    
    /// 추천하고 싶어요
    case recommend
    
    /// 여러 번 읽었어요
    case readMultiple
    
    /// 선물하기 좋아요
    case goodForGift
    
    /// 삽화/표지가 예뻐요
    case looksNice
    
    /// 후속편 원해요 (기타)
    case wantSequel

}
