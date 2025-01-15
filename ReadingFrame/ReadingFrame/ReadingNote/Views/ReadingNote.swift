//
//  ReadingNote.swift
//  ReadingFrame
//
//  Created by 이윤지 on 2/22/24.
//

import SwiftUI

/// 독서노트 화면
struct ReadingNote: View {
    // MARK: - Properties
    /// 책 객체
    // TODO: book 변수 페이지 연결 로직들 수정하고 삭제 필!
    @Bindable var book: RegisteredBook
    
    /// View Model
    @StateObject var vm: ReadingNoteViewModel
    
    // MARK: Alert 관련 변수들
    /// 독서노트 삭제 Alert이 띄워졌는지 확인하기 위한 변수
    @State private var isShowBookDeleteAlert = false
    
    /// 위치 삭제 Alert 변수
    @State private var isShowLocationDeleteAlert = false
    
    /// 리뷰 삭제 Alert 변수
    @State private var isShowReviewDeleteAlert = false
    
    /// 읽는중에서 다읽음으로 전환하는 Alert 변수
    @State private var isShowTurnToFinishReadAlert = false
    
    /// 다읽음에서 읽는중으로 전환하는 Alert 변수
    @State private var isShowTurnToReadingAlert = false
    
    /// 다읽음에서 읽는중으로 전환할 때 텍스트필드로 받아오는 값
    @State private var enteredPage = ""
    
    
    // MARK: Sheet 띄움 여부 관련 변수들
    /// 기록하기 sheet가 띄워져 있는지 확인하는 변수
    @State var isRecordSheetAppear: Bool = false
        
    /// 위치검색 sheet 띄움 여부 변수
    @State var showSearchLocation: Bool = false
    
    /// 기록하기 바텀 시트 변수
    @State var selectedTab: String = "책갈피"
    
    /// 리뷰 fullscreenCover 띄움 여부 변수
    @State var showReviewFullscreen: Bool = false
    
    /// 책 유형 버튼 표시 여부
    @State private var showBookTypeButtons: Bool = false
    
    // MARK: 네비게이션 스택 관련 변수들
    @State private var path: [ReviewNavigationDestination] = []
        
    func popToRoot() {
        path.removeAll()
    }
    
    func popLast() {
        path.removeLast()
    }
        
    
    // MARK: 계산 프로퍼티
    /// 소장 버튼의 텍스트 색상을 결정하는 변수
    var isMineBtnColor: Color {
        if ((vm.book?.isMine) != nil) {
            return .white
        } else {
            return .greyText
        }
    }
    
    /// 읽기 시작한 날 정할 수 있는 범위
    var startDateRange: ClosedRange<Date> {
        DateRange().dateRange(date: vm.book?.startDate ?? Date())
    }
    
    /// 다읽은 날 정할 수 있는 범위(읽기 시작한 날 ~ 현재)
    var recentDateRange: ClosedRange<Date> {
        let min = vm.book?.startDate ?? Date()
        let max = Date()
        return min...max
    }
    
    // MARK: - init
    // TODO: 아규먼트에 isbn 받아서 만드는 방식으로 수정하기, 현재는 더미 isbn 넣어둔 상태!
    init(book: RegisteredBook) {
        self.book = book
        self._vm = StateObject(wrappedValue: ReadingNoteViewModel(isbn: "isbn"))
    }
    
    
    
