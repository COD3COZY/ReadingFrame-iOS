//
//  ProfileImage.swift
//  ReadingFrame
//
//  Created by 석민솔 on 2/3/25.
//

import Foundation
import SwiftUI

struct ProfileCharacter {
    var character: ProfileCharacterType
    var color: ThemeColor
}

/// 캐릭터 유형선택용 열거형
enum ProfileCharacterType: String {
    case R = "character_main"
    case A = "character_A"
    case M = "character_M"
    case I = "character_I"
    case P = "character_P"
}


/// 테마 색상 5종
enum ThemeColor {
    case main
    case yellow
    case emerald
    case blue
    case purple
    
    var name: String {
        switch self {
        case .main:
            "main"
        case .yellow:
            "yellow"
        case .emerald:
            "emerald"
        case .blue:
            "blue"
        case .purple:
            "purple0"
        }
    }
    
    var color: Color {
        switch self {
        case .main:
            Color.main
        case .yellow:
            Color.yellow
        case .emerald:
            Color.emerald
        case .blue:
            Color.blue
        case .purple:
            Color.purple0
        }
    }
}

struct ProfileImage {
    /// 색, 캐릭터 입력해서 프로필 코드 (00, 10) 얻기
    static func getProfileImageCode(of character: ProfileCharacter) -> String {
        var profileCode: String
        
        // 선택한 색상에 따라 코드 만들기 시작(첫번째 자리)
        switch character.color {
        case .main:
            profileCode = "0"
        case .yellow:
            profileCode = "1"
        case .emerald:
            profileCode = "2"
        case .blue:
            profileCode = "3"
        case .purple:
            profileCode = "4"
        }
        
        // 선택한 캐릭터에 따라 코드 이어서 만들어주기
        switch character.character {
        case .R:
            profileCode += "0"
        case .A:
            profileCode += "1"
        case .M:
            profileCode += "2"
        case .I:
            profileCode += "3"
        case .P:
            profileCode += "4"
        }
        
        return profileCode
    }
    
    /// 프로필 코드 입력해서 색, 캐릭터 얻기
    static func getProfileColorAndCharacter(profileCode: String) -> ProfileCharacter {
        var color: ThemeColor
        var character: ProfileCharacterType
        
        switch profileCode[profileCode.startIndex] {
        case "0":
            color = .main
        case "1":
            color = .yellow
        case "2":
            color = .emerald
        case "3":
            color = .blue
        case "4":
            color = .purple
        default:
            color = .main
        }
        
        switch profileCode[profileCode.index(after: profileCode.startIndex)] {
        case "0":
            character = ProfileCharacterType.R
        case "1":
            character = ProfileCharacterType.A
        case "2":
            character = ProfileCharacterType.M
        case "3":
            character = ProfileCharacterType.I
        case "4":
            character = ProfileCharacterType.P
        default:
            character = ProfileCharacterType.R
        }
        
        return ProfileCharacter(character: character, color: color)
    }
}
