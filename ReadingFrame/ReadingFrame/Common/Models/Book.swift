//
//  Book.swift
//  ReadingFrame
//
//  Created by 석민솔 on 2/13/24.
//

import Foundation
import CoreLocation

/// 기본책(미등록, 읽고싶은)
class Book: Identifiable {
    
    var ISBN: String                = "0000000000000"
    var cover: String               = "https://dummyImage"
    var title: String               = "책제목"
    var author: String              = "저자이름"
    var publisher: String           = "출판사이름"
    var publicationDate: Date       = Date()
    var categoryName: CategoryName  = .humanSocial
    var totalPage: Int              = 200
    var description: String         = "노르웨이 작가 욘 포세가 2000년 발표한 소설로, 인간 존재의 반복되는 서사, 생의 시작과 끝을 독특한 문체에 압축적으로 담아낸 작품이다. 고독하고 황량한 피오르를 배경으로 요한네스라는 이름의 평범한 어부가 태어나고 또 죽음을 향해 다가가는 과정을 꾸밈없이 담담하게 이야기한다."
    var readingStatus: ReadingStatus = .unregistered
    
    // 생성자
    init(ISBN: String, cover: String, title: String, 
         author: String, publisher: String, publicationDate: Date,
         categoryName: CategoryName, totalPage: Int, readingStatus: ReadingStatus) {
        self.ISBN = ISBN
        self.cover = cover
        self.title = title
        self.author = author
        self.publisher = publisher
        self.publicationDate = publicationDate
        self.categoryName = categoryName
        self.totalPage = totalPage
        self.readingStatus = readingStatus
    }
    
    // 홈 화면에서 사용되는 생성자
    init(ISBN: String, cover: String, title: String, author: String, readingStatus: ReadingStatus) {
        self.ISBN = ISBN
        self.cover = cover
        self.title = title
        self.author = author
        self.readingStatus = readingStatus
    }
    
}

// 기본 Book 객체
let defaultBook = Book(
    ISBN: "1234", cover: "https://image.aladin.co.kr/product/30768/99/cover500/k252830652_2.jpg",
    title: "나미야 잡화점의 기적",
    author: "히가시노 게이고",
    publisher: "현대문학",
    publicationDate: Date(),
    categoryName: .literature,
    totalPage: 456,
    readingStatus: .wantToRead
)

/// 읽는중, 다읽은 책으로 등록한 책
class RegisteredBook: Book {
    var isMine: Bool        = false
    var bookType: BookType  = .paperbook
    var startDate: Date     = Date()
    var recentDate: Date    = Date()
    var isHidden: Bool      = false
    var mainLocation: CLLocationCoordinate2D?
    
    init(registerBook: Book, isMine: Bool, bookType: BookType, startDate: Date, recentDate: Date, isHidden: Bool, mainLocation: CLLocationCoordinate2D? = nil) {
        self.isMine = isMine
        self.bookType = bookType
        self.startDate = startDate
        self.recentDate = recentDate
        self.isHidden = isHidden
        self.mainLocation = mainLocation
        
        super.init(
            ISBN: registerBook.ISBN,
            cover: registerBook.cover,
            title: registerBook.title,
            author: registerBook.author,
            publisher: registerBook.publisher,
            publicationDate: registerBook.publicationDate,
            categoryName: registerBook.categoryName,
            totalPage: registerBook.totalPage,
            readingStatus: registerBook.readingStatus)
    }
    
    // 홈 화면에서 사용되는 생성자
    init(registerBook: Book, isMine: Bool, isHidden: Bool) {
        self.isMine = isMine
        self.isHidden = isHidden
            
        super.init(ISBN: registerBook.ISBN, cover: registerBook.cover, title: registerBook.title, author: registerBook.author, readingStatus: registerBook.readingStatus)
    }
    
    // 기본 Book 객체
    static let defaultRegisteredBook = RegisteredBook(
        registerBook: defaultBook,
        isMine: false,
        bookType: .paperbook,
        startDate: Date.now,
        recentDate: Date.now,
        isHidden: false
    )
}


// 책종류
enum BookType {
    case paperbook  // 종이책
    case eBook      // 전자책
    case audioBook  // 오디오북
}

// 독서상태
enum ReadingStatus: Int {
    case unregistered   = -1    // 미등록
    case wantToRead     = 0     // 읽고싶은
    case reading        = 1     // 읽는중
    case finishRead     = 2     // 다읽음
}

// 카테고리(장르)
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
