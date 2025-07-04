//
//  MainDetailReadingMenuView.swift
//  ReadingFrame
//
//  Created by 석민솔 on 7/2/25.
//

import SwiftUI

/// 읽고있는 책 리스트 row일 때  메뉴
struct MainDetailReadingMenuView: View {
    // MARK: - Properties
    /// 숨김처리되어있는 책인지
    let isHidden: Bool = true
    /// 해당 책에 리뷰가 있는지
    let isReviewExist: Bool = true
    /// 소장한 책인지
    let isMine: Bool = true
    
    // TODO: 액션 받아오기

    // MARK: - View
    var body: some View {
        // MARK: 다 읽음 버튼
        Button {
            // TODO: 다읽은 책으로 표시할지 Alert 띄우기
        } label: {
            Label("다 읽음", systemImage: "book.closed")
        }

        // MARK: 정보 버튼
        NavigationLink {
            // TODO: 책 정보 화면(BooKInfo)으로 이동
        } label: {
            Label("정보", systemImage: "info.circle")
        }

        // MARK: 리뷰 남기기 or 확인하기 버튼
        if isReviewExist {
            // 리뷰 확인하기
            Button {
                // TODO: 독서노트 화면(ReadingNote) 연결
            } label: {
                Label("리뷰 확인하기", systemImage: "bubble")
            }

        } else {
            // 리뷰 남기기
            Button {
                // TODO: 리뷰 남기기 화면 연결
            } label: {
                Label("리뷰 남기기", systemImage: "bubble")
            }
        }

        // MARK: 소장 버튼
        Button {
            // TODO: 소장 여부에 따라 이미 소장한 책이면 alert, 소장하지 않은 책인 경우 소장여부 변경 API 호출
        } label: {
            Label("소장", systemImage: "square.and.arrow.down")
        }

        // MARK: 꺼내기 or 홈 화면에서 숨기기 버튼
        if isHidden {
            Button {
                // TODO: 읽고 있는 책 꺼내기 API 호출
            } label: {
                Label("꺼내기", systemImage: "tray.and.arrow.up")
            }
        } else {
            Button {
                // TODO: 읽고 있는 숨기기 API 호출
            } label: {
                Label("홈 화면에서 숨기기", systemImage: "eye.slash")
            }
        }
    }
}
