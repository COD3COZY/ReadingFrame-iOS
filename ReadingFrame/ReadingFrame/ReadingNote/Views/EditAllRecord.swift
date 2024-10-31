//
//  EditAllRecord.swift
//  ReadingFrame
//
//  Created by 이윤지 on 7/8/24.
//

import MCEmojiPicker
import SwiftUI
import MapKit

/// 독서노트의 기록하기 시트 화면
struct EditAllRecord: View {
    /// 책 객체
    @Bindable var book: RegisteredBook
    
    /// picker 메뉴
    var records = ["책갈피", "메모", "인물사전"]
    @State var selectedTab: String = "책갈피"
    
    /// 취소&완료 버튼 클릭 시 sheet 없어지도록 하기 위한 변수
    @Binding var isSheetAppear: Bool
    
    /// Picker 보임 여부
    @State var isPickerAppear: Bool = true
    
    /// 취소 버튼 클릭 시 나타나는 Alert 변수
    @State var isShowCancelAlert: Bool = false
    
    /// 완료 버튼 클릭 시 마지막으로 읽은 페이지가 범위 밖이면 나타나는 Alert 변수
    @State var isShowOutOfRangeAlert: Bool = false
    
    /// 선택한 날짜
    @State private var selectedDate = Date()
    
    /// 날짜 DatePicker가 보이는지에 대한 여부
    @State private var isDatePickerVisible = false
    
    /// 날짜 범위
    var dateRange: ClosedRange<Date> {
        DateRange().dateRange(date: selectedDate)
    }
    
    /// 선택된 위치
    @State private var pickedPlace: MKPlacemark? = nil
    
    /// 사용자가 입력한 책갈피 페이지
    @State private var bookMarkPage: String = ""
    
    /// 사용자가 입력한 메모
    @State private var inputMemo = ""
    
    /// 사용자가 선택한 인물 이모지
    @State private var characterEmoji: String = "😀"
    
    /// 사용자가 입력한 인물 이름
    @State private var characterName: String = ""
    
    /// 사용자가 입력한 한줄 소개
    @State private var characterPreview: String = ""
    
    /// 사용자가 입력한 인물사전 메모
    @State private var characterDescription: String = ""
    
    /// 위치 입력 sheet 띄움 여부를 결정하는 변수
    @State private var showSearchLocation: Bool = false
    
    /// 이모지 피커 띄움 여부를 결정하는 변수
    @State private var isEmojiPickerPresented: Bool = false
    
    /// 완료 버튼 클릭 여부 변수
    @State private var isTapCompleteBtn: Bool = false
    
    /// 완료 버튼 클릭 가능 여부 변수
    private var isEnableComplete: Bool {
        switch selectedTab {
        case "책갈피":
            return !bookMarkPage.isEmpty
        case "메모":
            return !bookMarkPage.isEmpty && !inputMemo.isEmpty
        case "인물사전":
            return !characterName.isEmpty
        default:
            return false
        }
    }
    
    /// 키보드 포커스 여부 변수
    @FocusState private var isFocused: Bool
    
    /// 최대 메모 입력 글자 수
    let limitMemoCount = 1000
    
    /// 최대 한줄 소개 입력 글자 수
    let limitCharacterPreview = 32
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            DragIndicator()
            
