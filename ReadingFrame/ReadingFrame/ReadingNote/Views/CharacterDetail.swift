//
//  CharacterDetail.swift
//  ReadingFrame
//
//  Created by 이윤지 on 8/2/24.
//

import SwiftUI

/// 인물사전 상세 화면
struct CharacterDetail: View {
    // MARK: - PROPERTY
    var character: Character // 인물사전 객체
    @State var isRecordSheetAppear: Bool = false // 인물사전 수정 시트 띄움 여부
    @State var isShowDeleteAlert: Bool = false // 인물사전 삭제 alert 띄움 여부
    
    // MARK: - BODY
    // TODO: 인물사전 수정용 sheet 띄우기
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 0) {
                // 이모지
                Text(String(UnicodeScalar(character.emoji)!))
                    .font(.system(size: 64, weight: .bold))
                    .frame(width: 64, height: 64, alignment: .center)
                    .padding(28)
                    .background(
                        Circle()
                            .fill(.grey1)
                    )
                    .padding(.vertical, 18)
                
                // 인물 이름
                Text(character.name)
                    .font(.firstTitle)
                    .foregroundStyle(.black0)
                    .padding(.horizontal, 20)
                
                // 한줄 소개
                Text(character.preview)
                    .font(.headline)
                    .foregroundStyle(.black0)
                    .padding(.vertical, 15)
                    .padding(.horizontal, 20)
                
                // 메모
                Text(character.description)
                    .font(.subheadline)
                    .foregroundStyle(.black0)
                    .padding(.top, 15)
                    .padding(.horizontal, 20)
                
            } //: VStack
        } //: ScrollView
        .navigationTitle("인물사전")
        .navigationBarTitleDisplayMode(.inline)
        // MARK: 수정 버튼
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    isRecordSheetAppear.toggle()
                } label: {
                    Text("수정")
                        .foregroundStyle(.red0)
                }
            }
        }
        
        // MARK: 삭제 버튼
        ZStack {
            Button {
                isShowDeleteAlert.toggle()
            } label: {
                HStack(spacing: 4) {
                    Image(systemName: "trash")
                    Text("인물 삭제")
                }
            }
            .tint(.main)
        }
        // MARK: 삭제 Alert
        .alert(
            "해당 인물을 삭제하시겠습니까?",
            isPresented: $isShowDeleteAlert
        ) {
            Button("아니오", role: .cancel) { }
            Button("예", role: .destructive) {
                // 이전 화면으로 이동하기
            }
        } message: {
            Text("삭제된 인물사전은 복구할 수 없습니다.")
        }
    }
    // MARK: - FUNCTION
}

// MARK: - PREVIEW
#Preview("인물사전 상세") {
    CharacterDetail(character: Character(emoji: Int("🍎".unicodeScalars.first!.value), name: "사과", preview: "사과입니다.", description: "맛있는 사과"))
}
