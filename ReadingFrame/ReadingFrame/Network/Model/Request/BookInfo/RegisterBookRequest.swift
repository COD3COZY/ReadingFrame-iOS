//
//  RegisterBookRequest.swift
//  ReadingFrame
//
//  Created by 석민솔 on 5/17/25.
//

import Foundation
import MapKit

/// 책등록 request 모델
struct RegisterBookRequest: Encodable {
    let readingStatus: Int
    let bookType: Int
    let mainLocation: LocationDTO?
    let isMine: Bool
    let startDate: String
    let recentDate: String?
    let bookInformation: RegisterBookInfoModel?
}

extension RegisterBookRequest {
    init(
        readingStatus: ReadingStatus,
        bookType: BookType,
        mainLocation: MKPlacemark? = nil,
        isMine: Bool,
        startDate: Date,
        recentDate: Date? = nil,
        bookInformation: RegisterBookInfoModel? = nil
    ) {
        self.readingStatus = readingStatus.rawValue
        self.bookType = bookType.rawValue
        self.isMine = isMine
        self.startDate = DateUtils.dateToString(date: startDate)
        self.recentDate = recentDate.map { DateUtils.dateToString(date: $0) }
        self.bookInformation = bookInformation
        
        self.mainLocation = mainLocation.map {
            LocationDTO(
                placeName: $0.name ?? "",
                address: $0.title ?? "",
                latitude: String($0.coordinate.latitude),
                longitude: String($0.coordinate.longitude)
            )
        }
    }
}

