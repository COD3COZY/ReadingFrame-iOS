//
//  SignUpNavigationDestination.swift
//  ReadingFrame
//
//  Created by 석민솔 on 2/13/25.
//

import Foundation

/// 회원가입 화면의 네비게이션 스택 관리용 열거형
enum SignUpNavigationDestination: Hashable {
    case enterProfile(data: SignUpInfo)
    
    var identifier: String {
        switch self {
        case .enterProfile:
            "EnterProfile"
        }
    }
}

class SignUpNavigationManager: ObservableObject {
    @Published var path: [SignUpNavigationDestination] = []
}