    // MARK: - View
    var body: some View {
        NavigationStack(path: $path) {
            ZStack(alignment: .bottom) {
                ScrollView {
                    ZStack(alignment: .topLeading) {
                        // 화면 윗부분은 흰색으로 설정
                        Rectangle()
                            .fill(.white)
                        
                        VStack(alignment: .leading, spacing: 0) {
                            // MARK: 책 표지
                            coverImage
                            
                            
                            VStack(alignment: .leading, spacing: 0) {
                                // MARK: 기본 책정보: 책정보 배지, 책 이름, 저자
                                basicBookInfo
                                
                                // MARK: 3개 버튼 바
                                threeButtonBar
                                    .frame(height: 200, alignment: .top)
                                    .zIndex(1)
                                
                                // MARK: 날짜 리스트
                                dateList
                                    .padding(.top, -120)
                                    .zIndex(0)
                                
                                // MARK: 독서 진행률
                                readingProgress
                                    .zIndex(0)
                                
                                // MARK: 대표위치
                                locationBox
                                
                                // MARK: 리뷰 박스
                                reviewBox
                                
                                // MARK: 책갈피 구역
                                bookmarkSection
                                
                                // MARK: 메모 구역
                                memoSection
                                
                                // MARK: 인물사전
                                characterSection
                            }
                            .padding(.bottom, 50)
                            // MARK: - Alerts
                            // MARK: 위치 삭제 버튼을 클릭하면 나타나는 Alert
                            .alert(
                                "위치를 삭제하시겠습니까?",
                                isPresented: $isShowLocationDeleteAlert
                            ) {
                                Button("아니오", role: .cancel) { }
                                
                                Button("예", role: .destructive) {
                                    vm.book?.mainLocation = nil
                                    
                                    // TODO: 대표위치 삭제 API 호출
                                }
                            } message: {
                                Text("삭제된 위치는 복구할 수 없습니다.")
                            }
                            // MARK: 리뷰 삭제 버튼을 클릭하면 나타나는 Alert
                            .alert(
                                "리뷰를 삭제하시겠습니까?",
                                isPresented: $isShowReviewDeleteAlert
                            ) {
                                Button("아니오", role: .cancel) { }
                                
                                Button("예", role: .destructive) {
                                    // view상의 리뷰 삭제
                                    vm.book?.selectReview = nil
                                    vm.book?.commentReview = nil
                                    vm.book?.keywordReview = nil
                                    
                                    // TODO: 리뷰 전체 삭제 API 호출
                                }
                            } message: {
                                Text("삭제된 리뷰는 복구할 수 없습니다.")
                            }
                            // MARK: 읽는중에서 다읽음 버튼 클릭하면 나타나는 Alert
                            .alert(
                                "\'다읽음\'설정하시겠습니까?",
                                isPresented: $isShowTurnToFinishReadAlert
                            ) {
                                Button("아니오", role: .cancel) { }
                                
                                Button("예", role: .destructive) {
                                    withAnimation {
                                        vm.turnToFinishRead()
                                    }
                                }
                            } message: {
                                Text("독서 진행률이 100%가 되고,\n마지막으로 읽은 날짜가 오늘로 변경됩니다.")
                            }
                            // MARK: 다읽음 상태에서 버튼 한 번 더 클릭하면 나타나는 Alert
                            .alert(
                                "독서 진행률 설정",
                                isPresented: $isShowTurnToReadingAlert
                            ) {
                                TextField("123456", text: $enteredPage)
                                    .keyboardType(.decimalPad)
                                
                                Button("취소", role: .none) { }
                                
                                Button("확인", role: .none) {
                                    withAnimation {
                                        vm.turnToReading(p: Int(enteredPage))
                                        enteredPage.removeAll()
                                    }
                                }
                            } message: {
                                Text("마지막으로 읽은 페이지를 입력해 주세요.\n미작성 시 진행률이 0%로 설정됩니다.")
                            }
                        }
                        // MARK: - 배경: 회색 둥근 모서리 박스
                        .background(
                            RoundedRadiusBox(radius: 20, corners: [.topLeft, .topRight])
                                .fill(.grey1)
                                .padding(.top, 176)
                        )
                        .padding(.top, 100)
                    }
                    .background(.white)
                }
                // 스크롤 끝까지 내렸을 때 기록하기 버튼에 노트 내용 안가려지도록
                .padding(.bottom, 70)
                // 화면 전체적으로 회색으로 설정
                .background(.grey1)
                // 화면 꽉 채우기
                .ignoresSafeArea(.container)
                
                // MARK: - 기록하기 버튼
                recordBtn
            }
            // MARK: - 네비게이션 바 관련 코드 구역
            // MARK: 네비게이션 바 설정
            .navigationTitle("독서노트")
            .navigationBarTitleDisplayMode(.inline)
            // MARK: 툴바의 오른쪽 삭제 버튼
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        isShowBookDeleteAlert.toggle()
                    } label: {
                        Text("삭제")
                            .foregroundStyle(.red0)
                    }
                    // MARK: 삭제 버튼 클릭 시 나타나는 Alert
                    .alert(
                        "독서노트를 삭제하시겠습니까?",
                        isPresented: $isShowBookDeleteAlert
                    ) {
                        Button("아니오", role: .cancel) { }
                        Button("예", role: .destructive) {
                            // TODO: 독서노트 삭제
                        }
                    } message: {
                        Text("삭제된 독서노트는 복구할 수 없습니다.")
                    }
                }
            }
            // MARK: - 화면 연결 관련 구역
            // MARK: 기록하기 버튼 클릭 시 나타나는 Sheet
            .sheet(isPresented: $isRecordSheetAppear) {
                // 책갈피 등록 sheet 띄우기
                EditAllRecord(
                    book: EditRecordBookModel(bookType: vm.book!.bookType,
                                              totalPage: vm.book?.totalPage ?? 0,
                                              isbn: vm.isbn),
                    isSheetAppear: $isRecordSheetAppear,
                    selectedTab: selectedTab,
                    isPickerAppear: true
                )
            }
            // TODO: 구매/대여한 위치 클릭 시 나타나는 Sheet
            //        .sheet(isPresented: $showSearchLocation, content: SearchLocation(showingSearchLocation: $showSearchLocation, pickedPlaceMark: <#Binding<MKPlacemark?>#>))
            // MARK: 리뷰 작성 Navigation 연결
            .navigationDestination(for: ReviewNavigationDestination.self) { destination in
                if destination.identifier == "EditReview_Select_Make" {
                    EditReview_Select(
                        popToRootAction: popToRoot
                    )
                    .toolbarRole(.editor) // back 텍스트 표시X
                    .navigationBarBackButtonHidden()
                }
                else if destination.identifier == "EditReview_Select_Edit" {
                    if case let .editReview_select_edit(data) = destination {
                        EditReview_Select(
                            review: data,
                            isEditMode: true,
                            popToRootAction: popToRoot
                        )
                        .toolbarRole(.editor) // back 텍스트 표시X
                        .navigationBarBackButtonHidden()
                    }
                }
                else if destination.identifier == "EditReview_Keyword" {
                    if case let .editReview_keyword(data) = destination {
                        EditReview_Keyword(
                            review: data,
                            popToRootAction: popToRoot,
                            dismissAction: popLast
                        )
                        .toolbarRole(.editor) // back 텍스트 표시X
                        .navigationBarBackButtonHidden()
                    }
                }
                else if destination.identifier == "EditReview_Comment" {
                    if case let .editReview_comment(data) = destination {
                        EditReview_Comment(
                            review: data,
                            popToRootAction: popToRoot,
                            dismissAction: popLast
                        )
                        .toolbarRole(.editor) // back 텍스트 표시X
                        .navigationBarBackButtonHidden()
                    }
                }
                else if destination.identifier == "EditReview_CheckReviews" {
                    if case let .editReview_checkReviews(data) = destination {
                        EditReview_CheckReviews(
                            review: data,
                            popToRootAction: popToRoot
                        )
                        .toolbarRole(.editor) // back 텍스트 표시X
                        .navigationBarBackButtonHidden()
                    }
                }
            }
        }
    }
}


