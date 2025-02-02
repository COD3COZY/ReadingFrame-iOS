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
    // MARK: - Properties
    @StateObject var vm: EditAllRecordViewModel
    
    
    // MARK: 뷰 조작용으로 활용되는 변수들
    /// picker 메뉴
    var recordTypes = ["책갈피", "메모", "인물사전"]
    
    /// 취소&완료 버튼 클릭 시 sheet 없어지도록 하기 위한 변수
    @Binding var isSheetAppear: Bool
    
    /// Picker 보임 여부
    var isPickerAppear: Bool = true
    
    /// 취소 버튼 클릭 시 나타나는 Alert 변수
    @State var isShowCancelAlert: Bool = false
    
    /// 완료 버튼 클릭 시 마지막으로 읽은 페이지가 범위 밖이면 나타나는 Alert 변수
    @State var isShowOutOfRangeAlert: Bool = false
    
    /// 날짜 DatePicker가 보이는지에 대한 여부
    @State private var isDatePickerVisible = false
    
    /// 위치 입력 sheet 띄움 여부를 결정하는 변수
    @State private var showSearchLocation: Bool = false
    
    /// 이모지 피커 띄움 여부를 결정하는 변수
    @State private var isEmojiPickerPresented: Bool = false
    
//    /// 완료 버튼 클릭 여부 변수
//    @State private var isTapCompleteBtn: Bool = false
    
    /// 완료 버튼 클릭 가능 여부 변수
    private var isEnableComplete: Bool {
        if vm.isForEditing {
            // 수정 모드면 필수작성 필드 채워졌는지 && 입력값 바뀌었는지 확인
            return vm.isContentChanged() && vm.isRequiredFieldsFilled()
        } else {
            // 초기작성 모드면 필수작성 필드 채워졌는지 확인
            return vm.isRequiredFieldsFilled()
        }
    }
    
    /// 키보드 포커스 여부 변수
    @FocusState private var isFocused: Bool
    
    /// 최대 메모 입력 글자 수
    let limitMemoCount = 1000
    
    /// 최대 한줄 소개 입력 글자 수
    let limitCharacterPreview = 32
    
    
    // MARK: - init
    init(
        book: EditRecordBookModel,
        isSheetAppear: Binding<Bool>,
        selectedTab: String = "책갈피",
        isForEditing: Bool = false,
        bookmarkEditInfo: Bookmark? = nil,
        memoEditInfo: Memo? = nil,
        characterEditInfo: Character? = nil,
        isPickerAppear: Bool
    ) {
        self._isSheetAppear = isSheetAppear
        self._vm = StateObject(
            wrappedValue: EditAllRecordViewModel(
                book: book,
                selectedTab: selectedTab,
                isForEditing: isForEditing,
                bookmarkEditInfo: bookmarkEditInfo,
                memoEditInfo: memoEditInfo,
                characterEditInfo: characterEditInfo
            )
        )
        self.isPickerAppear = isPickerAppear
    }
    
    
    // MARK: - View
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            DragIndicator()
            
            // 상단 정보
            topBar
            
            // MARK: 상단 Picker
            if (isPickerAppear) {
                Picker("", selection: $vm.selectedTab) {
                    ForEach(recordTypes, id: \.self) {
                        Text($0)
                            .font(.headline)
                            .foregroundStyle(.black0)
                    }
                }
                .onChange(of: vm.selectedTab, { oldValue, newValue in
                    // 탭이 바뀔 경우, 기존에 입력된 정보 초기화
                    vm.changeTab()
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
                    if (vm.selectedTab != "인물사전") {
                        DatePicker(
                            "날짜",
                            selection: $vm.selectedDate,
                            in: vm.dateRange,
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
                    if (vm.selectedTab == "책갈피") {
                        pageView(text: "마지막으로 읽은")
                    }
                    
                    // MARK: - 메모
                    if (vm.selectedTab == "메모") {
                        VStack(alignment: .trailing, spacing: 6) {
                            ZStack(alignment: .topLeading) {
                                TextEditor(text: $vm.inputMemo)
                                    .padding(.vertical, 13)
                                    .padding(.horizontal, 16)
                                    .background(.white)
                                    .clipShape(RoundedRectangle(cornerRadius: 15))
                                    .onChange(of: vm.inputMemo) { oldText, newText in
                                        if newText.count > limitMemoCount {
                                            vm.inputMemo = String(newText.prefix(limitMemoCount))
                                        }
                                    }
                                    .frame(height: 300)
                                
                                if vm.inputMemo.isEmpty {
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
                            
                            Text("(\(vm.inputMemo.count)/\(limitMemoCount))")
                                .font(.footnote)
                                .foregroundStyle(.greyText)
                        }
                        .padding(.top, 10)
                    }
                    
                    // MARK: - 인물사전
                    if (vm.selectedTab == "인물사전") {
                        VStack(alignment: .center, spacing: 15) {
                            // MARK: 이모지
                            Button {
                                isEmojiPickerPresented.toggle()
                            } label: {
                                Text("\(vm.characterEmoji)")
                                    .font(.system(size: 64, weight: .bold))
                            }
                            .emojiPicker(
                                isPresented: $isEmojiPickerPresented,
                                selectedEmoji: $vm.characterEmoji
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
                                
                                TextField("인물 이름", text: $vm.characterName)
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
                    if (vm.selectedTab == "책갈피") {
                        Button {
                            showSearchLocation.toggle() // 위치 등록 sheet 띄우기
                            isFocused.toggle() // textfield 포커스 삭제
                        } label: {
                            Text(vm.placeText)
                                .foregroundStyle(vm.placeText == "책갈피한 위치"
                                                 ? .greyText
                                                 : .black0)
                            
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
                            SearchLocation(showingSearchLocation: $showSearchLocation, pickedPlaceMark: $vm.pickedPlace)
                        }
                    }
                    
                    // MARK: 메모 페이지
                    if (vm.selectedTab == "메모") {
                        pageView(text: "페이지")
                    }
                    
                    if (vm.selectedTab == "인물사전") {
                        // MARK: 한줄 소개
                        VStack(alignment: .trailing, spacing: 6) {
                            TextField("한줄소개", text: $vm.characterPreview)
                                .foregroundStyle(.black0)
                                .multilineTextAlignment(.leading)
                                .focused($isFocused)
                                .onAppear {
                                    DispatchQueue.main.async {
                                        isFocused = false
                                    }
                                }
                                .onChange(of: vm.characterPreview) { oldText, newText in
                                    if newText.count > limitCharacterPreview {
                                        vm.characterPreview = String(newText.prefix(limitCharacterPreview))
                                    }
                                }
                                .padding(.vertical, 13)
                                .padding(.leading, 16)
                                .padding(.trailing, 20)
                                .background(
                                    RoundedRectangle(cornerRadius: 15)
                                        .fill(.white)
                                )
                            
                            Text("(\(vm.characterPreview.count)/\(limitCharacterPreview))")
                                .font(.footnote)
                                .foregroundStyle(.greyText)
                        }
                        
                        // MARK: 메모
                        ZStack(alignment: .topLeading) {
                            TextEditor(text: $vm.characterDescription)
                                .foregroundStyle(.black0)
                                .focused($isFocused)
                                .onAppear {
                                    DispatchQueue.main.async {
                                        isFocused = false
                                    }
                                }
                                .onChange(of: vm.characterDescription) { oldText, newText in
                                    if newText.count > limitMemoCount {
                                        vm.characterDescription = String(newText.prefix(limitMemoCount))
                                    }
                                }
                                .padding(.vertical, 13)
                                .padding(.horizontal, 16)
                                .background(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                                .frame(height: 300)
                            
                            if vm.characterDescription.isEmpty {
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
extension EditAllRecord {
    @ViewBuilder
    private func pageView(text: String) -> some View {
        VStack {
            HStack {
                Text(text)
                
                // 종이책이면 ~\(totalPage), 전자책 오디오북이면 0~100
                TextField(vm.book.bookType == .paperbook ? "~\(vm.book.totalPage)" : "0~100", text: $vm.bookMarkPage)
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
                Text(vm.book.bookType == .paperbook ? "p" : "%")
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

// MARK: - Components
extension EditAllRecord {
    // MARK: 상단 제목 바
    private var topBar: some View {
        HStack {
            // 취소 버튼
            cancelButton
            
            Spacer()
            
            if (isPickerAppear) {
                Text("기록하기")
                    .font(.headline)
                    .foregroundStyle(.black0)
            }
            else {
                Text("\(vm.selectedTab)")
                    .font(.headline)
                    .foregroundStyle(.black0)
            }
            
            Spacer()
            
            // 완료 버튼
            completebutton
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
    }
    
    // MARK: 취소 버튼
    private var cancelButton: some View {
        Button {
            // 수정모드 -> 변경된 값이 있다면 취소 alert 띄우기
            if vm.isForEditing {
                if vm.isContentChanged() {
                    isShowCancelAlert.toggle() // sheet 닫기 여부 alert 띄우기
                } else {
                    isSheetAppear.toggle() // sheet 닫기
                }
            // 초기입력모드 -> 입력한 값이 뭐라도 있다면 취소 alert 띄우기
            } else {
                if vm.isSomethingFilled() {
                    isShowCancelAlert.toggle() // sheet 닫기 여부 alert 띄우기
                } else {
                    isSheetAppear.toggle() // sheet 닫기
                }
            }
        } label: {
            Text("취소")
                .font(.body)
                .foregroundStyle(Color.main)
        }
    }
    
    
    // MARK: 완료 버튼
    private var completebutton: some View {
        Button {
            isFocused = false // focus 삭제
            
            // 범위와 입력값 검증 후 결과 처리
            if vm.validateAndUpload() {
                isSheetAppear.toggle()  // sheet 닫기
            } else {
                isShowOutOfRangeAlert.toggle()  // 범위 오류 알림
            }
        } label: {
            Text("완료")
                .font(.body)
                .fontWeight(.bold)
                // 필수정보 입력됐으면 accentColor, 아니라면 회색으로
                .foregroundStyle(isEnableComplete ? .main : .greyText)
        }
        // 필수정보 입력되지 않으면 완료 버튼 비활성화
        .disabled(!isEnableComplete)
    }
}

#Preview {
    EditAllRecord(
        book: EditRecordBookModel(
            bookType: .paperbook,
            totalPage: 500,
            isbn: "1234567"
        ),
        isSheetAppear: .constant(false),
        isPickerAppear: true
    )
}
