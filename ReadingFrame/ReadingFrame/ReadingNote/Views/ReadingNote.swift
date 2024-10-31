//
//  ReadingNote.swift
//  ReadingFrame
//
//  Created by 이윤지 on 2/22/24.
//

import SwiftUI

/// 독서노트 화면
struct ReadingNote: View {
    
    /// 책 객체
    @Bindable var book: RegisteredBook
    
    /// 독서노트 삭제 Alert이 띄워졌는지 확인하기 위한 변수
    @State private var isShowBookDeleteAlert = false
    
    /// 위치 삭제 Alert 변수
    @State private var isShowLocationDeleteAlert = false
    
    /// 리뷰 삭제 Alert 변수
    @State private var isShowReviewDeleteAlert = false
    
    /// 버튼 오버레이 여부
    @State private var showOverlay = false
    
//    /// 버튼 프레임
//    @State private var buttonFrame: CGSize = .zero
    
    /// 기록하기 sheet가 띄워져 있는지 확인하는 변수
    @State var isRecordSheetAppear: Bool = false
    
    /// 기록하기 sheet의 picker 띄움 여부 변수
    @State var isPickerAppear: Bool = true
    
    /// 위치검색 sheet 띄움 여부 변수
    @State var showSearchLocation: Bool = false
    
    /// 기록하기 바텀 시트 변수
    @State var selectedTab: String = "책갈피"
    
    // MARK: - View
    var body: some View {
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
                            
                            // MARK: 날짜 리스트
                            dateList
                            
                            // MARK: 독서 진행률
                            readingProgress
                            
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
                        // MARK: 위치 삭제 버튼을 클릭하면 나타나는 Alert
                        .alert(
                            "위치를 삭제하시겠습니까?",
                            isPresented: $isShowLocationDeleteAlert
                        ) {
                            Button("아니오", role: .cancel) { }
                            
                            Button("예", role: .destructive) {
                                book.mainLocation = nil
                                book.mainPlace = nil
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
                                book.reviews = nil
                            }
                        } message: {
                            Text("삭제된 리뷰는 복구할 수 없습니다.")
                        }
                    }
                    // MARK: - 회색 둥근 모서리 박스
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
            
            // MARK: - 기록하기 버튼
            recordBtn
        }
        // MARK: 기록하기 버튼 클릭 시 나타나는 Sheet
        .sheet(isPresented: $isRecordSheetAppear) {
            // 책갈피 등록 sheet 띄우기
            EditAllRecord(
                book: book,
                selectedTab: selectedTab,
                isSheetAppear: $isRecordSheetAppear,
                isPickerAppear: isPickerAppear
            )
        }
        // TODO: 구매/대여한 위치 클릭 시 나타나는 Sheet
//        .sheet(isPresented: $showSearchLocation, content: SearchLocation(showingSearchLocation: $showSearchLocation, pickedPlaceMark: <#Binding<MKPlacemark?>#>))
    }
    
    /// 소장 버튼의 텍스트 색상을 결정하는 변수
    var isMineBtnColor: Color {
        if book.isMine {
            return .white
        } else {
            return .greyText
        }
    }
    
//    /// 독서 상태의 아이콘을 결정하는 변수
//    var readingStatusBtnColor: Color {
//        if book.book.readingStatus == .reading {
//            return .greyText
//        }
//        else {
//            return .white
//        }
//    }
    
//    /// 독서 상태의 텍스트를 결정하는 변수
//    var readingStatusText: String {
//        if book.book.readingStatus == .reading {
//            return "읽는중"
//        }
//        else {
//            return "다읽음"
//        }
//    }
    
    /// 책 유형의 아이콘을 결정하는 변수
    var bookTypeIcon: String {
        if book.bookType == .paperbook {
            return "book.pages.fill"
        }
        else if book.bookType == .eBook {
            return "smartphone"
        }
        else {
            return "headphones"
        }
    }
    
    /// 책 유형의 텍스트를 결정하는 변수
    var bookTypeText: String {
        if book.bookType == .paperbook {
            return "종이책"
        }
        else if book.bookType == .eBook {
            return "전자책"
        }
        else {
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
    
    /// 읽기 시작한 날 정할 수 있는 범위
    var startDateRange: ClosedRange<Date> {
        DateRange().dateRange(date: book.startDate)
    }
    
    /// 다읽은 날 정할 수 있는 범위(읽기 시작한 날 ~ 현재)
    var recentDateRange: ClosedRange<Date> {
        let min = book.startDate
        let max = Date()
        return min...max
    }
}

/// 3개 버튼의 위치 저장을 위함
struct ButtonPosPreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {}
}

