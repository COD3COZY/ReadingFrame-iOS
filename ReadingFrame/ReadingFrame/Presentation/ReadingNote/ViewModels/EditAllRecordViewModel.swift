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
    @Published var selectedTab: String
    
    /// 선택한 날짜
    @Published var selectedDate: Date = Date()
    
    /// 날짜 범위
    var dateRange: ClosedRange<Date> {
        DateUtils().dateRange(date: selectedDate)
    }
    
    // MARK: 책갈피 관련
    /// 선택된 위치
    /// - 새로 선택하거나 변경해서 전달할 위치 정보를 위한 변수
    @Published var pickedPlace: MKPlacemark? = nil
    
    
    /// 책갈피 위치 선택 필드에 보여줄 텍스트
    /// - pickedPlace가 있을 때는(현재 화면에서 SearchLocation을 활용해서 새로운 위치 선택했을 때) 해당하는 위치명
    /// - BE에서 받아온 위치가 있다면(수정모드이고, 기존에 작성해둔 위치가 있다면) 해당하는 위치명
    /// - 없을 때는 기본 placeholder
    var placeText: String {
        if let placeName = pickedPlace?.name { return placeName }
        else if isForEditing, let placeName = bookmarkEditInfo?.location?.placeName { return placeName }
        else { return "책갈피한 위치" }
    }
    
    /// 사용자가 입력한 책갈피 페이지
    @Published var bookMarkPage: String = ""
    
    // MARK: 메모 관련
    /// 사용자가 입력한 메모
    @Published var inputMemo: String = ""
    
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
        
    // 수정모드일 때 BE에서 받아올 기존 기록 데이터
    var bookmarkEditInfo: Bookmark?
    var memoEditInfo: Memo?
    var characterEditInfo: Character?
    
    
    // MARK: - init
    init(
        // 공통
        book: EditRecordBookModel,
        selectedTab: String = "책갈피",
        isForEditing: Bool = false,
        // selectedTab에 따라 입력될 정보
        bookmarkEditInfo: Bookmark? = nil,
        memoEditInfo: Memo? = nil,
        characterEditInfo: Character? = nil
    ) {
        // 공통
        self.book = book
        self.selectedTab = selectedTab
        self.isForEditing = isForEditing
        
        // 수정모드: 입력받은 값대로 초기화
        if isForEditing {
            switch selectedTab {
            // 책갈피탭
            case RecordType.bookmark.rawValue:
                self.bookmarkEditInfo = bookmarkEditInfo
                
                // bookMarkPage: 책종류에 따라 페이지/퍼센트 지정
                if let bookmarkPage = {
                    book.bookType == .paperbook
                    ? String(bookmarkEditInfo!.markPage)
                    : String(bookmarkEditInfo!.markPercent)
                }() {
                    self.bookMarkPage = bookmarkPage
                }
                
                // selectedDate
                self.selectedDate = bookmarkEditInfo!.date
                                
            // 메모탭
            case RecordType.memo.rawValue:
                self.memoEditInfo = memoEditInfo
                
                // inputMemo
                self.inputMemo = memoEditInfo!.memo
                
                // selectedDate
                self.selectedDate = memoEditInfo!.date
                
                // 선택값) bookmarkPage: 책종류에 따라 페이지/퍼센트 지정
                guard let markPage = memoEditInfo?.markPage,
                      let markPercent = memoEditInfo?.markPercent else { break }
                
                let bookmarkPage = book.bookType == .paperbook ? String(markPage) : String(markPercent)
                self.bookMarkPage = bookmarkPage
                
            // 인물사전탭
            case RecordType.character.rawValue:
                self.characterEditInfo = characterEditInfo
                
                // characterEmoji
                self.characterEmoji = String(UnicodeScalar(characterEditInfo!.emoji)!)
                
                // characterName
                self.characterName = characterEditInfo!.name
                
                // 선택값) characterPreview
                if let preview = characterEditInfo?.preview {
                    self.characterPreview = preview
                }
                // 선택값) characterDescription
                if let desc = characterEditInfo?.description {
                    self.characterDescription = desc
                }
                
            default: break
            }
        }
        // 생성모드: 기본값 초기화
        else {
            self.selectedDate = Date()
            self.pickedPlace = nil
            self.bookMarkPage = ""
            self.inputMemo = ""
            self.characterEmoji = "😀"
            self.characterName = ""
            self.characterPreview = ""
            self.characterDescription = ""
        }
    }
    
    // MARK: - Methods
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
                // MARK: 책갈피 PATCH API 호출하기
                print("책갈피 PATCH API 호출")
                
                guard let bookmarkID = bookmarkEditInfo?.id else {
                    print("바꿀 책갈피가 없어요")
                    return
                }
                
                editBookmark(
                    isbn: self.book.isbn,
                    request: PatchBookmarkRequest(
                        date: DateUtils.dateToString(date: selectedDate),
                        markPage: Int(self.bookMarkPage) ?? 0,
                        mainLocation: getSelectedLocationInfo(),
                        uuid: bookmarkID
                    )
                ) { success in
                    if !success {
                        print("책갈피 수정 실패")
                    }
                }
            }
            else {
                // MARK: 책갈피 POST API 호출하기
                print("책갈피 POST API 호출")
                
                registerBookmark(
                    isbn: self.book.isbn,
                    request: PostNewBookmarkRequest(
                        date: DateUtils.dateToString(date: selectedDate),
                        markPage: Int(self.bookMarkPage) ?? 0,
                        mainLocation: getSelectedLocationInfo()
                    )
                ) { success in
                    if success {
                        // 책갈피 등록 성공
                    } else {
                        print("책갈피 등록 실패")
                    }
                }
            }
            
        case RecordType.memo.rawValue:
            if isForEditing {
                // TODO: 메모 PATCH API 호출하기
                print("메모 PATCH API 호출")
            }
            else {
                // MARK: 메모 POST API 호출하기
                print("메모 POST API 호출")
                
                postMemo(
                    isbn: self.book.isbn,
                    request: PostNewMemoRequest(
                        date: DateUtils.dateToString(date: selectedDate),
                        markPage: Int(self.bookMarkPage),
                        memoText: self.inputMemo
                    )
                ) { success in
                    if !success {
                        print("메모 등록 실패")
                    }
                }
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
                let initialBookMarkPage = book.bookType == .paperbook
                ? String(bookmarkEditInfo!.markPage)
                : String(bookmarkEditInfo!.markPercent)
                
                return bookMarkPage != initialBookMarkPage ||
                pickedPlace != nil ||
                !Calendar.current.isDate(selectedDate, inSameDayAs: bookmarkEditInfo!.date)
                
            // 메모
            case RecordType.memo.rawValue:
                var initialBookMarkPage: String = ""
                if let markPage = memoEditInfo?.markPage,
                   let markPercent = memoEditInfo?.markPercent {
                    
                    initialBookMarkPage = book.bookType == .paperbook
                    ? String(markPage)
                    : String(markPercent)
                }
                
                return inputMemo != memoEditInfo!.memo ||
                bookMarkPage != initialBookMarkPage ||
                !Calendar.current.isDate(selectedDate, inSameDayAs: memoEditInfo!.date)
                
                
            
            // 인물사전
            case RecordType.character.rawValue:
                return characterName != characterEditInfo!.name ||
                characterPreview != characterEditInfo!.preview ||
                characterDescription != characterEditInfo!.description ||
                characterEmoji != String(UnicodeScalar(characterEditInfo!.emoji)!)
                
            default:
                return false
            }
        } else { return false }
    }
    
    /// 위치 객체 만들기
    func getSelectedLocationInfo() -> LocationDTO? {
        if let placemark = self.pickedPlace {
            return LocationDTO(placeName: placemark.name ?? "",
                             address: placemark.title ?? "",
                             latitude: String(placemark.coordinate.latitude),
                             longitude: String(placemark.coordinate.longitude))
        } else { return nil }
    }
}

