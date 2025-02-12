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
    func saveNickname(_ nickname: String) {
        print("캐릭터 저장하기")
        self.nickname = nickname
    }
}
