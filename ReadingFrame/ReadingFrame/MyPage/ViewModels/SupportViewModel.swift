//
//  SupportViewModel.swift
//  ReadingFrame
//
//  Created by 석민솔 on 2/18/25.
//

import Foundation

class SupportViewModel: ObservableObject {
    // MARK: - Properties
    
    // 자주 묻는 질문 관련 변수들
    /// 자주 묻는 질문 데이터
    let supportData: SupportData
    
    /// 인덱스의 질문이 토글됐는지 저장하는 배열
    @Published var isItemIndexExpanded: [Bool]
    
    // 문의 관련 변수들
    /// 오류 제보용 이메일
    @Published var bugReportEmail = SupportEmail(toAddress: "codecozy2023@gmail.com",
                                                         subject: "[오류제보:리딩프레임]",
                                                         messageHeader: "정확한 문제 해결을 위해 오류 발생 상황을 공유해 주세요. 빠르게 확인하여 해결할 수 있도록 최선을 다하겠습니다.")
    /// 문의용 이메일
    @Published var contactEmail = SupportEmail(toAddress: "codecozy2023@gmail.com",
                                                       subject: "[문의:리딩프레임]",
                                                       messageHeader: "문의 사항을 알려주시면 신속하고 정확한 답변을 드릴 수 있도록 하겠습니다.")
    
    // init
    init() {
        self.supportData = SupportData()
        self.isItemIndexExpanded = .init(repeating: false, count: supportData.questions.count)
    }
}
