//
//  CustomDropDownModifier.swift
//  ReadingFrame
//
//  Created by 이윤지 on 6/7/24.
//

import SwiftUI

//struct CustomDropDownModifier<CustomView: View>: ViewModifier {
//    @State var customSize = CGSize.zero
//    
//    var customView: CustomView?
//    var menu: UIMenu
//    var tapped: () -> ()
//    
//    func body(content: Content) -> some View {
//        content
//            .hidden()
//            .overlay(
//                CustomDropDownHelper(
//                    customSize: $customSize,
//                    content: content,
//                    customView: customView,
//                    menu: menu,
//                    tapped: tapped
//                )
//            )
//            .overlay(
//                customView?
//                    .hidden()
//                    .readSize { customSize = $0 }
//            )
//    }
//}
