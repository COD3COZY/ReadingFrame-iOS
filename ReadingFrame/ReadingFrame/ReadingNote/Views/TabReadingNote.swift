//
//  BookmarkTab.swift
//  ReadingFrame
//
//  Created by 이윤지 on 7/24/24.
//

import SwiftUI

/// 독서노트 탭 화면 (북마크/메모/인물사전)
enum readingNoteTab : String, CaseIterable {
    case bookmark = "책갈피"
    case memo = "메모"
    case character = "인물사전"
}

struct TabReadingNote: View {
    // MARK: - PROPERTY
    @Bindable var book: RegisteredBook
    @State var selectedTab: readingNoteTab = .bookmark
    @Namespace private var animation
    var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    
    @State var isRecordSheetAppear: Bool = false // 기록하기 sheet가 띄워져 있는지 확인하는 변수
    @State var isPickerAppear: Bool = false // 기록하기 sheet의 picker 띄움 여부 변수
    @State private var searchText: String = "" // 사용자가 입력한 검색어
    
    // MARK: - BODY
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                // 탭바 및 애니메이션
                tabAnimate()
                
                if (selectedTab != .character) {
                    // MARK: 리스트 조회 방법
                    HStack(spacing: 5) {
                        Spacer()
                        
                        Button {
                            
                        } label: {
                            Text("페이지순")
                                .font(.caption)
                                .foregroundStyle(.black0)
                        }
                        Circle()
                            .frame(width: 3, height: 3)
                        Button {
                            
                        } label: {
                            Text("최신순")
                                .font(.caption)
                                .foregroundStyle(.greyText)
                        }
                    }
                    .padding(.top, 14)
                    .padding(.trailing, 19)
                    .padding(.bottom, 8)
                }
                else {
                    // MARK: 인물사전 검색
                    SearchBar(searchText: $searchText, placeholder: "인물의 이름, 한줄소개를 입력하세요")
                        .padding(.top, 15)
                        .padding(.horizontal, 16)
                }
                
