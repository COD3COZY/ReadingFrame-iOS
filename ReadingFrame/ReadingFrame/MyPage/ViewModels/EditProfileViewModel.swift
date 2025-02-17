//
//  EditProfileViewModel.swift
//  ReadingFrame
//
//  Created by 석민솔 on 2/12/25.
//

import Foundation

/// 프로필 수정을 위한 뷰모델
class EditProfileViewModel: ObservableObject {
    // MARK: - Properties
    @Published var profileCharacter: ProfileCharacter
    @Published var nickname: String
    
    // MARK: - init
    init(character: ProfileCharacter, nickname: String) {
        self.profileCharacter = character
        self.nickname = nickname
    }
    
    // MARK: - Methods
    /// 캐릭터 저장 작업하고 결과 리턴
    func saveCharacter(_ character: ProfileCharacter) -> Bool {
        // TODO: 프로필 이미지 변경 API 호출하기
        
        // 호출 결과에 따라 뷰에서 결과 처리
        let testReturn: Bool = true
        
        if testReturn {
            self.profileCharacter = character
            return true
        } else {
            return false
        }
    }
    
    /// 닉네임 저장 작업
    func saveNickname(_ nickname: String) -> Bool {
        print("닉네임 변경하기")
        
        // TODO: 닉네임 중복검사 API 호출
        
        // TODO: 닉네임 중복검사 통과하면 닉네임 변경 API 호출
        
        // 호출 결과에 따라 뷰에서 결과 처리
        let testReturn: Bool = false
        
        if testReturn {
            self.nickname = nickname
            return true
        } else {
            return false
        }
    }
    
    /// 탈퇴하기 처리 후 결과 리턴
    func deleteAccount() -> Bool {
        // TODO: 탈퇴 API 호출하기
        
        // 호출 결과에 따라 뷰에서 결과 처리
        let testReturn: Bool = true
        
        if testReturn {
            // TODO: 탈퇴 처리하기
            // - 토큰 삭제
            // - 계정 삭제
            return true
        } else {
            return false
        }
    }
}
