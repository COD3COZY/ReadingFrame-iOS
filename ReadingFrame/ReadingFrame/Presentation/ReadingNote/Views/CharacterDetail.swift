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
    @EnvironmentObject private var coordinator: Coordinator

    /// 인물사전 객체
    var character: Character

    /// 인물 수정을 위해 필요한 해당 책의 기본정보
    let bookInfo: EditRecordBookModel

    /// 인물사전 수정 시트 띄움 여부
    @State var isRecordSheetAppear: Bool = false

    /// 인물사전 삭제 alert 띄움 여부
    @State var isShowDeleteAlert: Bool = false
    
    // MARK: - BODY
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
                Text(character.preview ?? "")
                    .font(.headline)
                    .foregroundStyle(.black0)
                    .padding(.vertical, 15)
                    .padding(.horizontal, 20)
                
                // 메모
                Text(character.description ?? "")
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
        // 인물 수정 sheet
        .sheet(isPresented: $isRecordSheetAppear) {
            editCharacterSheet
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
                // 인물사전 삭제 API 호출 후 빠져나가기
                deleteCharacter(name: character.name) { success in
                    if success {
                        coordinator.popLast()
                    } else {
                        print("인물사전 삭제 실패")
                    }
                }
            }
        } message: {
            Text("삭제된 인물사전은 복구할 수 없습니다.")
        }
    }
}

// MARK: Sheets
extension CharacterDetail {
    private var editCharacterSheet: some View {
        EditAllRecord(
            book: self.bookInfo,
            isSheetAppear: $isRecordSheetAppear,
            selectedTab: RecordType.character.rawValue,
            isForEditing: true,
            characterEditInfo: self.character,
            isPickerAppear: false
        )
    }
}

// MARK: methods
extension CharacterDetail {
    /// 인물 삭제 API 호출
    private func deleteCharacter(name: String, completion: @escaping (Bool) -> (Void)) {
        TabReadingNoteAPI.shared.deleteCharacter(isbn: bookInfo.isbn, name: name) { response in
            switch response {
            case .success:
                completion(true)
                
            case .requestErr(let message):
                print("Request Err: \(message)")
                completion(false)
            case .pathErr:
                print("Path Err")
                completion(false)
            case .serverErr(let message):
                print("Server Err: \(message)")
                completion(false)
            case .networkFail(let message):
                print("Network Err: \(message)")
                completion(false)
            case .unknown(let error):
                print("Unknown Err: \(error)")
                completion(false)
            }
        }
    }
}

// MARK: - PREVIEW
#Preview("인물사전 상세") {
    CharacterDetail(character: Character(emoji: Int("🍎".unicodeScalars.first!.value), name: "사과", preview: "사과입니다.", description: "맛있는 사과"), bookInfo: EditRecordBookModel(bookType: .paperbook, totalPage: 350, isbn: "1234567"))
}
