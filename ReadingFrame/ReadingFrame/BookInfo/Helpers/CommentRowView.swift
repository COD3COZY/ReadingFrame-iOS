//
//  CommentRowView.swift
//  ReadingFrame
//
//  Created by 석민솔 on 2/27/24.
//

import SwiftUI

/// 한줄평 List Row
struct CommentRowView: View {
    // MARK: - Property
    
    /// API 호출해서 BookInfo_Review 페이지에서 받아올 한줄평 정보
    @Bindable var comment: Comment
    
    /// 버튼에 들어갈 날짜 text
    var dateString: String {
        // DateFormatter 형식 지정
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        
        // Date -> String
        let dateString = dateFormatter.string(from: comment.commentDate)
        
        return dateString
    }
    
    /// 이 row의 리뷰가 유저의 리뷰인지 확인하고 더보기 버튼 대신 삭제 버튼을 띄워줄 값
    var isMyReview: Bool {
        // TODO: 내 닉네임과 comment 닉네임이 일치하는지 검사
        // 지금은 일단 dummy로 독서왕으로 설정
        // (나중에 UserDefaults를 이용하던지 해서) 현재 앱의 유저 닉네임 데이터와 비교하기
        if (comment.nickname == "독서왕") {
            return true
        } else {
            return false
        }
    }
    
    // Alert 보여주기용 변수들
    /// 신고 - 스팸/도배성 리뷰 alert 보여줄지 여부
    @State private var showSpamComplaintAlert = false
    
    /// 신고 - 부적절한 리뷰 alert 보여줄지 여부
    @State private var showInappropriateComplaintAlert = false
    
    /// 이미 이미 신고한 리뷰입니다 alert 보여줄지 여부
    @State private var showAlreadyComplaintAlert = false

    /// 리뷰를 정말 삭제하시겠습니까 alert 보여줄지 여부
    @State private var showReviewDeleteAlert = false

    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            // 닉네임, 날짜, 메뉴 버튼
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 3) {
                    // MARK: 닉네임
                    Text(comment.nickname)
                        .font(.subheadline.weight(.bold))
                    
                    // MARK: 날짜
                    Text(dateString)
                        .font(.footnote)
                        .foregroundStyle(.greyText)
                        .padding(.bottom, 9)
                }
                
                Spacer()
                
                // MARK: 메뉴 or 삭제 버튼
                if isMyReview {
                    // MARK: 내가 쓴 리뷰라면 삭제 '버튼'
                    Button(action: { }) {
                        Image(systemName: "xmark")
                            .font(.body)
                            .foregroundStyle(.black0)
                    }
                    // list의 row에 포함된 버튼에서는 action 대신 onTapGesture 사용해서 버튼 부분에만 의도한 액션이 작동되도록 함(버튼 이외 다른 부분 눌러도 삭제 알람 뜨는 이슈 존재)
                    .onTapGesture {
                        print("내가 쓴 한줄평 삭제")
                        // 리뷰를 정말 삭제하시겠습니까 알람창 띄워주기
                        self.showReviewDeleteAlert.toggle()
                    }
                    
                    // 버튼 눌렀을 때 띄워줄 alert
                    .alert(isPresented: $showReviewDeleteAlert) {
                        /// 리뷰 삭제하시겠습니까 alert의 "예" 버튼
                        let doDeleteButton = Alert.Button.destructive(Text("예")) {
                            // 화면상에서 리뷰 삭제하기
                            withAnimation(.easeOut) {
                                self.comment.isVisible = false
                            }
                            
                            // TODO: API 상에서 한줄평 삭제
                            
                        }
                        
                        return Alert(title: Text("리뷰를 정말 삭제하시겠습니까?"),
                                     message: Text("삭제된 리뷰는 복구할 수 없습니다."),
                                     primaryButton: .default(Text("아니요")),
                                     secondaryButton: doDeleteButton)
                    }
                } else {
                    // MARK: 내가 쓴 리뷰가 아니라면 신고 메뉴
                    Menu {
                        // > 신고하기
                        Menu("신고하기") {
                            // 세부 메뉴 1: 부적절한 리뷰
                            Button("부적절한 리뷰", action: {
                                print("부적절한 리뷰입니다.")
                                // TODO: 신고 알람창 띄우기
                                
                                // 신고하겠다는 확인 들어오면
                                // TODO: 신고하기 API 호출하기 reportType: 0
                            })
                            
                            // 세부 메뉴 2: 스팸/도배성 리뷰
                            Button("스팸/도배성 리뷰", action: {
                                print("스팸/도배성 리뷰입니다.")
                                // TODO: 신고 알람창 띄우기
                                
                                // 신고하겠다는 확인 들어오면
                                // TODO: 신고하기 API 호출하기 reportType: 1
                            })
                        }
                    } label: {
                        Image(systemName: "ellipsis")
                            .font(.body)
                            .foregroundStyle(.black0)
                    }
                    
                }
            }
            
            // MARK: 한줄평 텍스트
            Text(comment.commentText)
                .font(.subheadline)
                .padding(.bottom, 12)
            
            // MARK: 한줄평 반응 버튼들
            CommentReactionView(comment: self.comment)
        }
        .padding(.vertical, 20)

    }
}
