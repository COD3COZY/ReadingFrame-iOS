//
//  Settings.swift
//  ReadingFrame
//
//  Created by 석민솔 on 2/12/25.
//

import SwiftUI

struct Settings: View {
    // MARK: - Properties
    /// 뷰에서 선택할 색상
    @State var color: ThemeColor
    
    /// 변경 완료 alert 활성화
    @State var showColorSavedAlert: Bool = false
    
    /// 미리보기 보여주기용 샘플 페이지
    let samplePages = [200, 400, 300, 200, 300, 200, 150, 200, 200, 150, 150, 200, 300, 200, 150, 200, 300/*, 200, 150, 200, 300, 200, 150, 200, 300, 200*/]
    
    // MARK: - init
    init() {
        // UserDefaults에서 값 가져와서 보여주기. 없을 경우 기본색상인 자주색으로 설정
        if let themeColor = UserDefaults.standard.string(forKey: "ThemeColor") {
            self._color = State(wrappedValue: ThemeColor(rawValue: themeColor) ?? .main)
        } else {
            self._color = State(wrappedValue: .main)
        }
    }
    
    // MARK: - View
    var body: some View {
        VStack(spacing: 30) {
            // 선택한 색상의 책장 미리보기
            previewSection
                .padding(.top, 10)
            
            // 색상 고르는 구역
            themeColorChooseSection
            
            Spacer()
        }
        .padding(.horizontal, 20)
        .navigationTitle("환경설정")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar { completeButton }
    }
}

// MARK: - View Components
extension Settings {
    /// 선택한 색상의 책장 미리보기
    private var previewSection: some View {
        VStack(spacing: 10) {
            
            titleText("미리보기")
            
            BookShelfView(shelfColor: color, totalPages: samplePages)
                .padding(.horizontal, -20)  // 전체 뷰에 적용돼있던 
        }
    }
    
    /// 색상 고르는 구역
    private var themeColorChooseSection: some View {
        VStack(spacing: 10) {
            titleText("서재 테마")
            
            colorChooseGrid
        }
    }
    
    /// 색상 선택용 5개 그리드
    private var colorChooseGrid: some View {
        HStack(spacing: 10) {
            let strokeWidth: CGFloat = 3
            // 자주색
            Circle()
                .frame(minWidth: 60, minHeight: 60)
                .foregroundStyle(Color.main)
                .onTapGesture {
                    withAnimation {
                        self.color = .main
                    }
                }
                .overlay (
                    Circle()
                        .stroke(color == .main ? .black0 : .clear, lineWidth: strokeWidth)
                )
            
            // 노랑색
            Circle()
                .frame(minWidth: 60, minHeight: 60)
                .foregroundStyle(Color.yellow)
                .onTapGesture {
                    withAnimation {
                        self.color = .yellow
                    }
                }
                .overlay (
                    Circle()
                        .stroke(color == .yellow ? .black0 : .clear, lineWidth: strokeWidth)
                )
            
            // 초록색
            Circle()
                .frame(minWidth: 60, minHeight: 60)
                .foregroundStyle(Color.emerald)
                .onTapGesture {
                    withAnimation {
                        self.color = .emerald
                    }
                }
                .overlay (
                    Circle()
                        .stroke(color == .emerald ? .black0 : .clear, lineWidth: strokeWidth)
                )
            
            // 파랑색
            Circle()
                .frame(minWidth: 60, minHeight: 60)
                .foregroundStyle(Color.blue)
                .onTapGesture {
                    withAnimation {
                        self.color = .blue
                    }
                }
                .overlay (
                    Circle()
                        .stroke(color == .blue ? .black0 : .clear, lineWidth: strokeWidth)
                )
            
            // 보라색
            Circle()
                .frame(minWidth: 60, minHeight: 60)
                .foregroundStyle(Color.purple0)
                .onTapGesture {
                    withAnimation {
                        self.color = .purple
                        
                    }
                }
                .overlay (
                    Circle()
                        .stroke(color == .purple ? .black0 : .clear, lineWidth: strokeWidth)
                )
        }
    }
    
    /// 완료 버튼
    private var completeButton: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Button {
                UserDefaults.standard.set(color.rawValue, forKey: "ThemeColor")
                
                showColorSavedAlert.toggle()
            } label: {
                Text("완료")
                    .foregroundStyle(.main)
            }
            .alert("선택한 색상이 반영되었습니다", isPresented: $showColorSavedAlert) {
                Button("확인", role: .cancel) { }
            }
        }
    }
    
    /// 섹션 이름
    private func titleText(_ name: String) -> some View {
        Text(name)
            .font(.thirdTitle)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical, 15)
    }
}

#Preview {
    Settings()
}
