//
//  MyPageViewModel.swift
//  ReadingFrame
//
//  Created by 석민솔 on 2/3/25.
//

import Foundation
import SwiftUI

/// 마이페이지를 위한 뷰모델
class MyPageViewModel: ObservableObject {
    var nickname: String?
    var badgeCount: Int?
    var profileImage: ProfileCharacter?
    
    init() {
        self.fetchMypageData()
    }

    func fetchMypageData() {
        self.nickname = "닉네임"
        self.badgeCount = 8
        self.profileImage = ProfileImage.getProfileColorAndCharacter(profileCode: "02")
    }
}
