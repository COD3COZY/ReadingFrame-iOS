//
//  DatePickerInList.swift
//  ReadingFrame
//
//  Created by 석민솔 on 2/14/24.
//

import SwiftUI

struct DatePickerInList: View {
    @Binding var selectedDate: Date
    @Binding var isDatePickerVisible: Bool
    @Binding var isAnotherDatePickerVisible: Bool
    var listText: String = "날짜 선택"
    
    // 버튼에 들어갈 날짜 text 만들어주기
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
            } label: {
                Text(dateString)
            }
            // 활성화될 때 accentColor로 변경
            .foregroundStyle(isDatePickerVisible ? Color.accentColor : Color.primary)
            // 기존 DatePicker 흉내내기(회색 박스 생김)
            .buttonStyle(.bordered)
        }
        
        
        // MARK: 두번째 row: 첫번째 row 날짜 부분 누르면 나오는 달력 모양 DatePicker
        
        if (isDatePickerVisible && !isAnotherDatePickerVisible) {
            DatePicker("", selection: $selectedDate, displayedComponents: .date)
            // graphical style이 달력 모양
                .datePickerStyle(.graphical)
        }
    }
}

#Preview {
    DatePickerInList(selectedDate: .constant(Date()), 
                     isDatePickerVisible: .constant(true),
                     isAnotherDatePickerVisible: .constant(false))
}
