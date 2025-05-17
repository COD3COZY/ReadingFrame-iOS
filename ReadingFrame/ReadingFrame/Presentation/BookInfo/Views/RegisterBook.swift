//
//  RegisterBook.swift
//  ReadingFrame
//
//  Created by 석민솔 on 2/13/24.
//

import SwiftUI
import MapKit

/// 책등록(서재로 읽는중이나 다읽은 책으로 등록할 때) modal로 띄울 화면.
struct RegisterBook: View {
    
    // MARK: - Properties
    /// 뷰모델
    @StateObject var vm: RegisterBookViewModel
    
    /// 내서재 추가하기 버튼 눌렀을 때 sheet 없어지도록 하기 위한 변수
    @Binding var isSheetAppear: Bool

    /// 대표위치 입력 sheet 띄울지 결정 여부
    @State private var showSearchLocation: Bool = false
    
    /// 읽기 시작한 날 DatePicker가 보이는지 여부
    @State private var isStartDatePickerVisible = false
    
    /// 다 읽은 날 DatePicker가 보이는지 여부
    @State private var isRecentDatePickerVisible = false
    
    /// 호출한 뷰에 전달해줘야 하는 독서상태값
    @Binding var readingStatus: ReadingStatus
    
    /// 내 서재 등록하기 버튼 눌러서 등록할 때 true로 바꿔줄 프로퍼티
    @State var isButtonPressed: Bool = false
    
    
    // MARK: - init
    init(
        isSheetAppear: Binding<Bool>,
        readingStatus: Binding<ReadingStatus>,
        isbn: String,
        bookInfo: RegisterBookInfoModel? = nil
    ) {
        self._isSheetAppear = isSheetAppear
        self._readingStatus = readingStatus
        self._vm = StateObject(wrappedValue: RegisterBookViewModel(
            isbn: isbn,
            bookInfo: bookInfo)
        )
    }
    
    
    
    // MARK: - View
    var body: some View {
        VStack(alignment: .leading) {
            
            // Drag Indicator
            DragIndicator()
            
            List {
                // 독서상태 선택 Segmented control
                readingStatusPicker
                
                // 책유형 선택
                bookTypePicker
                
                // section2: 대표위치, 소장한 책
                Section {
                    // 대표위치 입력
                    // 책 유형 종이책일 때만 보이도록 함
                    if (vm.registerBookData.bookType == .paperbook) {
                        pickPlaceRow
                    }
                    
                    // 소장여부
                    toggleIsMineRow
                }
                
                // section3: 날짜 입력하는 rows
                Section {
                    // 읽기 시작한 날 입력
                    dateRow(isForStartDate: true)
                    
                    // 다읽은 날 입력
                    // readingStatus 다읽음일때만 보여주도록
                    if (vm.registerBookData.readingStatus == .finishRead) {
                        dateRow(isForStartDate: false)
                    }
                    
                }
            }
            // list style
            .listStyle(.insetGrouped)
            .scrollContentBackground(.hidden)   // 배경색 지우기
            .padding(-20)                       // 기본 적용되는 패딩 상쇄시키기
            
            
            // 내 서재에 추가하기 버튼
            Button(action: {
                // 책등록 API 호출
                vm.registerBook { isSuccess in
                    if isSuccess {
                        // TODO: 호출 결과 따라서 처리하기
                        // modal 닫기
                        isSheetAppear.toggle()
                        
                        // 등록을 확실히 시키겠다 알려주기
                        isButtonPressed.toggle()
                    } else {
                        print("RegisterBook: 책등록 실패")
                    }
                }
                
            }, label: {
                Text("내 서재에 추가하기")
                    .font(.headline)
                    .padding(10)
                    .frame(maxWidth: .infinity, alignment: .center)
            })
            .tint(.accentColor)
            .buttonStyle(.borderedProminent)
            .clipShape(.capsule)
            
        }
        .padding([.leading, .trailing, .bottom], 20)
        .background(.grey1)
        
        // UI에서 책 등록해주기
        // modal 사라질 때 '내서재에 추가하기' 버튼을 눌러서 책을 등록하려고 한다면
        .onDisappear() {
            if isButtonPressed {
                // @Bindable book 인스턴스에 등록하려는 readingStatus 상태 입력해주기
                self.readingStatus = vm.registerBookData.readingStatus
            }
        }
    }
}