            // 상단 정보
            HStack {
                // MARK: 취소 버튼
                Button {
                    // 입력한 값이 있다면
                    if (!bookMarkPage.isEmpty) {
                        isShowCancelAlert.toggle() // sheet 닫기 여부 alert 띄우기
                    }
                    // 입력한 값이 없다면
                    else {
                        isSheetAppear.toggle() // sheet 닫기
                    }
                } label: {
                    Text("취소")
                        .font(.body)
                        .foregroundStyle(Color.main)
                }
                
                Spacer()
                
                if (isPickerAppear) {
                    Text("기록하기")
                        .font(.headline)
                        .foregroundStyle(.black0)
                }
                else {
                    Text("\(selectedTab)")
                        .font(.headline)
                        .foregroundStyle(.black0)
                }
                
                Spacer()
                
                // MARK: 완료 버튼
                Button {
                    isFocused = false // focus 삭제
                    
                    // 책갈피 기록하기 화면이라면
                    if (selectedTab == "책갈피") {
                        // 마지막으로 읽은 페이지가 입력됐다면
                        if (!bookMarkPage.isEmpty) {
                            /// 페이지 비교할 수 있도록 숫자로 변환한 변수
                            let bookMarkLastReadNumber = Int(bookMarkPage) ?? 0
                            
                            // 책종류에 따라 분류: 종이책
                            if book.bookType == .paperbook {
                                // 입력된 페이지 값 검사
                                if (bookMarkLastReadNumber > 0 && bookMarkLastReadNumber <= book.book.totalPage) {
                                    // 정상적인 범위 내의 페이지가 입력되었다면
                                    isSheetAppear.toggle() // sheet 닫기
                                    
                                    isTapCompleteBtn.toggle() // 완료 버튼 클릭
                                } else {
                                    // 범위 밖의 페이지가 입력되었다면 알람 띄워주기
                                    isShowOutOfRangeAlert.toggle()
                                }
                                
                            // 전자책 & 오디오북
                            } else {
                                // 입력된 퍼센트 값 검사
                                if (bookMarkLastReadNumber > 0 && bookMarkLastReadNumber <= 100) {
                                    // 정상적인 범위 내의 퍼센트가 입력되었다면
                                    isSheetAppear.toggle() // sheet 닫기
                                    
                                    isTapCompleteBtn.toggle() // 완료 버튼 클릭
                                } else {
                                    // 범위 밖의 퍼센트가 입력되었다면 알람 띄워주기
                                    isShowOutOfRangeAlert.toggle()
                                }
                            }
                        }
                    }
                    // 메모 기록하기 화면이라면
                    else if (selectedTab == "메모") {
                        // 메모가 입력됐다면
                        if (!inputMemo.isEmpty) {
                            // 마지막으로 읽은 페이지가 입력됐다면
                            if (!bookMarkPage.isEmpty) {
                                /// 페이지 비교할 수 있도록 숫자로 변환한 변수
                                let bookMarkLastReadNumber = Int(bookMarkPage) ?? 0
                                
                                // 책종류에 따라 분류: 종이책
                                if book.bookType == .paperbook {
                                    // 입력된 페이지 값 검사
                                    if (bookMarkLastReadNumber > 0 && bookMarkLastReadNumber <= book.book.totalPage) {
                                        // 정상적인 범위 내의 페이지가 입력되었다면
                                        isSheetAppear.toggle() // sheet 닫기
                                        
                                        isTapCompleteBtn.toggle() // 완료 버튼 클릭
                                    } else {
                                        // 범위 밖의 페이지가 입력되었다면 알람 띄워주기
                                        isShowOutOfRangeAlert.toggle()
                                    }
                                    
                                // 전자책 & 오디오북
                                } else {
                                    // 입력된 퍼센트 값 검사
                                    if (bookMarkLastReadNumber > 0 && bookMarkLastReadNumber <= 100) {
                                        // 정상적인 범위 내의 퍼센트가 입력되었다면
                                        isSheetAppear.toggle() // sheet 닫기
                                        
                                        isTapCompleteBtn.toggle() // 완료 버튼 클릭
                                    } else {
                                        // 범위 밖의 퍼센트가 입력되었다면 알람 띄워주기
                                        isShowOutOfRangeAlert.toggle()
                                    }
                                }
                            }
                        }
                    }
                    // 인물사전 기록하기 화면이라면
                    else {
                        // 인물 이름이 입력됐다면
                        if (!characterName.isEmpty) {
                            isSheetAppear.toggle() // sheet 닫기
                            isTapCompleteBtn.toggle() // 완료 버튼 on
                        }
                    }
                } label: {
                    Text("완료")
                        .font(.body)
                        .fontWeight(.bold)
                        // 필수정보 입력됐으면 accentColor, 아니라면 회색으로
                        .foregroundStyle(isEnableComplete ? .main : .greyText)
                }
                // 필수정보 입력되지 않으면 완료 버튼 비활성화
                .disabled(bookMarkPage.isEmpty)
            }
            .padding(.top, 21)
            // MARK: 취소 버튼 클릭 시 나타나는 Alert
            .alert(
                "저장하지 않고 나가시겠습니까?",
                isPresented: $isShowCancelAlert
            ) {
                Button("아니오", role: .cancel) { }
                
                Button("예", role: .destructive) {
                    isSheetAppear.toggle() // sheet 닫기
                }
            } message: {
                Text("수정된 내용은 반영되지 않습니다.")
            }
            // MARK: 완료 버튼 클릭했는데 입력된 페이지/퍼센트 범위 바깥일 경우 나타나는 Alert
            .alert(
                "읽은 정도를 저장할 수 없습니다.",
                isPresented: $isShowOutOfRangeAlert
            ) {
                Button("확인") {
                    isShowOutOfRangeAlert.toggle() // sheet 닫기
                }
            } message: {
                Text("입력하신 정보를 저장할 수 없습니다. 책의 범위 안에서 입력해주세요.")
            }
            
