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
    /// 뷰모델
    @StateObject var vm: TabReadingNoteViewModel
        
    /// 선택된 탭이 뭔지
    @State var selectedTab: readingNoteTab = .bookmark
    
    /// 탭바 애니메이션 구현용
    @Namespace private var animation
    
    /// 인물사전 2열 그리드 만들기 위한 변수
    var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    
    /// 기록하기 sheet가 띄워져 있는지 확인하는 변수
    @State var isRecordSheetAppear: Bool = false
        
    /// 사용자가 입력한 검색어
    @State private var searchText: String = ""
    
    // MARK: - init
    init(bookType: BookType,
         totalPage: Int,
         isbn: String,
         selectedTab: readingNoteTab) {
        self._vm = StateObject(wrappedValue: TabReadingNoteViewModel(selectedTab: selectedTab,
                                                                     book: EditRecordBookModel(bookType: bookType, totalPage: totalPage, isbn: isbn)))
        self.selectedTab = selectedTab
    }
    
    // MARK: - BODY
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                // 탭바 및 애니메이션
                tabAnimate()
                
                if (vm.selectedTab != .character) {
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
                
                // 스크롤 내부 뷰
                switch vm.selectedTab {
                    
                // 책갈피를 클릭했다면: 책갈피 탭 뷰
                case .bookmark:
                    bookmarkTabView
                    
                // 메모를 클릭했다면: 메모 탭 뷰
                case .memo:
                    memoTabView
                    
                // 인물사전을 클릭했다면: 인물사전 탭 뷰
                case .character:
                    characterTabView
                    
                } //: switch-case

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
                    book: vm.book,
                    isSheetAppear: $isRecordSheetAppear,
                    selectedTab: vm.selectedTab.rawValue,
                    isPickerAppear: false
                )
            }
        } //: ZStack
        .navigationTitle("나의 기록")
        .navigationBarTitleDisplayMode(.inline)
        .onChange(of: vm.selectedTab) { oldValue, newValue in
            // 탭이 달라질 때 데이터 불러오기
            switch newValue {
            case .bookmark:
                vm.fetchBookmarkData()
            case .memo:
                vm.fetchMemoData()
            case .character:
                vm.fetchCharacterData()
            }
        }
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
                            .fontWeight(vm.selectedTab == item ? .semibold : .regular)
                            .frame(maxWidth: .infinity/3, minHeight: 54, alignment: .center)
                            .foregroundStyle(.black)
                        
                        if vm.selectedTab == item {
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
                            self.vm.selectedTab = item
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
    TabReadingNote(bookType: .paperbook, totalPage: 500, isbn: "12345", selectedTab: .bookmark)
}

extension TabReadingNote {
    // MARK: - 책갈피 탭 뷰
    private var bookmarkTabView: some View {
        VStack {
            // 책갈피가 있다면
            if let bookmarks = vm.bookmarkData, !bookmarks.isEmpty {
                List {
                    ForEach(Array(bookmarks.enumerated()), id: \.offset) { index, item in
                        BookmarkView(bookmark: item)
                            .padding(.vertical, 24)
                        // TODO: 리스트 길어질 때 어떻게 기록하기 버튼 안가려질 수 있을지 방법 찾기
//                            .padding(.bottom, index == bookmarks.count - 1 ? 100 : 0) // 기록하기 버튼 눌러도 마지막 리스트 항목이 가려지지 않도록
                            .swipeActions(edge: .trailing) {
                                Button(role: .destructive) {
                                    vm.bookmarkData?.remove(at: index)
                                } label: {
                                    Image(systemName: "trash.fill")
                                }
                                .tint(.red0)
                            }
                            .listRowInsets(EdgeInsets()) // 전체 패딩 제거
                        
                    }
                }
                .listStyle(.plain)
            }
            // 책갈피가 없다면
            else {
                GreyLogoAndTextView(text: "아직 등록된 책갈피가 없어요.")
            }
        }
    }
    
    // MARK: - 메모 탭 뷰
    private var memoTabView: some View {
        VStack {
            // 메모가 있다면
            if let memos = vm.memoData, !memos.isEmpty {
                List {
                    ForEach(Array(memos.enumerated()), id: \.offset) { index, item in
                        MemoView(memo: item)
                            .padding(.vertical, 24)
                            .swipeActions(edge: .trailing) {
                                Button(role: .destructive) {
                                    vm.memoData?.remove(at: index)
                                } label: {
                                    Image(systemName: "trash.fill")
                                }
                                .tint(.red0)
                            }
                            .listRowInsets(EdgeInsets()) // 전체 패딩 제거
                    }
                }
                .listStyle(.plain)
            }
            // 메모가 없다면
            else {
                GreyLogoAndTextView(text: "아직 작성된 메모가 없어요.")
            }
        }
    }
    
    // MARK: - 인물사전 탭 뷰
    private var characterTabView: some View {
        VStack {
            // 인물사전에 값이 있다면
            if let characters = vm.characterData, !characters.isEmpty {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 10) {
                        ForEach(Array(characters.enumerated()), id: \.offset) { index, item in
                            
                            // 누르면 상세 페이지로 연결되는 인물사전 카드 형태의 버튼
                            NavigationLink {
                                CharacterDetail(character: item)
                            } label: {
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
                    .padding(.top, 5)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 100)
                }
                .padding(.top, 10)
            }
            // 인물사전에 값이 없다면
            else {
                GreyLogoAndTextView(text: "아직 등록된 인물사전이 없어요.")
            }
        }
    }
}
