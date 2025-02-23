//
//  SupportEmail.swift
//  ReadingFrame
//
//  Created by 석민솔 on 2/18/25.
//

import UIKit
import SwiftUI

struct SupportEmail {
    let toAddress: String
    let subject: String
    let messageHeader: String
    var data: Data?
    var body: String {
    """
        - Application Name: \(Bundle.main.displayName)
        - iOS Version: \(UIDevice.current.systemVersion)
        - Device Model: \(UIDevice.current.modelName)
        - App Version: \(Bundle.main.appVersion)
        - App Build: \(Bundle.main.appBuild)
    
        \(messageHeader)
    --------------------------------------
    """
    }
    
//    func send(openURL: OpenURLAction) {
//        let urlString = "mailto:\(toAddress)?subject=\(subject.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? "")&body=\(body.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? "")"
//        guard let url = URL(string: urlString) else { return }
//        openURL(url) { accepted in
//            if !accepted {
//                print("""
//                This device does not support email
//                \(body)
//                """
//                )
//            }
//        }
//    }
    
}