// MARK: - View Components
extension RegisterBook {
    /// 독서상태 선택 Segmented control
    private var readingStatusPicker: some View {
        Picker("독서상태", selection: $vm.registerBookData.readingStatus) {
            Text("읽는중")
                .tag(ReadingStatus.reading)
                .onTapGesture {
                    print("읽는중 눌림")
                }
            Text("다읽음")
                .tag(ReadingStatus.finishRead)
                .onTapGesture {
                    print("다읽음 눌렸음")
                }
        }
        .pickerStyle(.segmented)
        .listRowBackground(Color.grey1)
        .listRowInsets(EdgeInsets())
    }
    
    /// 책유형 선택
    private var bookTypePicker: some View {
        Section(
            header: Text("책 유형")
                        .font(.headline)
                        .foregroundStyle(.black)
                        .padding(.bottom)
        ) {
            SelectBookTypeView(bookType: $vm.registerBookData.bookType)
                .frame(maxWidth: .infinity, alignment: .center)
        }
        .listRowBackground(Color.grey1)
        .listRowInsets(EdgeInsets())
    }
    
    /// 대표위치 입력 Row
    private var pickPlaceRow: some View {
        Button {
            // 버튼 누르면 sheet present되도록
            showSearchLocation.toggle()
            
            // 버튼 잘 작동되는지 확인용 코드(주석 가능)
            print("showSearchLocation: ", showSearchLocation)
        } label: {
            if let mainLocation = vm.registerBookData.mainLocation {
                Text(mainLocation.name ?? "")
                    .foregroundStyle(.black0)
            } else {
                Text("구매/대여한 위치")
                    .foregroundStyle(.greyText)
            }
        }
        // sheet modal 보여주기 위한 코드
        // (일단 화면 띄우기만 하고 위치 받아오기는 나중에 하겠습니다)
        .sheet(isPresented: $showSearchLocation) {
            SearchLocation(
                showingSearchLocation: $showSearchLocation,
                pickedPlaceMark: $vm.registerBookData.mainLocation
            )
        }
    }
    
    /// 소장여부 토글 Row
    private var toggleIsMineRow: some View {
        Toggle(isOn: $vm.registerBookData.isMine, label: {
            Text("소장한 책")
        })
        .tint(Color.main) // 토글 색깔 디자인 커스텀 적용
    }
    
    /// 읽기 시작한 날/ 다 읽은날 입력 row View 만들어주는 함수
    private func dateRow(isForStartDate: Bool) -> some View {
        let selectedDate = isForStartDate ? $vm.registerBookData.startDate : $vm.registerBookData.recentDate
        let isDatePickerVisible = isForStartDate ? $isStartDatePickerVisible : $isRecentDatePickerVisible
        let dateRange = isForStartDate ? vm.startDateRange : vm.recentDateRange
        let listText = isForStartDate ? "읽기 시작한 날" : "다 읽은 날"
        
        return DatePickerInList(
            selectedDate: selectedDate,
            isDatePickerVisible: isDatePickerVisible,
            dateRange: dateRange,
            listText: listText
        )
        .onChange(of: isDatePickerVisible.wrappedValue) { oldValue, newValue in
            if newValue {
                if isForStartDate {
                    isRecentDatePickerVisible = false
                } else {
                    isStartDatePickerVisible = false
                }
            }
        }
    }
}

#Preview {
    RegisterBook(
        isSheetAppear: .constant(true),
        readingStatus: .constant(.reading),
        isbn: "",
        bookInfo: RegisterBookInfoModel(cover: "", title: "", author: "", categoryName: "", totalPage: 130, publisher: "", publicationDate: "")
    )
}