#Preview {
    ReadingNote(book: RegisteredBook())
}

// 커스텀 드롭다운 만들려고 시도한 코드들
extension View {
    func customContextMenu<CustomView: View>(
        @ViewBuilder customView: @escaping () -> CustomView,
        menu: @escaping () -> UIMenu,
        tapped: @escaping () -> () = {}
    ) -> some View {
        self.modifier(
            CustomDropDownModifier(
                customView: customView(),
                menu: menu(),
                tapped: tapped
            )
        )
    }
    
    func readSize(onChange: @escaping (CGSize) -> Void) -> some View {
        background(
            GeometryReader { proxy in
                Color.clear
                    .preference(key: ButtonPosPreferenceKey.self, value: proxy.size)
            }
        )
        .onPreferenceChange(ButtonPosPreferenceKey.self, perform: onChange)
    }
    
    func dismissTopViewController() {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        
        if var topController = window?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            topController.dismiss(animated: true)
        }
    }
}

// MARK: - View Parts
extension ReadingNote {
    // MARK: - 책 표지
    private var coverImage: some View {
        LoadableBookImage(bookCover: book.book.cover)
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
            Badge_Info(category: book.book.categoryName)
                .padding(.top, 10)
                .padding(.horizontal, 16)
            
            // 책 이름
            Text(book.book.title)
                .font(.thirdTitle)
                .foregroundStyle(.black0)
                .padding(.top, 15)
                .padding(.horizontal, 16)
            
            // 저자
            Text(book.book.author)
                .font(.footnote)
                .foregroundStyle(.black0)
                .padding(.top, 2)
                .padding(.horizontal, 16)
        }
    }
    
    // MARK: - 3개 버튼 바
    private var threeButtonBar: some View {
        HStack(alignment: .center, spacing: 0) {
            // MARK: 소장 버튼
            Button {
                withAnimation {
                    book.isMine.toggle()
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
                withAnimation {
                    if book.book.readingStatus == .reading {
                        // 읽는중이면 다읽음으로
                        print("readingstatus: \(book.book.readingStatus)")
                        book.book.readingStatus = .finishRead
                        print("읽는중 -> 다읽음")
                        print("readingstatus: \(book.book.readingStatus)")
                    } else if book.book.readingStatus == .finishRead {
                        // 다읽음이면 읽는중으로
                        book.book.readingStatus = .reading
                        print("다읽음 -> 읽는중")
                    }
                }
            } label: {
                HStack(alignment: .center, spacing: 7) {
                    Image(systemName: "book.fill")
                        .font(.headline)
                    Text("다읽음")
                        .fontWeight(.semibold)
                }
                .foregroundStyle(book.book.readingStatus == .reading ? .greyText : .white) // 다 읽으면 흰색, 읽는중이면 회색
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
                // TODO: 눌렀을 때 책 유형 변경하는 버튼들 나와야
                
            } label: {
                HStack(alignment: .center, spacing: 0) {
                    Image(systemName: bookTypeIcon)
                        .font(.headline)
                        .foregroundStyle(.white)
                        .padding(.trailing, 7)
                    Text(bookTypeText)
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
    }
    
    // MARK: - 날짜 리스트
    private var dateList: some View {
        VStack {
            // MARK: 읽기 시작한 날 버튼
            DatePicker(
                "읽기 시작한",
                selection: $book.startDate,
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
                selection: $book.recentDate,
                in: recentDateRange,
                displayedComponents: .date
            )
            .datePickerStyle(.compact)
            .tint(.accentColor)
            .transition(.opacity)
        }
        .padding([.top, .bottom], 10)
        .padding([.leading, .trailing], 12)
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
                HalfCricleGraph(progress: CGFloat(book.readingPercent) / 100)
                    .frame(maxWidth: .infinity)
                    .padding(.top, 10)
                    .padding(.horizontal, 60)
                    .padding(.bottom, -100)
                
                VStack(alignment: .center, spacing: 5) {
                    Text("\(book.readingPercent)%")
                        .font(.system(size: 42, weight: .bold))
                        .fontDesign(.rounded)
                        .foregroundStyle(.black0)
                    
                    Text("\(book.readPage)/\(book.book.totalPage)")
                        .font(.caption)
                        .foregroundStyle(.greyText)
                }
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
            if (book.mainPlace != nil) {
                Text(book.mainPlace!)
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
            if (book.reviews != nil) {
                HStack(alignment: .top, spacing: 0) {
                    Image(systemName: "bubble")
                        .foregroundStyle(.black0)
                        .padding(.trailing, 8)
                    
                    VStack(alignment: .leading, spacing: 0) {
                        // MARK: 최초 리뷰 등록 날짜
                        Text(DateRange().dateToString(date: book.reviews?.reviewDate ?? Date(), style: "yy.MM.dd"))
                            .font(.footnote)
                            .foregroundStyle(.greyText)
                        
                        // MARK: 리뷰 한줄평
                        if let comment =
                            book.reviews?.comment, !comment.isEmpty {
                                Text(comment)
                                .font(.subheadline)
                                .foregroundStyle(.black0)
                                .padding(.top, 5)
                        }
                    }
                    
                    Spacer()
                    
                    // MARK: 리뷰 수정, 삭제 버튼
                    Menu {
                        Button {
                            // TODO: 리뷰 수정 화면으로 이동
                        } label: {
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
                
                VStack(alignment: .center) {
                    // MARK: 리뷰 한단어&키워드
                    if let selectReviews =
                        book.reviews?.selectReviews, !selectReviews.isEmpty {
                        
                        if let keyword =
                            book.reviews?.keyword, !keyword.isEmpty {
                            SelectReviewClusterView(
                                selectReviews: selectReviews,
                                keyword: keyword
                            )
                        }
                        else {
                            SelectReviewClusterView(
                                selectReviews: selectReviews
                            )
                        }
                    }
                }
                .padding(.top, 10)
            }
            // 리뷰가 없다면
            else {
                HStack(alignment: .center, spacing: 0) {
                    Image(systemName: "bubble")
                        .foregroundStyle(.black0)
                        .padding(.trailing, 8)
                    
                    Text("리뷰 작성하기")
                        .foregroundStyle(.black0)
                    
                    Spacer()
                                        
                    // !!!: 리뷰 작성 화면으로 이동
                    NavigationLink {
                        EditReview_Select()
                            .toolbarRole(.editor)
                    } label: {
                        Image(systemName: "chevron.right")
                            .foregroundStyle(.black0)
                    }
                    .frame(width: 13)
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
                
                Text("\(book.bookmarks?.count ?? 0)")
                    .font(.headline)
                    .foregroundStyle(.main)
                    .padding(.leading, 5)
                
                Spacer()
                
                // 책갈피가 1개라도 있다면 더보기 버튼 띄우기
                if (book.bookmarks?.count ?? 0 > 0) {
                    // MARK: 책갈피 목록 더보기 버튼
                    NavigationLink {
                        TabReadingNote(book: book, selectedTab: .bookmark)
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
            if (book.bookmarks != nil) {
                if let bookmarks = book.bookmarks, !bookmarks.isEmpty {
                    NavigationLink {
                        TabReadingNote(book: book, selectedTab: .bookmark)
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
                
                Text("\(book.memos?.count ?? 0)")
                    .font(.headline)
                    .foregroundStyle(.main)
                    .padding(.leading, 5)
                
                Spacer()
                
                // 메모가 1개라도 있다면 더보기 버튼 띄우기
                if (book.memos?.count ?? 0 > 0) {
                    // MARK: 메모 목록 더보기 버튼
                    NavigationLink {
                        TabReadingNote(book: book, selectedTab: .memo)
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
            if (book.memos?.count ?? 0 > 0) {
                if let memos = book.memos, !memos.isEmpty {
                    LazyVStack(spacing: 8) {
                        ForEach(memos.indices, id: \.self) { index in
                            NavigationLink {
                                TabReadingNote(book: book, selectedTab: .memo)
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
                
                Text("\(book.characters?.count ?? 0)")
                    .font(.headline)
                    .foregroundStyle(.main)
                    .padding(.leading, 5)
                
                Spacer()
                
                // 인물사전이 1개라도 있다면 더보기 버튼 띄우기
                if (book.characters?.count ?? 0 > 0) {
                    // MARK: 인물사전 목록 더보기 버튼
                    NavigationLink {
                        TabReadingNote(book: book, selectedTab: .character)
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
            if (book.characters?.count ?? 0 > 0) {
                if let characters = book.characters, !characters.isEmpty {
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
            isPickerAppear.toggle()
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
