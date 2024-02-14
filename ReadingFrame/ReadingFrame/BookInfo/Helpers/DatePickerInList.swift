//
//  DatePickerInList.swift
//  ReadingFrame
//
//  Created by 석민솔 on 2/14/24.
//

import SwiftUI

/// 날짜 버튼 누르면 DatePicker 나타나도록 하는 뷰(List에서 사용할 용도)
struct DatePickerInList: View {
    
    @Binding var selectedDate: Date                 /// 선택한 날짜(호출한 뷰로 전달)
    @Binding var isDatePickerVisible: Bool          /// 현재 뷰에서 달력 graphical DatePicker 보여주는지 여부
    var dateRange: ClosedRange<Date>                /// DatePicker 만들 때 in: 에 전달에줄 날짜 범위
    
    /// 근처에 다른 DatePickerInList가 있다면 하나의 DatePicker만 보여주기 위한 변수
    @Binding var isAnotherDatePickerVisible: Bool
    
    var listText: String = "날짜 선택"  /// 어떤 날짜 선택하는지 설명용 텍스트
    
    /// 버튼에 들어갈 날짜 text
    var dateString: String {
        // DateFormatter 형식 지정
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        
        // Date -> String
        let dateString = dateFormatter.string(from: selectedDate)
        
        return dateString
    }
    
    var body: some View {

        // MARK: 첫번째 row: 날짜 선택 button
        HStack {
            Text(listText)
            Spacer()
            Button {
                isDatePickerVisible.toggle()
                isAnotherDatePickerVisible = false
                
                print("current: ", isDatePickerVisible, "another: ", isAnotherDatePickerVisible)
            } label: {
                Text(dateString)
            }
            // 활성화될 때 accentColor로 변경
            .foregroundStyle(isDatePickerVisible ? Color.accentColor : Color.primary)
            // 기존 DatePicker 흉내내기(회색 박스 생김)
            .buttonStyle(.bordered)
        }
        
        
        // MARK: 두번째 row: 첫번째 row의 날짜 버튼 누르면 나오는 달력 모양 DatePicker
        if (isDatePickerVisible) {
            DatePicker(listText,
                       selection: $selectedDate,
                       in: dateRange,
                       displayedComponents: .date)
                // 달력 모양의 graphical style
                .datePickerStyle(.graphical)
        }
    }
}
