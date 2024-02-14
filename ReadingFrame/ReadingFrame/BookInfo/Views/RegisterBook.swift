//
//  RegisterBook.swift
//  ReadingFrame
//
//  Created by 석민솔 on 2/13/24.
//

import SwiftUI

struct RegisterBook: View {
    
    @State private var readingStatus: ReadingStatus = .reading  // 독서상태
    
    // 책 유형 선택용
    @State private var paperBookButtonEnabled = true
    @State private var eBookButtonEnabled = false
    @State private var audioBookButtonEnabled = false
    var bookType:BookType = .paperbook
    
    // 소장여부
    @State private var isMine: Bool = false
    
    // 읽기 시작한 날
    @State private var startDate = Date()
    @State private var isStartDatePickerVisible = false
    
    // 다읽은 날
    @State private var recentDate = Date()
    @State private var isRecentDatePickerVisible = false
    
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
            
            
            // 리스트
            List {
                
                // MARK: 독서상태 선택 Segmented control
                
                Picker("독서상태", selection: $readingStatus) {
                    Text("읽는중").tag(ReadingStatus.reading)
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
                                .padding(.bottom) ) {
                    SelectBookTypeView(paperBookButtonEnabled: $paperBookButtonEnabled,
                                       eBookButtonEnabled: $eBookButtonEnabled,
                                       audioBookButtonEnabled: $audioBookButtonEnabled)
                    .frame(maxWidth: .infinity, alignment: .center)
                }
                .listRowBackground(Color.grey1)
                .listRowInsets(EdgeInsets())

                
//                VStack(alignment: .leading) {
//                    
//                    Text("책 유형")
//                        .font(.headline)
//                        .padding(.vertical)
//                    
//                    SelectBookTypeView(paperBookButtonEnabled: $paperBookButtonEnabled,
//                                       eBookButtonEnabled: $eBookButtonEnabled,
//                                       audioBookButtonEnabled: $audioBookButtonEnabled
//                                       /*bookType: $bookType*/)
//                    .frame(maxWidth: .infinity, alignment: .center)
//                }
//                .listRowBackground(Color.grey1)
//                .listRowInsets(EdgeInsets())
                
                
                Section {
                    
                    // MARK: 대표위치 입력(종이책일 때만)
                    
                    if (paperBookButtonEnabled) {
                        Text("구매/대여한 위치")
                            .foregroundStyle(.greyText)
                            .onTapGesture {
                                print("searchLocation 스크린 띄워주기")
                            }
                        
                    }
                    
                    // MARK: 소장여부
                    
                    Toggle(isOn: $isMine, label: {
                        Text("소장한 책")
                    })
                    .tint(.accentColor)
                }
                
                // MARK: 읽기 시작한 날 입력
                
                DatePickerInList(selectedDate: $startDate,
                                 isDatePickerVisible: $isStartDatePickerVisible,
                                 isAnotherDatePickerVisible:$isRecentDatePickerVisible,
                                 listText: "읽기 시작한 날")
                
                // MARK: 다읽은 날 입력(readingStatus 다읽음일때만)
                
                if (readingStatus == .finishRead) {
                    DatePickerInList(selectedDate: $recentDate,
                                     isDatePickerVisible: $isRecentDatePickerVisible,
                                     isAnotherDatePickerVisible:$isStartDatePickerVisible,
                                     listText: "다 읽은 날")

                }
            }
            // list style
            .listStyle(.insetGrouped)
            .scrollContentBackground(.hidden)   // 배경색 지우기
            .padding(-20)          // 기본 적용되는 패딩 상쇄시키기
            .animation(.smooth)
            
            Button(action: {
                
            }, label: {
                Text("내 서재에 추가하기")
                    .font(.headline)
                    .padding(10)
                    .frame(maxWidth: .infinity, alignment: .center)
            })
            .buttonStyle(.borderedProminent)
            .clipShape(.capsule)
            
        }
        .padding(.horizontal, 20)
        .background(.grey1)
    }
}

struct BookInfo_Previews: PreviewProvider {
    static var previews: some View {
        RegisterBook()
    }
}
