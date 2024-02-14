//
//  SelectBookTypeView.swift
//  ReadingFrame
//
//  Created by 석민솔 on 2/14/24.
//

import SwiftUI

struct SelectBookTypeView: View {
    @Binding var paperBookButtonEnabled: Bool
    @Binding var eBookButtonEnabled: Bool
    @Binding var audioBookButtonEnabled: Bool
    
    var body: some View {
        HStack(spacing: 40) {
            
            // 종이책 버튼
            VStack(spacing: 10) {
                Button { } label: {
                    Image(systemName: "book.pages.fill")
                        .font(.largeTitle)
                        .padding()
                        .foregroundStyle(Color.white)
                        .background(paperBookButtonEnabled ? .black0 : .grey2)
                        .frame(width: 64, height: 64, alignment: .center)
                        .cornerRadius(20)
                }
                .onTapGesture {
                    paperBookButtonEnabled = true
                    eBookButtonEnabled = false
                    audioBookButtonEnabled = false
                    
                    print("button1")
                    print("paper: ",paperBookButtonEnabled, "ebook: ", eBookButtonEnabled, "audio: ", audioBookButtonEnabled )
                }
                
                Text("종이책")
            }
            
            
            // 전자책 버튼
            VStack(spacing: 10) {
                Button { } label: {
                    Image(systemName: "smartphone")
                        .font(.largeTitle)
                        .padding()
                        .foregroundStyle(Color.white)
                        .background(eBookButtonEnabled ? .black0 : .grey2)
                        .frame(width: 64, height: 64, alignment: .center)
                        .cornerRadius(20)
                }
                .onTapGesture {
                    paperBookButtonEnabled = false
                    eBookButtonEnabled = true
                    audioBookButtonEnabled = false
                    
                    print("button2")
                    print("paper: ",paperBookButtonEnabled, "ebook: ", eBookButtonEnabled, "audio: ", audioBookButtonEnabled )
                }
                
                Text("전자책")
            }
            
             
            // 오디오북 버튼
            VStack(spacing: 10) {
                Button { } label: {
                    Image(systemName: "headphones")
                        .font(.largeTitle)
                        .padding()
                        .foregroundStyle(Color.white)
                        .background(audioBookButtonEnabled ? .black0 : .grey2)
                        .frame(width: 64, height: 64, alignment: .center)
                        .cornerRadius(20)
                }
                .onTapGesture {
                    paperBookButtonEnabled = false
                    eBookButtonEnabled = false
                    audioBookButtonEnabled = true
                    
                    print("button3")
                    print("paper: ",paperBookButtonEnabled, "ebook: ", eBookButtonEnabled, "audio: ", audioBookButtonEnabled )
                }
                
                Text("오디오북")
            }
        }
    }
}
