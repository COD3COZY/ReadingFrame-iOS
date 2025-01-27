//
//  EditAllRecordViewModel.swift
//  ReadingFrame
//
//  Created by 석민솔 on 12/23/24.
//

import Foundation
import MapKit

class EditAllRecordViewModel: ObservableObject {
    // MARK: - Properties
    /// 책 객체
    @Published var book: EditRecordBookModel

    /// 책갈피 / 메모 / 인물사전 결정하는 탭
    @Published var selectedTab: String = "책갈피"
    
    /// 선택한 날짜
    @Published var selectedDate = Date()
    
    /// 날짜 범위
    var dateRange: ClosedRange<Date> {
        DateRange().dateRange(date: selectedDate)
    }
    
    // MARK: 책갈피 관련
    /// 선택된 위치
    @Published var pickedPlace: MKPlacemark? = nil
    
    /// 사용자가 입력한 책갈피 페이지
    @Published var bookMarkPage: String = ""
    
    // MARK: 메모 관련
    /// 사용자가 입력한 메모
    @Published var inputMemo = ""
    
    // MARK: 인물사전 관련
    /// 사용자가 선택한 인물 이모지
    @Published var characterEmoji: String = "😀"
    
    /// 사용자가 입력한 인물 이름
    @Published var characterName: String = ""
    
    /// 사용자가 입력한 한줄 소개
    @Published var characterPreview: String = ""
    
    /// 사용자가 입력한 인물사전 메모
    @Published var characterDescription: String = ""
    
    // MARK: 수정 관련
    /// 등록/수정 중 어떤 걸 위한 화면인지를 결정해주는 변수
    /// - API 호출 시 POST / PATCH 구분을 위함
    /// - 기본값은 등록, 수정하는 화면이라면 True 입력해주면 됩니다
    @Published var isForEditing: Bool = false
    
    // 수정 시, 값 변경 감지를 위해 비교할 초기값을 저장하기 위한 프로퍼티들
    // 책갈피
    private var initialBookMarkPage: String = ""
    private var initialPickedPlace: MKPlacemark? = nil
    // 메모
    private var initialInputMemo: String = ""
    // 인물사전
    private var initialCharacterName: String = ""
    private var initialCharacterPreview: String = ""
    private var initialCharacterDescription: String = ""
    private var initialCharacterEmoji: String = "😀"
    // 공통(책갈피&메모)
    private var initialSelectedDate: Date = Date()
    
    
    // MARK: - init
    init(
        book: EditRecordBookModel,
        selectedTab: String = "책갈피",
        isForEditing: Bool = false,
        selectedDate: Date = Date(),
        pickedPlace: MKPlacemark? = nil,
        bookMarkPage: String = "",
        inputMemo: String = "",
        characterEmoji: String = "😀",
        characterName: String = "",
        characterPreview: String = "",
        characterDescription: String = ""
    ) {
        self.book = book
        self.selectedTab = selectedTab
        self.isForEditing = isForEditing
        self.selectedDate = selectedDate
        self.pickedPlace = pickedPlace
        self.bookMarkPage = bookMarkPage
        self.inputMemo = inputMemo
        self.characterEmoji = characterEmoji
        self.characterName = characterName
        self.characterPreview = characterPreview
        self.characterDescription = characterDescription
        
        // 수정 모드일 때 초기값 저장
        if isForEditing {
            self.initialBookMarkPage = bookMarkPage
            self.initialInputMemo = inputMemo
            self.initialCharacterName = characterName
            self.initialCharacterPreview = characterPreview
            self.initialCharacterDescription = characterDescription
            self.initialPickedPlace = pickedPlace
            self.initialSelectedDate = selectedDate
            self.initialCharacterEmoji = characterEmoji
        }
    }
    
    // MARK: Methods
    /// 탭이 바뀔 경우, 기존에 입력된 정보 초기화시키기
    func changeTab() {
        self.selectedDate = Date()
        self.bookMarkPage = ""
        self.inputMemo = ""
        self.characterName = ""
        self.characterPreview = ""
        self.characterDescription = ""
    }
    
