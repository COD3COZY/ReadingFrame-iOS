//
//  Book.swift
//  ReadingFrame
//
//  Created by 석민솔 on 2/13/24.
//

// File 목차
// protocol Book
// structure InitialBook

// protocol BookRegistered
// structure RegisteredBook

// enum BookType
// enum ReadingStatus
// enum CategoryName

import Foundation
import CoreLocation
import Observation

// MARK: - Book(기본)
/// 프로토콜) 모든 책의 기본이 되는 책정보
protocol Book {
    /// 13자리 ISBN 값
    var ISBN: String { get set }
    
    /// 북커버 이미지 URL
    var cover: String { get set }
    
    /// 책제목
    var title: String { get set }
    
    /// 저자
    var author: String { get set }
    
    /// 출판사
    var publisher: String { get set }
    
    /// 발행일
    var publicationDate: Date { get set }
    
    /// 카테고리(주제 분류, 장르)
    var categoryName: CategoryName { get set }
    
    /// 전체 페이지
    var totalPage: Int { get set }
    
    /// 설명 텍스트
    var description: String { get set }
    
    /// 독서상태
    var readingStatus: ReadingStatus { get set }
}


/// 구조체) 기본책(미등록, 읽고싶은): 등록되기 전 상태의 책정보를 가지고 있는 구조체
///
/// 기본책은 아무것도 하지 않는법(사유: 표지가 예쁩니다)
@Observable
class InitialBook: Book, Identifiable {
    let id = UUID() // Identifiable 지키려면 있어야된다고 합니다
    
    /// 13자리 ISBN 값
    var ISBN: String
    
    /// 북커버 이미지 URL
    var cover: String
    
    /// 책제목
    var title: String
    
    /// 저자
    var author: String
    
    /// 출판사
    var publisher: String
    
    /// 발행일
    var publicationDate: Date
    
    /// 카테고리(주제 분류, 장르)
    var categoryName: CategoryName
    
    /// 전체 페이지
    var totalPage: Int
    
    /// 설명 텍스트
    var description: String
    
    /// 독서상태
    var readingStatus: ReadingStatus
    
    init(ISBN: String = "9791197559655",
         cover: String = "https://image.aladin.co.kr/product/31911/97/cover500/k942833843_1.jpg",
         title: String = "아무것도 하지 않는 법",
         author: String = "제니 오델(지은이), 김하현(옮긴이)",
         publisher: String = "필로우",
         publicationDate: Date = Calendar.current.date(from: DateComponents(year: 2023, month: 6, day: 26))!,
         categoryName: CategoryName = .humanSocial,
         totalPage: Int = 380,
         description: String  = "“아무것도 하지 않는 것은 휴대폰을 내려놓고 그 자리에 가만히 머무는 것이다.” 『아무것도 하지 않는 법』의 저자 제니 오델은 소셜미디어를 비롯한 관심경제에 사로잡힌 관심의 주권을 되찾아 다른 방향으로 확장하자고 제안한다.",
         readingStatus: ReadingStatus = .unregistered) {
        self.ISBN = ISBN
        self.cover = cover
        self.title = title
        self.author = author
        self.publisher = publisher
        self.publicationDate = publicationDate
        self.categoryName = categoryName
        self.totalPage = totalPage
        self.description = description
        self.readingStatus = readingStatus
    }
}


// MARK: - BookRegistered(등록된 책)
/// 프로토콜) 읽는 중 또는 다읽은 책으로 등록된 책
protocol BookRegistered {
    /// 등록할 책
    var book: Book { get set }
    
    /// 소장여부
    var isMine: Bool { get set }
    
    /// 책유형
    var bookType: BookType { get set }
    
    /// 시작 날짜
    var startDate: Date { get set }
    
    /// 마지막 날짜
    var recentDate: Date { get set }
    
    /// 숨겼는지 여부
    var isHidden: Bool { get set }
    
    /// 대표위치
    var mainLocation: CLLocationCoordinate2D? { get set }
}



/// 구조체) 읽는중, 다읽은 책으로 등록한 책
@Observable
class RegisteredBook: BookRegistered, Identifiable {
    let id = UUID()
    
    var book: Book = InitialBook()
        
    // 책 등록할 때 추가되는 책관련 정보
    var isMine: Bool
    var bookType: BookType
    var startDate: Date
    var recentDate: Date
    var isHidden: Bool
    var mainLocation: CLLocationCoordinate2D?
    
    init(book: Book = InitialBook(),
         isMine: Bool = false,
         bookType: BookType = .paperbook,
         startDate: Date = Date(),
         recentDate: Date = Date(),
         isHidden: Bool = false,
         mainLocation: CLLocationCoordinate2D? = nil) {
        self.book = book
        self.isMine = isMine
        self.bookType = bookType
        self.startDate = startDate
        self.recentDate = recentDate
        self.isHidden = isHidden
        self.mainLocation = mainLocation
    }
    
}



// MARK: - 책관련 열거형 타입들
/// 책종류
enum BookType {
    case paperbook  // 종이책
    case eBook      // 전자책
    case audioBook  // 오디오북
}

/// 독서상태
enum ReadingStatus: Int {
    case unregistered   = -1    // 미등록
    case wantToRead     = 0     // 읽고싶은
    case reading        = 1     // 읽는중
    case finishRead     = 2     // 다읽음
}

/// 카테고리(장르)
enum CategoryName: Int {
    case humanSocial        // 인문사회
    case literature         // 문학
    case essays             // 에세이
    case science            // 과학
    case selfImprovement    // 자기계발
    case art                // 예술
    case foreign            // 원서
    case etc                // 기타
}