// MARK: - View Parts
extension ReadingNote {
    // MARK: - 책 표지
    private var coverImage: some View {
        LoadableBookImage(bookCover: vm.book?.cover ?? "")
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .frame(width: 138, height: 210)
            .frame(maxWidth: .infinity)
            .shadow(color: Color(red: 0.47, green: 0.47, blue: 0.47).opacity(0.3), radius: 7.5, x: 0, y: 0)
            .padding(.top, 25)
    }
    
    // MARK: - 기본 책정보: 책정보 배지, 책 이름, 저자
    private var basicBookInfo: some View {
        VStack(alignment: .leading, spacing: 0) {
            // 책정보 배지
            Badge_Info(category: vm.book?.categoryName ?? .etc)
                .padding(.top, 10)
                .padding(.horizontal, 16)
            
            // 책 이름
            Text(vm.book?.title ?? "")
                .font(.thirdTitle)
                .foregroundStyle(.black0)
                .padding(.top, 15)
                .padding(.horizontal, 16)
            
            // 저자
            Text(vm.book?.author ?? "")
                .font(.footnote)
                .foregroundStyle(.black0)
                .padding(.top, 2)
                .padding(.horizontal, 16)
        }
    }
    
    // MARK: - 3개 버튼 바
    private var threeButtonBar: some View {
        ZStack(alignment: .top) {
            HStack(alignment: .center, spacing: 0) {
                // MARK: 소장 버튼
                Button {
                    withAnimation {
                        vm.toggleIsMine()
                    }
                } label: {
                    HStack(alignment: .center, spacing: 0) {
                        Image(systemName: "checkmark")
                            .font(.headline)
                            .foregroundStyle(isMineBtnColor)
                            .padding(.trailing, 7)
                        Text("소장")
                            .foregroundStyle(isMineBtnColor)
                            .fontWeight(.semibold)
                    }
                    .padding([.top, .bottom], 18)
                    .frame(maxWidth: .infinity)
                    .background(.black0)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                }
                
                // 구분선
                Rectangle()
                    .foregroundStyle(.greyText)
                    .frame(width: 0.7, height: 40)
                
                // MARK: 독서 상태 변경 버튼(읽는중, 다읽음)
                Button {
                    // 읽는중이면 다읽음으로
                    if vm.book?.readingStatus == .reading {
                        
                        // 다읽음 변경할거냐는 alert 띄우기
                        self.isShowTurnToFinishReadAlert.toggle()
                    }
                    // 다읽음이면 읽는중으로
                    else if vm.book?.readingStatus == .finishRead {
                        // 독서 진행률 변경 alert 띄우기
                        self.isShowTurnToReadingAlert.toggle()
                    }
                } label: {
                    HStack(alignment: .center, spacing: 7) {
                        Image(systemName: "book.fill")
                            .font(.headline)
                        Text("다읽음")
                            .fontWeight(.semibold)
                    }
                    .foregroundStyle(vm.book?.readingStatus == .reading ? .greyText : .white) // 다 읽으면 흰색, 읽는중이면 회색
                }
                .padding(.vertical, 18)
                .frame(maxWidth: .infinity)
                .background(.black0)
                
                // 구분선
                Rectangle()
                    .foregroundStyle(.greyText)
                    .frame(width: 0.7, height: 40)
                
                // MARK: 책 유형 변경 버튼
                Button {
                    withAnimation {
                        showBookTypeButtons.toggle()
                    }
                } label: {
                    HStack(alignment: .center, spacing: 0) {
                        Image(systemName: getBookTypeIcon(type: vm.book?.bookType ?? .paperbook))
                            .font(.headline)
                            .foregroundStyle(.white)
                            .padding(.trailing, 7)
                        Text(getBookTypeText(type: vm.book?.bookType ?? .paperbook))
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                    }
                    .padding([.top, .bottom], 18)
                    .frame(maxWidth: .infinity)
                    .background(.black0)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                }
            }
            .background(.black0)
            .cornerRadius(15)
            .padding(.top, 20)
            .padding(.horizontal, 16)
            .shadow(color: Color(red: 0.47, green: 0.47, blue: 0.47).opacity(0.3), radius: 7.5, x: 0, y: 0)
            
            // 책 유형 버튼 누르면 나오는 전환용 버튼들
            if showBookTypeButtons {
                VStack(spacing: 10) {
                    // 종이책 버튼
                    if vm.book?.bookType != .paperbook {
                        Button {
                            withAnimation {
                                showBookTypeButtons = false
                                vm.changeBookType(to: .paperbook)
                            }
                        } label: {
                            HStack(alignment: .center, spacing: 0) {
                                Image(systemName: getBookTypeIcon(type: .paperbook))
                                    .font(.headline)
                                    .foregroundStyle(.white)
                                    .padding(.trailing, 7)
                                Text(getBookTypeText(type: .paperbook))
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.white)
                            }
                            .padding(18)
                            .frame(minWidth: 120, maxWidth: 125)
                            .background(.black0)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .padding(.trailing, 16)
                        }
                    }
                    
                    // 전자책 버튼
                    if vm.book?.bookType != .eBook {
                        Button {
                            withAnimation {
                                showBookTypeButtons = false
                                vm.changeBookType(to: .eBook)
                            }
                        } label: {
                            HStack(alignment: .center, spacing: 0) {
                                Image(systemName: getBookTypeIcon(type: .eBook))
                                    .font(.headline)
                                    .foregroundStyle(.white)
                                    .padding(.trailing, 7)
                                Text(getBookTypeText(type: .eBook))
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.white)
                            }
                            .padding(18)
                            .frame(minWidth: 120, maxWidth: 125)
                            .background(.black0)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .padding(.trailing, 16)
                        }
                    }
                    
                    // 오디오북 버튼
                    if vm.book?.bookType != .audioBook {
                        Button {
                            withAnimation {
                                showBookTypeButtons = false
                                vm.changeBookType(to: .audioBook)
                            }
                        } label: {
                            HStack(alignment: .center, spacing: 0) {
                                Image(systemName: getBookTypeIcon(type: .audioBook))
                                    .font(.headline)
                                    .foregroundStyle(.white)
                                    .padding(.trailing, 7)
                                Text(getBookTypeText(type: .audioBook))
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.white)
                            }
                            .padding(18)
                            .frame(maxWidth: 125)
                            .background(.black0)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .padding(.trailing, 16)
                        }
                    }
                }
                .padding(.top, 90)
                .transition(.opacity)
            }
        }
    }
    
    // MARK: - 날짜 리스트
    private var dateList: some View {
        VStack {
            // MARK: 읽기 시작한 날 버튼
            DatePicker(
                "읽기 시작한",
                selection: vm.startDateBinding,
                in: startDateRange,
                displayedComponents: .date
            )
            // 달력 모양의 graphical style
            .datePickerStyle(.compact)
            .tint(.accentColor)
            .transition(.opacity)
            
            // 구분선
            Rectangle()
                .foregroundStyle(.grey2)
                .frame(height: 1)
            
            // MARK: 마지막으로 읽은 날 버튼
            DatePicker(
                "마지막으로 읽은",
                selection: vm.recentDateBinding,
                in: recentDateRange,
                displayedComponents: .date
            )
            .datePickerStyle(.compact)
            .tint(.accentColor)
            .transition(.opacity)
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 12)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(.white)
        )
        .padding(.top, 20)
        .padding(.horizontal, 16)
    }
    
    // MARK: - 독서 진행률 박스
    private var readingProgress: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 0) {
                Text("독서 진행률")
                    .foregroundStyle(.black0)
                    .fontWeight(.bold)
                    .padding(.top, 16)
                    .padding(.leading, 12)
                    .padding(.bottom, 6)
                
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .background(
                RoundedRadiusBox(radius: 15, corners: [.topLeft, .topRight])
                    .fill(.white)
            )
            .padding(.top, 10)
            .padding(.horizontal, 16)
            
            // MARK: 진행 막대 반원
            ZStack(alignment: .center) {
                HalfCricleGraph(progress: CGFloat(vm.book?.readingPercent ?? 0) / 100)
                    .frame(maxWidth: .infinity)
                    .padding(.top, 10)
                    .padding(.horizontal, 60)
                    .padding(.bottom, -100)
                
                VStack(alignment: .center, spacing: 5) {
                    Text("\(vm.book?.readingPercent ?? 0)%")
                        .font(.system(size: 42, weight: .bold))
                        .fontDesign(.rounded)
                        .foregroundStyle(.black0)
                    
                    Text("\(vm.book?.readPage ?? 0)/\(vm.book?.totalPage ?? 0)")
                        .font(.caption)
                        .foregroundStyle(.greyText)
                }
                .padding(.top, 20)
            }
            .background(
                RoundedRadiusBox(radius: 15, corners: [.bottomLeft, .bottomRight])
                    .fill(.white)
            )
            .padding(.horizontal, 16)
        }
    }
    
    // MARK: - 대표위치
    private var locationBox: some View {
        // MARK: 위치 추가 버튼
        HStack(spacing: 0) {
            Image(systemName: "map")
                .foregroundStyle(.black0)
                .padding(.trailing, 8)
            
            // 대표위치가 있을 때: 장소 이름 + 수정 & 삭제 메뉴
            if let mainLocation = vm.book?.mainLocation {
                Text(mainLocation)
                    .foregroundStyle(.black0)
                
                Spacer()
                
                // - MARK: 위치 수정, 삭제 버튼
                Menu {
                    Button {
                        // TODO: 위치 검색화면 연결
                    } label: {
                        Label("수정", systemImage: "pencil.line")
                    }
                    
                    Button(role: .destructive) {
                        isShowLocationDeleteAlert.toggle()
                    } label: {
                        Label("삭제", systemImage: "trash")
                    }
                } label : {
                    Image(systemName: "ellipsis")
                        .foregroundStyle(.black0)
                }
            }
            // 대표위치가 없을 때: 위치검색화면 연결
            else {
                // TODO: 위치 검색화면 연결
                Text("구매/대여한 위치")
                    .foregroundStyle(.greyText)
                    .onTapGesture {
                        self.showSearchLocation = true
                    }
                    
                
                Spacer()
            }
        }
        .padding([.top, .bottom], 17)
        .padding([.leading, .trailing], 12)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(.white)
        )
        .padding(.top, 10)
        .padding(.horizontal, 16)
    }
    
    // MARK: - 리뷰 박스
    private var reviewBox: some View {
        VStack(spacing: 0) {
            // 리뷰가 있다면
            if let selectReviews = vm.book?.selectReview {
                HStack(alignment: .top, spacing: 0) {
                    Image(systemName: "bubble")
                        .foregroundStyle(.black0)
                        .padding(.trailing, 8)
                    
                    VStack(alignment: .leading, spacing: 0) {
                        // MARK: 최초 리뷰 등록 날짜
                        Text(DateRange().dateToString(date: vm.book?.firstReviewDate ?? Date(), style: "yy.MM.dd"))
                            .font(.footnote)
                            .foregroundStyle(.greyText)
                        
                        // MARK: 리뷰 한줄평
                        if let comment =
                            vm.book?.commentReview, !comment.isEmpty {
                                Text(comment)
                                .font(.subheadline)
                                .foregroundStyle(.black0)
                                .padding(.top, 5)
                                .lineLimit(nil)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                    }
                    
                    Spacer()
                    
                    // MARK: 리뷰 수정, 삭제 버튼
                    Menu {
                        NavigationLink(
                            value: ReviewNavigationDestination.editReview_checkReviews(data: vm.getReview())
                        ) {
                            Label("수정", systemImage: "pencil.line")
                        }
                        
                        Button(role: .destructive) {
                            isShowReviewDeleteAlert.toggle()
                        } label: {
                            Label("삭제", systemImage: "trash")
                        }
                    } label : {
                        Image(systemName: "ellipsis")
                            .foregroundStyle(.black0)
                    }
                }
                
                // MARK: 리뷰 한단어&키워드
                if !selectReviews.isEmpty {
                    SelectReviewClusterView(
                        selectReviews: selectReviews,
                        keyword: vm.book?.keywordReview
                    )
                    .padding(.top, 10)
                }
            }
            // 리뷰가 없다면
            else {
                // 리뷰 작성 화면으로 이동
                NavigationLink(
                    value: ReviewNavigationDestination.editReview_select_make
                ) {
                    HStack(alignment: .center, spacing: 0) {
                        Image(systemName: "bubble")
                            .foregroundStyle(.black0)
                            .padding(.trailing, 8)
                        
                        Text("리뷰 작성하기")
                            .foregroundStyle(.black0)
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .foregroundStyle(.black0)
                            .frame(width: 13)
                    }
                }
            }
        }
        .padding(.vertical, 17)
        .padding(.horizontal, 12)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(.white)
        )
        .padding(.top, 10)
        .padding(.horizontal, 16)
    }
    
    // MARK: - 책갈피 구역
    private var bookmarkSection: some View {
        VStack(alignment: .leading, spacing: 0) {
            // MARK: 책갈피 구역 bar
            HStack(spacing: 0) {
                Text("책갈피")
                    .font(.headline)
                    .foregroundStyle(.black0)
                
                Text("\(vm.book?.bookmarks?.count ?? 0)")
                    .font(.headline)
                    .foregroundStyle(.main)
                    .padding(.leading, 5)
                
                Spacer()
                
                // 책갈피가 1개라도 있다면 더보기 버튼 띄우기
                if (vm.book?.bookmarks?.count ?? 0 > 0) {
                    // MARK: 책갈피 목록 더보기 버튼
                    NavigationLink {
                        TabReadingNote(bookType: vm.book?.bookType ?? .paperbook,
                                       totalPage: vm.book?.totalPage ?? 0,
                                       isbn: vm.isbn,
                                       selectedTab: .bookmark)
                            .toolbarRole(.editor) // back 텍스트 표시X
                            .toolbar(.hidden, for: .tabBar) // toolbar 숨기기
                    } label: {
                        Image(systemName: "chevron.right")
                            .foregroundStyle(.black0)
                    }
                }
            }
            .padding(.top, 35)
            .padding(.horizontal, 16)
            
            // MARK: 책갈피 리스트
            // 책갈피가 있을 때
            if let bookmarks = vm.book?.bookmarks, !bookmarks.isEmpty {
                NavigationLink {
                    TabReadingNote(bookType: vm.book?.bookType ?? .paperbook,
                                   totalPage: vm.book?.totalPage ?? 0,
                                   isbn: vm.isbn,
                                   selectedTab: .bookmark)
                        .toolbarRole(.editor) // back 텍스트 표시X
                        .toolbar(.hidden, for: .tabBar) // toolbar 숨기기
                } label: {
                    LazyVStack(spacing: 20) {
                        ForEach(bookmarks.indices, id: \.self) { index in
                            BookmarkView(bookmark: bookmarks[index])
                            
                            // 마지막 값이 아닌 경우에만 구분선 추가
                            if index != bookmarks.count - 1 {
                                Divider()
                                    .background(.grey2)
                                    .padding(.horizontal, 16)
                            }
                        }
                    }
                    .padding(.vertical, 20)
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .fill(.white)
                    )
                }
                .padding(.top, 20)
                .padding(.horizontal, 16)
            }
            // 책갈피가 없을 때
            else {
                HStack(spacing: 0) {
                    Image(systemName: "bookmark")
                        .font(.system(size: 24))
                        .foregroundStyle(.main)
                        .padding(.trailing, 12)
                    
                    Text("아직 추가된 책갈피가 없어요")
                        .font(.subheadline)
                        .foregroundStyle(.black0)
                    
                    Spacer()
                }
                .padding([.leading, .trailing], 16)
                .padding([.top, .bottom], 33)
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .fill(.white)
                )
                .padding(.top, 20)
                .padding(.horizontal, 16)
            }
        }
    }
    
    // MARK: - 메모 구역
    private var memoSection: some View {
        VStack(alignment: .leading, spacing: 0) {
            // MARK: 메모 구역 bar
            HStack(spacing: 0) {
                Text("메모")
                    .font(.headline)
                    .foregroundStyle(.black0)
                
                Text("\(vm.book?.memos?.count ?? 0)")
                    .font(.headline)
                    .foregroundStyle(.main)
                    .padding(.leading, 5)
                
                Spacer()
                
                // 메모가 1개라도 있다면 더보기 버튼 띄우기
                if (vm.book?.memos?.count ?? 0 > 0) {
                    // MARK: 메모 목록 더보기 버튼
                    NavigationLink {
                        TabReadingNote(bookType: vm.book?.bookType ?? .paperbook,
                                       totalPage: vm.book?.totalPage ?? 0,
                                       isbn: vm.isbn,
                                       selectedTab: .memo)
                            .toolbarRole(.editor) // back 텍스트 표시X
                            .toolbar(.hidden, for: .tabBar) // toolbar 숨기기
                    } label: {
                        Image(systemName: "chevron.right")
                            .foregroundStyle(.black0)
                    }
                }
            }
            .padding(.top, 35)
            .padding(.horizontal, 16)
            
            // MARK: 메모 리스트
            // 메모가 1개라도 있다면
            if let memos = vm.book?.memos, !memos.isEmpty {
                LazyVStack(spacing: 8) {
                    ForEach(memos.indices, id: \.self) { index in
                        NavigationLink {
                            TabReadingNote(bookType: vm.book?.bookType ?? .paperbook,
                                           totalPage: vm.book?.totalPage ?? 0,
                                           isbn: vm.isbn,
                                           selectedTab: .memo)
                                .toolbarRole(.editor) // back 텍스트 표시X
                                .toolbar(.hidden, for: .tabBar) // toolbar 숨기기
                        } label: {
                            MemoView(memo: memos[index])
                        }
                    }
                }
                .padding(.top, 20)
                .padding(.horizontal, 16)
            }
            // 메모가 없다면
            else {
                VStack(alignment: .leading, spacing: 0) {
                    HStack(spacing: 0) {
                        Text("0p")
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundStyle(.black0)
                        
                        Text("(0%)")
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundStyle(.greyText)
                        
                        Spacer()
                    }
                    
                    Text("아직 작성된 메모가 없어요")
                        .font(.system(size: 15, weight: .regular))
                        .foregroundStyle(.black0)
                        .padding(.top, 8)
                }
                .padding(16)
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .fill(.white)
                )
                .padding(.top, 20)
                .padding(.horizontal, 16)
            }
        }
    }
    
    // MARK: - 인물사전 구역
    private var characterSection: some View {
        VStack(alignment: .leading, spacing: 0) {
            // MARK: 인물사전 구역 bar
            HStack(spacing: 0) {
                Text("인물사전")
                    .font(.headline)
                    .foregroundStyle(.black0)
                
                Text("\(vm.book?.characters?.count ?? 0)")
                    .font(.headline)
                    .foregroundStyle(.main)
                    .padding(.leading, 5)
                
                Spacer()
                
                // 인물사전이 1개라도 있다면 더보기 버튼 띄우기
                if (vm.book?.characters?.count ?? 0 > 0) {
                    // MARK: 인물사전 목록 더보기 버튼
                    NavigationLink {
                        TabReadingNote(bookType: vm.book?.bookType ?? .paperbook,
                                       totalPage: vm.book?.totalPage ?? 0,
                                       isbn: vm.isbn,
                                       selectedTab: .character)
                            .toolbarRole(.editor) // back 텍스트 표시X
                            .toolbar(.hidden, for: .tabBar) // toolbar 숨기기
                    } label: {
                        Image(systemName: "chevron.right")
                            .foregroundStyle(.black0)
                    }
                }
            }
            .padding(.top, 35)
            .padding(.horizontal, 16)
            
            // MARK: 인물사전 리스트
            // 인물사전이 1개라도 있다면
            if let characters = vm.book?.characters, !characters.isEmpty {
                ScrollView(.horizontal) {
                    LazyHStack(spacing: 10) {
                        ForEach(characters.indices, id: \.self) { index in
                            NavigationLink {
                                CharacterDetail(character: characters[index])
                                    .toolbarRole(.editor) // back 텍스트 표시X
                                    .toolbar(.hidden, for: .tabBar) // toolbar 숨기기
                            } label: {
                                CharacterView(character: characters[index])
                                    .padding(.vertical, 15)
                                    .padding(.horizontal, 10)
                                    .frame(width: 126, height: 180)
                                    .background(
                                        RoundedRectangle(cornerRadius: 15)
                                            .fill(.white)
                                    )
                            }
                        }
                        
                        // 인물사전 추가하기 버튼
                        Button {
                            isRecordSheetAppear.toggle()
                            selectedTab = "인물사전"
                        } label: {
                            characterAddBtn
                        }
                    }
                    .padding(.horizontal, 16)
                }
                .scrollIndicators(.hidden)
                .frame(height: 180)
                .padding(.top, 20)
            }
            // 인물사전이 없다면
            else {
                // 인물사전 추가하기 버튼
                Button {
                    isRecordSheetAppear.toggle()
                    selectedTab = "인물사전"
                } label: {
                    characterAddBtn
                        .padding(.top, 20)
                        .padding(.horizontal, 16)
                }
            }
        }
    }
    
    // MARK: - 인물사전 추가하기 버튼
    private var characterAddBtn: some View {
        VStack(spacing: 8) {
            Image(systemName: "plus.circle.fill")
                .font(.system(size: 24))
                .foregroundStyle(.black0)
            
            Text("추가하기")
                .font(.system(size: 15, weight: .bold))
                .foregroundStyle(.black0)
        }
        .padding([.leading, .trailing], 36)
        .padding([.top, .bottom], 66)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(.white)
        )
    }
    
    // MARK: - 기록하기 버튼
    private var recordBtn: some View {
        Button {
            isRecordSheetAppear.toggle()
            selectedTab = "책갈피"
        } label: {
            Text("기록하기")
                .font(.headline)
                .padding(10)
                .frame(maxWidth: .infinity, alignment: .center)
        }
        .tint(.main)
        .buttonStyle(.borderedProminent)
        .clipShape(.capsule)
        .shadow(color: Color(red: 0.47, green: 0.47, blue: 0.47).opacity(0.3), radius: 7.5, x: 0, y: 0)
        .padding(.horizontal, 16)
        .padding(.bottom, 15)
    }
}

// MARK: - Methods
extension ReadingNote {
    /// 책 유형의 아이콘을 결정하는 변수
    func getBookTypeIcon(type: BookType) -> String {
        switch type {
        case .paperbook:
            return "book.pages.fill"
        case .eBook:
            return "smartphone"
        case .audioBook:
            return "headphones"
        }
    }
    
    /// 책 유형의 텍스트를 결정하는 변수
    func getBookTypeText(type: BookType) -> String {
        switch type {
        case .paperbook:
            return "종이책"
        case .eBook:
            return "전자책"
        case .audioBook:
            return "오디오북"
        }
    }
    
    /// 버튼에 들어갈 날짜 정보
    func dateToString(date: Date) -> String {
        // DateFormatter 지정
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd."
        
        // Date -> String
        let dateFormat = dateFormatter.string(from: date)
        
        return dateFormat
    }
}


#Preview {
    ReadingNote(book: RegisteredBook())
}