            // MARK: 상단 Picker
            if (isPickerAppear) {
                Picker("", selection: $selectedTab) {
                    ForEach(records, id: \.self) {
                        Text($0)
                            .font(.headline)
                            .foregroundStyle(.black0)
                    }
                }
                .onChange(of: selectedTab, { oldValue, newValue in
                    // 탭이 바뀔 경우, 기존에 입력된 정보 초기화
                    selectedDate = Date()
                    bookMarkPage = ""
                    inputMemo = ""
                    characterName = ""
                    characterPreview = ""
                    characterDescription = ""
                })
                .pickerStyle(.segmented)
                .padding(.top, 21)
            }

            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    // MARK: - 책갈피
                    // MARK: 필수 정보
                    Text("필수 정보")
                        .font(.footnote)
                        .foregroundStyle(.black0)
                        .padding(.top, 30)
                        .padding(.bottom, 15)
                        .listRowInsets(EdgeInsets())
                    
                    // MARK: 날짜 선택 버튼
                    // 인물사전을 선택하지 않고 있다면, 날짜 박스 띄우기
                    if (selectedTab != "인물사전") {
                        DatePicker(
                            "날짜",
                            selection: $selectedDate,
                            in: dateRange,
                            displayedComponents: .date
                        )
                        .datePickerStyle(.compact)
                        .tint(Color.main)
                        .transition(.opacity)
                        .padding(.vertical, 7)
                        .padding(.horizontal, 16)
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .fill(.white)
                        )
                    }
                    
                    // MARK: 마지막으로 읽은 페이지
                    if (selectedTab == "책갈피") {
                        pageView(book: book, text: "마지막으로 읽은", bookMarkPage: bookMarkPage, isFocused: _isFocused)
                    }
                    
                    // MARK: - 메모
                    if (selectedTab == "메모") {
                        VStack(alignment: .trailing, spacing: 6) {
                            ZStack(alignment: .topLeading) {
                                TextEditor(text: $inputMemo)
                                    .padding(.vertical, 13)
                                    .padding(.horizontal, 16)
                                    .background(.white)
                                    .clipShape(RoundedRectangle(cornerRadius: 15))
                                    .onChange(of: inputMemo) { oldText, newText in
                                        if newText.count > limitMemoCount {
                                            inputMemo = String(newText.prefix(limitMemoCount))
                                        }
                                    }
                                    .frame(height: 300)
                                
                                if inputMemo.isEmpty {
                                    Text("메모")
                                        .foregroundColor(.greyText)
                                        .padding(.horizontal, 20)
                                        .padding(.vertical, 20)
                                }
                            }
                            .background(
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(.white)
                            )
                            
                            Text("(\(inputMemo.count)/\(limitMemoCount))")
                                .font(.footnote)
                                .foregroundStyle(.greyText)
                        }
                        .padding(.top, 10)
                    }
                    
                    // MARK: - 인물사전
                    if (selectedTab == "인물사전") {
                        VStack(alignment: .center, spacing: 15) {
                            // MARK: 이모지
                            Button {
                                isEmojiPickerPresented.toggle()
                            } label: {
                                Text("\(characterEmoji)")
                                    .font(.system(size: 64, weight: .bold))
                            }
                            .emojiPicker(
                                isPresented: $isEmojiPickerPresented,
                                selectedEmoji: $characterEmoji
                            )
                            .frame(width: 64, height: 64, alignment: .center)
                            .padding(28)
                            .background(
                                Circle()
                                    .fill(.white)
                            )
                            
                            // MARK: 인물 이름
                            HStack {
                                Text("이름")
                                
                                TextField("인물 이름", text: $characterName)
                                    .foregroundStyle(.black0)
                                    .multilineTextAlignment(.trailing)
                                    .focused($isFocused)
                                    .onAppear {
                                        DispatchQueue.main.async {
                                            isFocused = false
                                        }
                                    }
                            }
                            .padding(.vertical, 13)
                            .padding(.leading, 16)
                            .padding(.trailing, 20)
                            .background(
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(.white)
                            )
                        }
                    }
                    
                    // MARK: 선택 정보
                    Text("선택 정보")
                        .font(.footnote)
                        .foregroundStyle(.black0)
                        .padding(.top, 30)
                        .padding(.bottom, 15)
                        .listRowInsets(EdgeInsets())
                    
                    // MARK: 위치 등록 버튼
                    if (selectedTab == "책갈피") {
                        Button {
                            showSearchLocation.toggle() // 위치 등록 sheet 띄우기
                            isFocused.toggle() // textfield 포커스 삭제
                        } label: {
                            Text("책갈피한 위치")
                                .foregroundStyle(.greyText)
                            Spacer()
                        }
                        .padding(.vertical, 13)
                        .padding(.horizontal, 16)
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .fill(.white)
                        )
                        .sheet(isPresented: $showSearchLocation) {
                            // 위치 등록 화면으로 이동
                            SearchLocation(showingSearchLocation: $showSearchLocation, pickedPlaceMark: $pickedPlace)
                        }
                    }
                    
                    // MARK: 메모 페이지
                    if (selectedTab == "메모") {
                        pageView(book: book, text: "페이지", bookMarkPage: bookMarkPage, isFocused: _isFocused)
                    }
                    
                    if (selectedTab == "인물사전") {
                        // MARK: 한줄 소개
                        VStack(alignment: .trailing, spacing: 6) {
                            TextField("한줄소개", text: $characterPreview)
                                .foregroundStyle(.black0)
                                .multilineTextAlignment(.leading)
                                .focused($isFocused)
                                .onAppear {
                                    DispatchQueue.main.async {
                                        isFocused = false
                                    }
                                }
                                .onChange(of: characterPreview) { oldText, newText in
                                    if newText.count > limitCharacterPreview {
                                        characterPreview = String(newText.prefix(limitCharacterPreview))
                                    }
                                }
                                .padding(.vertical, 13)
                                .padding(.leading, 16)
                                .padding(.trailing, 20)
                                .background(
                                    RoundedRectangle(cornerRadius: 15)
                                        .fill(.white)
                                )
                            
                            Text("(\(characterPreview.count)/\(limitCharacterPreview))")
                                .font(.footnote)
                                .foregroundStyle(.greyText)
                        }
                        
                        // MARK: 메모
                        ZStack(alignment: .topLeading) {
                            TextEditor(text: $characterDescription)
                                .foregroundStyle(.black0)
                                .focused($isFocused)
                                .onAppear {
                                    DispatchQueue.main.async {
                                        isFocused = false
                                    }
                                }
                                .onChange(of: characterDescription) { oldText, newText in
                                    if newText.count > limitMemoCount {
                                        characterDescription = String(newText.prefix(limitMemoCount))
                                    }
                                }
                                .padding(.vertical, 13)
                                .padding(.horizontal, 16)
                                .background(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                                .frame(height: 300)
                            
                            if characterDescription.isEmpty {
                                Text("메모")
                                    .foregroundColor(.grey2)
                                    .padding(.vertical, 20)
                                    .padding(.horizontal, 20)
                            }
                        }
                        .padding(.top, 15)
                        .padding(.bottom, 40)
                    }
                    
                    Spacer()
                    Spacer()
                }
            }
            .scrollIndicators(.never)
        }
        .padding(.horizontal, 16)
        .background(
            RoundedRadiusBox(radius: 15, corners: [.topLeft, .topRight])
                .fill(.grey1)
        )
        .ignoresSafeArea(edges: .bottom)
    }
}

/// 페이지 입력 필드
struct pageView: View {
    var book: RegisteredBook
    var text: String
    @State var bookMarkPage: String
    @FocusState var isFocused: Bool
    
    var body: some View {
        VStack {
            HStack {
                Text(text)
                
                // 종이책이면 ~\(totalPage), 전자책 오디오북이면 0~100
                TextField(book.bookType == .paperbook ? "~\(book.book.totalPage)" : "0~100", text: $bookMarkPage)
                    .keyboardType(.numberPad) // 텍스트필드 눌렀을 때 숫자 키보드 뜨도록 함
                    .foregroundStyle(.black0)
                    .multilineTextAlignment(.trailing)
                    .focused($isFocused)
                    .onAppear {
                        DispatchQueue.main.async {
                            isFocused = false
                        }
                    }
                
                // 종이책이면 p, 전자책 오디오북이면 %
                Text(book.bookType == .paperbook ? "p" : "%")
            }
        }
        .padding(.vertical, 13)
        .padding(.leading, 16)
        .padding(.trailing, 20)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(.white)
        )
        .padding(.top, 10)
    }
}

#Preview {
    EditAllRecord(book: RegisteredBook(), isSheetAppear: .constant(false))
}
