//
//  HTTPHeaderField.swift
//  ReadingFrame
//
//  Created by 이윤지 on 8/20/24.
//

import Foundation

/// HTTP 헤더
enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case xAuthToken = "xAuthToken"
}

enum ContentType: String {
    case json = "Application/json"
}