    /// 완료 버튼 눌렀을 때 호출해야 할 동작 지정해주기
    /// - 책갈피, 메모, 인물사전 각각 등록일 수도 있고 수정일 수도 있음 이 때 어떤 API를 호출해야하는지 길잡이
    func uploadReadingRecord() {
        switch selectedTab {
        case RecordType.bookmark.rawValue:
            if isForEditing {
                // TODO: 책갈피 PATCH API 호출하기
                print("책갈피 PATCH API 호출")
            }
            else {
                // TODO: 책갈피 POST API 호출하기
                print("책갈피 POST API 호출")
            }
        case RecordType.memo.rawValue:
            if isForEditing {
                // TODO: 메모 PATCH API 호출하기
                print("메모 PATCH API 호출")
            }
            else {
                // TODO: 메모 POST API 호출하기
                print("메모 POST API 호출")
            }
        case RecordType.character.rawValue:
            if isForEditing {
                // TODO: 인물사전 PATCH API 호출하기
                print("인물사전 PATCH API 호출")
            }
            else {
                // TODO: 인물사전 POST API 호출하기
                print("인물사전 POST API 호출")
            }
        default: break
        }
    }
    
    /// 수정모드일 때 현재값이 초기값과 다른지 확인하는 메서드
    /// - 수정모드일 때 필요
    /// - 완료 버튼 활성화 여부 체크를 위해
    func isContentChanged() -> Bool {
        if isForEditing {
            switch selectedTab {
            // 책갈피
            case RecordType.bookmark.rawValue:
                return bookMarkPage != initialBookMarkPage ||
                pickedPlace != initialPickedPlace ||
                !Calendar.current.isDate(selectedDate, inSameDayAs: initialSelectedDate)
                
            // 메모
            case RecordType.memo.rawValue:
                return inputMemo != initialInputMemo ||
                bookMarkPage != initialBookMarkPage ||
                !Calendar.current.isDate(selectedDate, inSameDayAs: initialSelectedDate)
            
            // 인물사전
            case RecordType.character.rawValue:
                return characterName != initialCharacterName ||
                characterPreview != initialCharacterPreview ||
                characterDescription != initialCharacterDescription ||
                characterEmoji != initialCharacterEmoji
                
            default:
                return false
            }
        } else { return false }
    }
}

// MARK: Validation Methods
extension EditAllRecordViewModel {
    /// 입력된 페이지/퍼센트가 유효한 범위인지 검사
    func isValidPageNumber(_ pageNumber: Int) -> Bool {
        // 종이책일 때 전체 페이지 안에 해당하는지
        if book.bookType == .paperbook {
            return pageNumber > 0 && pageNumber <= book.totalPage
        // 전자책/오디오북일 때는 100퍼센트 안에 해당하는지 검사
        } else {
            return pageNumber > 0 && pageNumber <= 100
        }
    }
    
    /// 현재 입력된 정보를 검증하고 업로드하기
    /// - 검증 성공 여부 업로드
    func validateAndUpload() -> Bool {
        // 페이지/퍼센트가 입력되어 있는 경우 범위 검사
        if !bookMarkPage.isEmpty {
            guard let pageNumber = Int(bookMarkPage),
                  isValidPageNumber(pageNumber) else {
                return false
            }
        }
        
        // 각 탭별 필수 입력값 검증
        let isValid = isRequiredFieldsFilled()
        
        if isValid {
            uploadReadingRecord()
        }
        
        return isValid
    }
    
    /// 작성하고 있는 기록 종류에 따라 필수 항목이 작성되었는지 확인
    func isRequiredFieldsFilled() -> Bool {
        switch selectedTab {
        case RecordType.bookmark.rawValue:
            !bookMarkPage.isEmpty
        case RecordType.memo.rawValue:
            !inputMemo.isEmpty
        case RecordType.character.rawValue:
            !characterName.isEmpty
        default:
            false
        }
    }
    
    /// 사용자가 기록 종류 상관없이 어떤 값이든 입력한 게 있는지 확인
    func isSomethingFilled() -> Bool {
        return !bookMarkPage.isEmpty ||
        !inputMemo.isEmpty ||
        !characterName.isEmpty ||
        !characterPreview.isEmpty ||
        !characterDescription.isEmpty ||
        pickedPlace != nil
    }
}
