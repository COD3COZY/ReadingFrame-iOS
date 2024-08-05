//
//  WrapLayout.swift
//  ReadingFrame
//
//  Created by 석민솔 on 2/25/24.
//

import SwiftUI

/// 한 줄의 너비가 끝나면 다음줄로 넘어가도록 하는 레이아웃
struct WrapLayout: Layout {
    // MARK: Layout Properties
    
    var alignment: Alignment = .leading
    
    /// Horizontal spacing
    var horizontalSpacing: CGFloat = 10
    
    /// Vertical spacing
    var verticalSpacing: CGFloat = 10
    
    /// 서재에서 이 레이아웃을 사용하고 있는지 여부
    /// - 기본적으로 false, 책장에서 쓸 때만 true로 바꿔서 입력해주면 됨
    var isForBookshelf: Bool = false
        
    
    // MARK: Layout Methods
    // Layout protocol's required method
    // reports the size of the composite layout view.
    /// 레이아웃 전체 크기(너비, 높이) 정해주기
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        
        /// 이 레이아웃이 위치할 수 있는 (최대) 너비
        let maxWidth = proposal.width ?? 0
        
        /// 설정해줄 height
        var height: CGFloat = 0
        
        /// 높이 정해주기 위해 rows 불러오기
        let rows = generateRows(maxWidth, proposal, subviews)
        
        // row와 그 row마다 붙여주는 인덱스, 순서대로
        for (index, row) in rows.enumerated() {
            
            // 각 행에서 최대 높이값 구해서 뷰의 total height에 더해주기
            if index == (rows.count - 1) {
                // 마지막 행: spacing 필요없음
                height += row.maxHeight(proposal)
            } else {
                height += row.maxHeight(proposal) + verticalSpacing
            }
        }
        
        // 레이아웃 적용되는 뷰의 크기 리턴해줌
        return .init(width: maxWidth, height: height)
    }
    
    // Layout protocol's required method
    // assigns positions to the container’s subviews.
    /// 실제 뷰마다 위치 할당해주기
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        // Placing Views
        
        /// 왼쪽 끝 시작점
        var origin = bounds.origin
        
        /// 레이아웃 뷰의 최대너비
        let maxWidth = bounds.width
        
        // 그냥 궁금해서 출력해보는 변수들
//        print("bounds: ", bounds, "origin: ", origin, "maxWidth: ", maxWidth)
        
        /// 크기 감안해서 배열로 할당된 rows
        let rows = generateRows(maxWidth, proposal, subviews)
        
        // 한 row마다
        for row in rows {
            // MARK: 한 row마다 시작점 정하기
            // 정렬에 따라 origin x 좌표 정해주기(leading, trailing, center)
            let leading: CGFloat = bounds.maxX - maxWidth
            
            let trailing: CGFloat = bounds.maxX - row.reduce(CGFloat.zero) { partialResult, view in
                let width = view.sizeThatFits(proposal).width
                
                if view == row.last {
                    // No Spacing
                    return partialResult + width
                }
                // with Spacing
                return partialResult + width + horizontalSpacing
                
            }
            
            let center: CGFloat = (trailing + leading) / 2
            
            
            // 각 row의 x좌표 시작점(origin x) 세팅
            switch alignment {
            case .leading:
                origin.x = leading
            case .trailing:
                origin.x = trailing
            case .center:
                origin.x = center
            default:
                origin.x = leading // 기본값 leading으로 설정
            }
            
            
            // MARK: row 안의 요소마다 x죄표 지정, 배치
            for view in row {
                let viewSize = view.sizeThatFits(proposal)
                // 기존 originY 저장해두기
                let existingY = origin.y
                
                // bottom 정렬인 경우 origin Y 값 bottom에 맞게 조정
                if alignment == .bottom {
                    // 서재용 레이아웃인지 검사
                    if isForBookshelf == false {
                        origin.y += row.maxHeight(proposal) - viewSize.height
                    } else {
                        // 한 줄 서가 최대높이 110으로 맞춰야 책장 바닥 UI가 맞아떨어짐
                        origin.y += 110 - viewSize.height
                    }
                }
                
                view.place(at: origin, proposal: proposal)  // origin 위치에 view 배치!
                
                // origin Y값 기존 값으로 돌리기
                origin.y = existingY
                
                // Updating Origin X(뷰의 시작점 오른쪽으로 옮겨주기)
                origin.x += (viewSize.width + horizontalSpacing)
            }
            
            // Updating Origin Y(다음줄 y좌표 시작점으로 바꿔주기)
            // 서재용 레이아웃인지 검사
            if isForBookshelf == false {
                // 일반적으로 뷰 크기에 맞춰서 다음줄 y좌표로 정해주기
                origin.y += (row.maxHeight(proposal) + verticalSpacing)
            } else {
                // 한 줄 서가 최대높이 110에 맞춰서 다음줄 y좌표 정해주기
                origin.y += 110 + verticalSpacing
            }
        }
    }
    
    /// Generating Rows based on Available Size
    ///
    /// - 이 함수에서 바로 뷰 상에 배치되는 게 아님
    /// - 사이즈에 따라 한 줄에 어떤 뷰 항목이 들어갈 수 있는지만 결정해서 배열에 저장해두는 역할
    func generateRows(_ maxWidth: CGFloat, _ proposal: ProposedViewSize, _ subviews: Subviews) -> [[LayoutSubviews.Element]] {
        // 빈 배열 row 및 rows 선언
        var row: [LayoutSubviews.Element] = []      // 현재 행의 서브뷰 저장
        var rows: [[LayoutSubviews.Element]] = []   // 모든 행들 저장
        
        /// 서브뷰별 위치 나타내줄 변수 (x, y) = (0, 0)
        var origin = CGRect.zero.origin
        
        // subview의 뷰마다 돌아가면서 어느 row에 들어갈지 결정해서 rows 만들어주는 for문
        for view in subviews {
            let viewSize = view.sizeThatFits(proposal)
            

            // 해당 view가 현재 row에 들어갈지 다음 row로 넘어갈지 결정
            if (origin.x + viewSize.width + horizontalSpacing) > maxWidth {
                // MARK: 새로운 줄로 추가하는 경우(Pushing to New Row)
                
                // 새로운 row로 이사준비
                rows.append(row)    // 현재 row rows에 추가해두기
                row.removeAll()     // 이제 새로운 view들 row에 추가해야되니까 rows에 추가해둔 현재 요소들은 지워줌
                origin.x = 0        // Resetting X Origin since it needs to start from left to right
                
                // 새로운 row에 현재 항목 추가해주기
                row.append(view)
                origin.x += (viewSize.width + horizontalSpacing)  // 현재 뷰 크기에 따라 x축 커서 이동
            } else {
                // MARK: 기존 줄에 추가
                row.append(view)
                origin.x += (viewSize.width + horizontalSpacing)  // 현재 뷰 크기에 따라 x축 커서 이동
            }
        }
         
        // Checking for any exhaust row
        if !row.isEmpty {
            rows.append(row)
            row.removeAll()
        }
                
        return rows
    }
}

/// 한 row의 최대높이 구하기
extension [LayoutSubviews.Element] {
    func maxHeight(_ proposal: ProposedViewSize) -> CGFloat {
        return self.compactMap { view in
            return view.sizeThatFits(proposal).height
        }.max() ?? 0
    }
}
