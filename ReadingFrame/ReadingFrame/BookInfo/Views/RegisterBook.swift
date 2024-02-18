//
//  RegisterBook.swift
//  ReadingFrame
//
//  Created by 석민솔 on 2/13/24.
//

import SwiftUI

/// 책등록(서재로 읽는중이나 다읽은 책으로 등록할 때) modal로 띄울 화면.
struct RegisterBook: View {
    
    // MARK: - 변수

    // MARK: 바깥에서 전달받을 값들
    /// 호출한 뷰에서 전달받을 InitialBook 객체
//    let book: InitialBook
    
    /// 호출한 뷰에 전달해줘야 하는 독서상태값
    @Binding var book: InitialBook

    
    // MARK: 자체적으로 변경해주면서 사용할 값들
    /// 선택된 책유형 저장할 변수(기본값: 종이책)
    @State private var bookType: BookType = .paperbook
    
    /// 대표위치 입력 sheet 띄울지 결정 여부
    @State private var showSearchLocation: Bool = false
    
    /// 소장여부
    @State private var isMine: Bool = false
    
    
    /// 읽기 시작한 날
    @State private var startDate = Date()
    
    /// 읽기 시작한 날 DatePicker가 보이는지 여부
    @State private var isStartDatePickerVisible = false
    
    /// 읽기 시작한 날 정할 수 있는 범위(100년 전 ~ 현재)
    /// - 설마 100년전에 읽던 책까지 우리 앱에 기록하지는 않을거잖아요?
    var startDateRange: ClosedRange<Date> {
        let min = Calendar.current.date(byAdding: .year, value: -100, to: startDate)!
        let max = Date()
        return min...max
    }
    
    
    /// 다 읽은 날
    @State private var recentDate = Date()
    
    /// 다 읽은 날 DatePicker가 보이는지 여부
    @State private var isRecentDatePickerVisible = false
    
    /// 다읽은 날 정할 수 있는 범위(읽기 시작한 날 ~ 현재)
    var recentDateRange: ClosedRange<Date> {
        let min = startDate
        let max = Date()
        return min...max
    }
    
    
    // MARK: - View
    var body: some View {
        VStack(alignment: .leading) {
            
            // MARK: Drag Indicator
            ZStack {
                Capsule()
                    .fill(.grey2)
                    .frame(width: 42, height: 5)
                    .padding(10)
            }
            .frame(maxWidth: .infinity, alignment: .center)
            
            
            List {
                
                // MARK: 독서상태 선택 Segmented control
                Picker("독서상태", selection: $book.readingStatus) {
                    Text("읽는중")
                        .tag(ReadingStatus.reading)
                    Text("다읽음")
                        .tag(ReadingStatus.finishRead)
                }
                .pickerStyle(.segmented)
                .padding(.top, 10)
                .listRowBackground(Color.grey1)
                .listRowInsets(EdgeInsets())
                
                
                // MARK: 책유형 선택
                Section(
                    header: Text("책 유형")
                                .font(.headline)
                                .foregroundStyle(.primary)
                                .padding(.bottom) 
                ) {
                    SelectBookTypeView(bookType: $bookType)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                .listRowBackground(Color.grey1)
                .listRowInsets(EdgeInsets())
                
                
                // section2: 대표위치, 소장한 책
                Section {
                    
                    // MARK: 대표위치 입력
                    // 책 유형 종이책일 때만 보이도록 함
                    if (bookType == .paperbook) {
                        Button(action: {
                            // 버튼 누르면 sheet present되도록
                            showSearchLocation.toggle()
                            
                            // 버튼 잘 작동되는지 확인용 코드(주석 가능)
                            print("showSearchLocation: ", showSearchLocation)
                        }) {
                            Text("구매/대여한 위치")
                                .foregroundStyle(.greyText)
                        }
                        // sheet modal 보여주기 위한 코드
                        // (일단 화면 띄우기만 하고 위치 받아오기는 나중에 하겠습니다)
                        .sheet(isPresented: $showSearchLocation) {
                            SearchLocation()
                        }
                        
                    }
                    
                    // MARK: 소장여부
                    Toggle(isOn: $isMine, label: {
                        Text("소장한 책")
                    })
                    .tint(.accentColor) // 토글 색깔 디자인 커스텀 적용
                }
                
                // section3: 날짜 입력하는 rows
                Section {
                    // MARK: 읽기 시작한 날 입력
                    DatePickerInList(selectedDate: $startDate,
                                     isDatePickerVisible: $isStartDatePickerVisible,
                                     dateRange: startDateRange,
                                     listText: "읽기 시작한 날")
                    // 읽기 시작한 날 DatePicker가 활성화되면 다읽은날 DatePicker는 비활성화
                    .onChange(of: isStartDatePickerVisible) {
                        if isStartDatePickerVisible {
                            isRecentDatePickerVisible = false
                        }
                    }
                    
                    // MARK: 다읽은 날 입력
                    // readingStatus 다읽음일때만 보여주도록
                    if ($book.readingStatus == .finishRead) {
                        DatePickerInList(selectedDate: $recentDate,
                                         isDatePickerVisible: $isRecentDatePickerVisible,
                                         dateRange: recentDateRange,
                                         listText: "다 읽은 날")
                        // 읽기 시작한 날 DatePicker가 활성화되면 다읽은날 DatePicker는 비활성화
                        .onChange(of: isRecentDatePickerVisible) {
                            if isRecentDatePickerVisible {
                                isStartDatePickerVisible = false
                            }
                        }
                        
                    }
                    
                }
            }
            // list style
            .listStyle(.insetGrouped)
            .scrollContentBackground(.hidden)   // 배경색 지우기
            .padding(-20)                       // 기본 적용되는 패딩 상쇄시키기
            .animation(.easeInOut)              // 리스트 row 생겼다 없어질 때마다 애니메이션 효과 적용
            
            
            // MARK: 내 서재에 추가하기 버튼
            Button(action: {
                // 나중에 API로 보내주거나 보내줘야 할 값들 일단 print로 확인하기
                print("- ISBN:", $book.ISBN)
                print("- 독서상태:", $book.readingStatus)
                print("- 책 유형:", $book.bookType)
                print("- 대표위치: 아직 없음")
                print("- 소장여부:", $book.isMine)
                print("- 시작날짜:", $book.startDate.description)
                print("- 마지막날짜:",
                      $book.readingStatus == .finishRead ? $book.recentDate.description : "없음")
                print("> book Information-------")
                print("    - cover:", $book.cover)
                print("    - title:", $book.title)
                print("    - author:", $book.author)
                print("    - categoryName:", $book.categoryName)
                print("    - totalPage:", $book.totalPage)
            }, label: {
                Text("내 서재에 추가하기")
                    .font(.headline)
                    .padding(10)
                    .frame(maxWidth: .infinity, alignment: .center)
            })
            .buttonStyle(.borderedProminent)
            .clipShape(.capsule)
            
        }
        .padding(20)
        .background(.grey1)
    }
}

// MARK: - Preview
struct BookInfo_Previews: PreviewProvider {
    @State static var sampleBook = InitialBook()
    
    static var previews: some View {
        RegisterBook(book: .constant(sampleBook))
    }
}
