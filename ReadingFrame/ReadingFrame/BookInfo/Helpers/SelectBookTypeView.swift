//
//  SelectBookTypeView.swift
//  ReadingFrame
//
//  Created by 석민솔 on 2/14/24.
//

import SwiftUI

/// 책유형(종이책, 전자책, 오디오북) 3종류 중 하나 버튼으로 고르는 뷰
struct SelectBookTypeView: View {
    @State private var paperBookButtonEnabled: Bool = true    /// 책 유형 선택용: 종이책 선택여부
    @State private var eBookButtonEnabled: Bool = false       /// 책 유형 선택용: 전자책 선택여부
    @State private var audioBookButtonEnabled: Bool = false   /// 책 유형 선택용: 오디오북 선택여부
    
    /// 선택된 책유형 저장해서 불러낸 뷰로 전달할 변수(기본값: 종이책)
    @Binding var bookType: BookType
    
    var body: some View {
        HStack(spacing: 40) {
            
            // MARK: 종이책 버튼
            VStack(spacing: 10) {
                // 버튼
                Button { } label: {
                    Image(systemName: "book.pages.fill")
                        .font(.largeTitle)
                        .padding()
                        .foregroundStyle(Color.white)
                        // 버튼 선택됐으면 검은색, 아니라면 회색으로 배경색 변경
                        .background(paperBookButtonEnabled ? .black0 : .grey2)
                        .frame(width: 64, height: 64, alignment: .center)
                        .cornerRadius(20)
                }
                .onTapGesture {
                    // 종이책만 선택되도록 paperBookButtonEnabled만 true로 변경
                    paperBookButtonEnabled = true
                    eBookButtonEnabled = false
                    audioBookButtonEnabled = false
                    
                    // 전달할 책유형 종이책으로 변경
                    bookType = .paperbook
                    
                    // 버튼 상태 확인용(주석처리 가능)
                    print("button1")
                    print("paper: ",paperBookButtonEnabled, "ebook: ", eBookButtonEnabled, "audio: ", audioBookButtonEnabled )
                }
                
                // 종이책 텍스트
                Text("종이책")
            }
            
            
            // MARK: 전자책 버튼
            VStack(spacing: 10) {
                Button { } label: {
                    // 버튼
                    Image(systemName: "smartphone")
                        .font(.largeTitle)
                        .padding()
                        .foregroundStyle(Color.white)
                        // 버튼 선택됐으면 검은색, 아니라면 회색으로 배경색 변경
                        .background(eBookButtonEnabled ? .black0 : .grey2)
                        .frame(width: 64, height: 64, alignment: .center)
                        .cornerRadius(20)
                }
                .onTapGesture {
                    // 전자책만 선택되도록 eBookButtonEnabled만 true로 변경
                    paperBookButtonEnabled = false
                    eBookButtonEnabled = true
                    audioBookButtonEnabled = false
                    
                    // 전달할 책유형 전자책으로 변경
                    bookType = .eBook
                    
                    // 버튼 상태 확인용(주석처리 가능)
                    print("button2")
                    print("paper: ",paperBookButtonEnabled, "ebook: ", eBookButtonEnabled, "audio: ", audioBookButtonEnabled )
                }
                
                // 전자책 텍스트
                Text("전자책")
            }
            
             
            // MARK: 오디오북 버튼
            VStack(spacing: 10) {
                // 버튼
                Button { } label: {
                    Image(systemName: "headphones")
                        .font(.largeTitle)
                        .padding()
                        .foregroundStyle(Color.white)
                        // 버튼 선택됐으면 검은색, 아니라면 회색으로 배경색 변경
                        .background(audioBookButtonEnabled ? .black0 : .grey2)
                        .frame(width: 64, height: 64, alignment: .center)
                        .cornerRadius(20)
                }
                .onTapGesture {
                    // 전자책만 선택되도록 audioBookButtonEnabled만 true로 변경
                    paperBookButtonEnabled = false
                    eBookButtonEnabled = false
                    audioBookButtonEnabled = true
                    
                    // 전달할 책유형 오디오북으로 변경
                    bookType = .audioBook
                    
                    // 버튼 상태 확인용(주석처리 가능)
                    print("button3")
                    print("paper: ",paperBookButtonEnabled, "ebook: ", eBookButtonEnabled, "audio: ", audioBookButtonEnabled )
                }
                
                // 오디오북 텍스트
                Text("오디오북")
            }
        }
    }
}
