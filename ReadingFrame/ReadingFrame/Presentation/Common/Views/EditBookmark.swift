//
//  EditBookmark.swift
//  ReadingFrame
//
//  Created by 이윤지 on 2/28/24.
//

import SwiftUI
import MapKit

/// 홈 화면, 독서 노트 화면에서 사용하는 새로운 책갈피 추가 화면
struct EditBookmark: View {
    // MARK: - Properties
    /// 전달받은 책 객체
    @Bindable var book: RegisteredBook
    
    /// 취소&완료 버튼 클릭 시 sheet 없어지도록 하기 위한 변수
    @Binding var isSheetAppear: Bool
    
    /// 취소 버튼 클릭 시 나타나는 Alert 변수
    @State var isShowCancelAlert: Bool = false
    
    /// 완료 버튼 클릭 시 마지막으로 읽은 페이지가 범위 밖이면 나타나는 Alert 변수
    @State var isShowOutOfRangeAlert: Bool = false
    
    /// 날짜
    @State private var date = Date()
    
    /// 날짜 DatePicker가 보이는지에 대한 여부
    @State private var isDatePickerVisible = false
    
    /// 날짜 범위
    var dateRange: ClosedRange<Date> {
        DateUtils().dateRange(date: date)
    }
    
    /// 사용자가 입력한 책갈피 페이지
    @State private var bookMarkPage: String = ""
    
    /// 위치 입력 sheet 띄움 여부를 결정하는 변수
    @State private var showSearchLocation: Bool = false
    
    /// 선택된 위치
    @State private var pickedPlace: MKPlacemark? = nil
    
    /// 완료 버튼 클릭 여부 변수
    @State private var isTapCompleteBtn: Bool = false
    
    /// 키보드 포커스 여부 변수
    @FocusState private var isFocused: Bool
    
    // MARK: - View
    var body: some View {
        VStack(alignment: .leading) {
            // MARK: Drag Indicator
            DragIndicator()
            
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
                        .foregroundStyle(Color.accentColor)
                }
                
                Spacer()
                
                Text("책갈피")
                    .font(.headline)
                    .foregroundStyle(.black0)
                
                Spacer()
                
                // MARK: 완료 버튼
                Button {
                    isFocused = false // focus 삭제
                    
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
                    // fin. 완료버튼 action
                    
                } label: {
                    Text("완료")
                        .font(.body)
                        .fontWeight(.bold)
                        // 필수정보 입력됐으면 accentColor, 아니라면 회색으로
                        .foregroundStyle(bookMarkPage.isEmpty ? Color.greyText : Color.accentColor)
                }
                // 필수정보 입력되지 않으면 완료 버튼 비활성화
                .disabled(bookMarkPage.isEmpty)
            }
            .padding(.top, 21)
            .padding(.horizontal, 16)
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
            
            List {
                // MARK: - 필수 정보
                Section {
                    // MARK: 날짜 선택 버튼
                    DatePickerInList(
                        selectedDate: $date,
                        isDatePickerVisible: $isDatePickerVisible,
                        dateRange: dateRange,
                        listText: "날짜"
                    )
                    
                    // MARK: 마지막으로 읽은 페이지 입력 필드
                    VStack {
                        HStack {
                            Text("마지막으로 읽은")
                            
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
                } header: {
                    Text("필수 정보")
                        .font(.footnote)
                        .foregroundStyle(.black0)
                        .padding(.top, 30)
                        .padding(.bottom, 15)
                        .listRowInsets(EdgeInsets())
                }
                
                // MARK: - 선택 정보
                Section {
                    // MARK: 위치 등록 버튼
                    Button {
                        showSearchLocation.toggle() // 위치 등록 sheet 띄우기
                        isFocused.toggle() // textfield 포커스 삭제
                    } label: {
                        Text(pickedPlace == nil ? "책갈피한 위치" : (pickedPlace?.name ?? ""))
                            .foregroundStyle(pickedPlace == nil ? .greyText : .black0)
                    }
                    .sheet(isPresented: $showSearchLocation) {
                        // TODO: 위치 등록 화면으로 이동
                        SearchLocation(showingSearchLocation: $showSearchLocation, pickedPlaceMark: $pickedPlace)
                    }
                } header: {
                    Text("선택 정보")
                        .font(.footnote)
                        .foregroundStyle(.black0)
                        .padding(.top, 30)
                        .padding(.bottom, 15)
                        .listRowInsets(EdgeInsets())
                }
            }
            .listStyle(.insetGrouped)
            .scrollContentBackground(.hidden)
        } // top vstack
        .background(.grey1)
        .onDisappear() {
            if (isTapCompleteBtn) {
                // TODO: API에 책갈피 등록하기
                print("시작날짜:", date.description)
                print("마지막으로 읽은 페이지:", bookMarkPage.description)
                print("완료 버튼 클릭 :", isTapCompleteBtn.description)
            }
        }
    }
}

#Preview {
    EditBookmark(book: RegisteredBook(), isSheetAppear: .constant(false))
}
