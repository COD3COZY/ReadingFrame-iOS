//
//  Coordinator.swift
//  ReadingFrame
//
//  Created by 석민솔 on 2026/04/14.
//

import Foundation

final class Coordinator: ObservableObject {
    @Published var path: [Path] = []

    var previousPath: Path? {
        guard path.count >= 2 else { return nil }
        return path[path.count - 2]
    }

    func push(_ path: Path) {
        self.path.append(path)
    }

    func popLast() {
        _ = self.path.popLast()
    }

    func removeAll() {
        self.path.removeAll()
    }

    /// 스택에서 특정 Path까지 pop하고 그 이후 화면은 제거
    func popToScreen(_ target: Path) {
        while let last = path.last {
            if last == target {
                break
            }
            _ = self.path.popLast()
        }
    }
}