                List {
                    // 스크롤 내부 뷰
                    switch selectedTab {
                        // 책갈피를 클릭했다면
                    case .bookmark:
                        // 값이 없다면
                        if ((book.bookmarks?.isEmpty) == nil) {
                            HStack {
                                Spacer()
                                GreyLogoAndTextView(text: "아직 등록된 책갈피가 없어요.")
                                Spacer()
                            }
                            .padding(.top, 180)
                            .listRowInsets(EdgeInsets()) // 기본 패딩 제거
                        }
                        
                        if let bookmarks = book.bookmarks {
                            // 값이 있다면
                            if !bookmarks.isEmpty {
                                ForEach(Array(bookmarks.enumerated()), id: \.offset) { index, item in
                                    BookmarkView(bookmark: item)
                                        .padding(.vertical, 24)
                                        .swipeActions(edge: .trailing) {
                                            Button(role: .destructive) {
                                                book.bookmarks?.remove(at: index)
                                            } label: {
                                                Image(systemName: "trash.fill")
                                            }
                                            .tint(.red0)
                                        }
                                        .listRowInsets(EdgeInsets()) // 전체 패딩 제거
                                }
                            }
                        }
                        // 메모를 클릭했다면
                    case .memo:
                        // 값이 없다면
                        if ((book.memos?.isEmpty) == nil) {
                            HStack {
                                Spacer()
                                GreyLogoAndTextView(text: "아직 작성된 메모가 없어요.")
                                Spacer()
                            }
                            .padding(.top, 180)
                            .listRowInsets(EdgeInsets()) // 기본 패딩 제거
                        }
                        
                        if let memos = book.memos {
                            // 값이 있다면
                            if !memos.isEmpty {
                                ForEach(Array(memos.enumerated()), id: \.offset) { index, item in
                                    MemoView(memo: item)
                                        .padding(.vertical, 24)
                                        .swipeActions(edge: .trailing) {
                                            Button(role: .destructive) {
                                                book.memos?.remove(at: index)
                                            } label: {
                                                Image(systemName: "trash.fill")
                                            }
                                            .tint(.red0)
                                        }
                                        .listRowInsets(EdgeInsets()) // 전체 패딩 제거
                                }
                            }
                        }
                        // 인물사전을 클릭했다면
                    case .character:
                        // 값이 없다면
                        if ((book.characters?.isEmpty) == nil) {
                            HStack {
                                Spacer()
                                GreyLogoAndTextView(text: "아직 등록된 인물사전이 없어요.")
                                Spacer()
                            }
                            .padding(.top, 180)
                            .listRowInsets(EdgeInsets()) // 기본 패딩 제거
                        }
                        
                        if let characters = book.characters {
                            // 값이 있다면
                            if !characters.isEmpty {
                                LazyVGrid(columns: columns, spacing: 10) {
                                    ForEach(Array(characters.enumerated()), id: \.offset) { index, item in
                                        CharacterView(character: item)
                                            .padding(16)
                                            .frame(maxWidth: .infinity)
                                            .background(
                                                RoundedRectangle(cornerRadius: 15)
                                                    .fill(.white)
                                                    .stroke(Color.grey2, lineWidth: 2)
                                            )
                                            .listRowInsets(EdgeInsets()) // 전체 패딩 제거
                                    }
                                }
                            }
                        }
                        
                    } //: switch-case
                } //: List
                .listStyle(.plain)
            } //: VStack
            
            VStack {
                Spacer() // 상단 여백을 위한 Spacer
                HStack {
                    Spacer() // 좌측 여백을 위한 Spacer
                    // MARK: 기록하기 버튼
                    Button {
                        isRecordSheetAppear.toggle()
                    } label: {
                        Image(systemName: "pencil")
                            .font(.system(size: 36, weight: .regular))
                            .foregroundStyle(.white)
                    }
                    .background(
                        Circle()
                            .fill(.main)
                            .frame(width: 64, height: 64)
                    )
                    .shadow(color: .black.opacity(0.2), radius: 6, x: 3, y: 3)
                }
                .padding(32)
            }
            // MARK: 기록하기 버튼 클릭 시 나타나는 Sheet
            .sheet(isPresented: $isRecordSheetAppear) {
                // 책갈피 등록 sheet 띄우기
                EditAllRecord(
                    book: book,
                    selectedTab: selectedTab.rawValue,
                    isSheetAppear: $isRecordSheetAppear,
                    isPickerAppear: isPickerAppear
                )
            }
        } //: ZStack
        .navigationTitle("나의 기록")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    // MARK: - FUNCTION
    /// 탭 바 및 애니메이션 구현
    @ViewBuilder func tabAnimate() -> some View {
        VStack(spacing: 0) {
            HStack {
                ForEach(readingNoteTab.allCases, id: \.self) { item in
                    VStack(spacing: 0) {
                        Text(item.rawValue)
                            .font(.subheadline)
                            .fontWeight(selectedTab == item ? .semibold : .regular)
                            .frame(maxWidth: .infinity/3, minHeight: 54, alignment: .center)
                            .foregroundStyle(.black)
                        
                        if selectedTab == item {
                            Capsule()
                                .foregroundStyle(.black0)
                                .frame(height: 3)
                                .matchedGeometryEffect(id: "bookmark", in: animation)
                        }
                        else {
                            Capsule()
                                .foregroundStyle(.black0)
                                .frame(height: 3)
                                .opacity(0)
                        }
                    }
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            self.selectedTab = item
                        }
                    }
                }
            } //: HStack
            
            Capsule()
                .foregroundStyle(.grey2)
                .frame(height: 1, alignment: .bottom)
                .matchedGeometryEffect(id: "tab", in: animation)
        } //: VStack
    }
}

// MARK: - PREVIEW
#Preview {
    TabReadingNote(book: RegisteredBook())
}
