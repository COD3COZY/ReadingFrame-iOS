//
//  EditBookmark.swift
//  ReadingFrame
//
//  Created by 이윤지 on 2/28/24.
//

import SwiftUI

/// 홈 화면, 독서 노트 화면에서 사용하는 새로운 책갈피 추가 화면
struct EditBookmark: View {
    
    /// 전달받은 책 객체
    @Bindable var book: RegisteredBook
    
    /// 취소&완료 버튼 클릭 시 sheet 없어지도록 하기 위한 변수
    @Binding var isSheetAppear: Bool
    
    /// 취소 버튼 클릭 시 나타나는 Alert 변수
    @State var isShowCancelAlert: Bool = false
    
    /// 날짜
    @State private var date = Date()
    
    /// 날짜 DatePicker가 보이는지에 대한 여부
    @State private var isDatePickerVisible = false
    
    /// 날짜 범위
    var dateRange: ClosedRange<Date> {
        DateRange().dateRange(date: date)
    }
    
    /// 사용자가 입력한 책갈피 페이지
    @State private var bookMarkPage: String = ""
    
    /// 위치 입력 sheet 띄움 여부를 결정하는 변수
    @State private var showSearchLocation: Bool = false
    
    /// 완료 버튼 클릭 여부 변수
    @State private var isTapCompleteBtn: Bool = false
    
    /// 키보드 포커스 여부 변수
    @FocusState private var isFocused: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            // MARK: Drag Indicator
            DragIndicator()
            
            HStack {
                // MARK: 취소 버튼
                Button {
                    isShowCancelAlert.toggle() // sheet 닫기 여부 alert 띄우기
                } label: {
                    Text("취소")
                        .font(.body)
                        .foregroundStyle(.red0)
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
                        isSheetAppear.toggle() // sheet 닫기
                        
                        isTapCompleteBtn.toggle() // 완료 버튼 클릭
                    }
                } label: {
                    Text("완료")
                        .font(.body)
                        .fontWeight(.bold)
                        .foregroundStyle(.red0)
                }
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
                            
                            TextField("~value", text: $bookMarkPage)
                                .foregroundStyle(.black0)
                                .multilineTextAlignment(.trailing)
                                .focused($isFocused)
                                .onAppear {
                                    DispatchQueue.main.async {
                                        isFocused = false
                                    }
                                }
                            
                            Text("p")
                        }
                    }
                } header: {
                    Text("필수 정보")
                        .font(.footnote)
                        .foregroundStyle(.black0)
                        .padding(.top, 30)
                        .padding(.leading, -15)
                        .padding(.bottom, 15)
                }
                
                // MARK: - 선택 정보
                Section {
                    // MARK: 위치 등록 버튼
                    Button {
                        showSearchLocation.toggle() // 위치 등록 sheet 띄우기
                        isFocused.toggle() // textfield 포커스 삭제
                    } label: {
                        Text("책갈피한 위치")
                            .foregroundStyle(.greyText)
                    }
                    .sheet(isPresented: $showSearchLocation) {
                        // TODO: 위치 등록 화면으로 이동
                        SearchLocation()
                    }
                } header: {
                    Text("선택 정보")
                        .font(.footnote)
                        .foregroundStyle(.black0)
                        .padding(.top, 30)
                        .padding(.leading, -15)
                        .padding(.bottom, 15)
                }
                
            } // list
            .scrollContentBackground(.hidden) // 배경색 지우기
            .padding(-20) // 기존 여백 삭제
        } // top vstack
        .padding([.leading, .trailing], 16)
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