// MARK: Networking
extension EditAllRecordViewModel {
    /// 새로운 책갈피 등록 API
    func registerBookmark(isbn: String, request: PostNewBookmarkRequest, completion: @escaping (Bool) -> (Void)) {
        EditAllRecordAPI.shared.postNewBookmark(
            isbn: isbn,
            request: request
        ) { response in
            switch response {
            case .success(let data):
                print("새로운 책갈피 등록 성공 \(data)")
                completion(true)
            case .requestErr(let message):
                print("Request Err: \(message)")
                completion(false)
            case .pathErr:
                print("Path Err")
                completion(false)
            case .serverErr(let message):
                print("Server Err: \(message)")
                completion(false)
            case .networkFail(let message):
                print("Network Err: \(message)")
                completion(false)
            case .unknown(let error):
                print("Unknown Err: \(error)")
                completion(false)
            }
        }
    }
    
    /// 책갈피 수정 API
    func editBookmark(isbn: String, request: PatchBookmarkRequest, completion: @escaping (Bool) -> (Void)) {
        EditAllRecordAPI.shared.patchBookmark(
            isbn: isbn,
            request: request
        ) { response in
            switch response {
            case .success(let data):
                print("책갈피 수정 성공 \(data)")
                completion(true)
            case .requestErr(let message):
                print("Request Err: \(message)")
                completion(false)
            case .pathErr:
                print("Path Err")
                completion(false)
            case .serverErr(let message):
                print("Server Err: \(message)")
                completion(false)
            case .networkFail(let message):
                print("Network Err: \(message)")
                completion(false)
            case .unknown(let error):
                print("Unknown Err: \(error)")
                completion(false)
            }
        }
    }
    
    /// 메모 등록 API
    func postMemo(isbn: String, request: PostNewMemoRequest, completion: @escaping (Bool) -> (Void)) {
        EditAllRecordAPI.shared.postNewMemo(
            isbn: isbn,
            request: request
        ) { response in
            switch response {
            case .success(let data):
                print("새로운 메모 등록 성공 \(data)")
                completion(true)
            case .requestErr(let message):
                print("Request Err: \(message)")
                completion(false)
            case .pathErr:
                print("Path Err")
                completion(false)
            case .serverErr(let message):
                print("Server Err: \(message)")
                completion(false)
            case .networkFail(let message):
                print("Network Err: \(message)")
                completion(false)
            case .unknown(let error):
                print("Unknown Err: \(error)")
                completion(false)
            }
        }
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
