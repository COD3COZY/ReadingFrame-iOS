//
//  CustomDropDownHelper.swift
//  ReadingFrame
//
//  Created by 이윤지 on 6/7/24.
//

import SwiftUI
import UIKit

struct CustomDropDownHelper<Content: View, CustomView: View>: UIViewRepresentable {
    @Binding var customSize: CGSize
        
    var content: Content
    var customView: CustomView
    var menu: UIMenu
    var tapped: ()->()
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        view.backgroundColor = .clear
        
        let hostView = UIHostingController(rootView: content)
        hostView.view.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            hostView.view.topAnchor.constraint(equalTo: view.topAnchor),
            hostView.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostView.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            hostView.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            hostView.view.widthAnchor.constraint(equalTo: view.widthAnchor),
            hostView.view.heightAnchor.constraint(equalTo: view.heightAnchor),
        ]
        
        let interaction = UIContextMenuInteraction(delegate: context.coordinator)
        view.addSubview(hostView.view)
        view.addConstraints(constraints)
        view.addInteraction(interaction)
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) { }
    
    class Coordinator: NSObject, UIContextMenuInteractionDelegate {
        var parent: CustomDropDownHelper
        
        init(parent: CustomDropDownHelper) {
            self.parent = parent
        }
                
        func contextMenuInteraction(
            _ interaction: UIContextMenuInteraction,
            configurationForMenuAtLocation location: CGPoint
        ) -> UIContextMenuConfiguration? {
            UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { items in
                return self.parent.menu
            }
        }
        
        func contextMenuInteraction(
            _ interaction: UIContextMenuInteraction,
            willPerformPreviewActionForMenuWith configuration: UIContextMenuConfiguration,
            animator: UIContextMenuInteractionCommitAnimating
        ) {
            self.parent.tapped()
        }
        
        func contextMenuInteraction(
            _ interaction: UIContextMenuInteraction,
            configuration: UIContextMenuConfiguration,
            highlightPreviewForItemWithIdentifier identifier: NSCopying
        ) -> UITargetedPreview? {
            guard let interactionView = interaction.view else { return nil }
            guard let snapshotView = interactionView.snapshotView(afterScreenUpdates: false) else { return nil }
            
            let padding: CGFloat = 16
            
            let customView = UIHostingController(rootView: parent.customView).view!
            customView.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: parent.customSize)
            customView.backgroundColor = .clear
            customView.layer.cornerRadius = 15
            customView.layer.masksToBounds = true
            customView.translatesAutoresizingMaskIntoConstraints = false
            customView.transform = CGAffineTransform(translationX: 0, y: UIScreen.main.bounds.height)
            
            UIView.animate(
                withDuration: 0.5,
                delay: 0.5,
                usingSpringWithDamping: 1,
                initialSpringVelocity: 1,
                options: .curveEaseOut,
                animations: {
                    customView.transform = .identity
                    customView.alpha = 1
                },
                completion: nil
            )
            
            snapshotView.layer.cornerRadius = 20
            snapshotView.layer.masksToBounds = true
            snapshotView.translatesAutoresizingMaskIntoConstraints = false
            
            let containerWidth = max(parent.customSize.width, snapshotView.frame.width)
            let containerHeight = parent.customSize.height + snapshotView.frame.height + padding
            let containerSize = CGSize(width: containerWidth, height: containerHeight)
            let container = UIView(frame: CGRect(origin: .zero, size: containerSize))
            
            container.backgroundColor = .clear
            container.addSubview(customView)
            container.addSubview(snapshotView)
            
            customView.leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
            customView.topAnchor.constraint(equalTo: container.topAnchor).isActive = true
            customView.widthAnchor.constraint(equalToConstant: parent.customSize.width).isActive = true
            customView.heightAnchor.constraint(equalToConstant: parent.customSize.height).isActive = true
            
            snapshotView.widthAnchor.constraint(equalToConstant: interactionView.frame.width).isActive = true
            snapshotView.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
            snapshotView.bottomAnchor.constraint(equalTo: container.bottomAnchor).isActive = true
            snapshotView.topAnchor.constraint(equalTo: customView.bottomAnchor, constant: padding).isActive = true
            
            let centerPoint = CGPoint(
                x: interactionView.center.x,
                y: interactionView.center.y - (customView.bounds.height + padding) / 2
            )
            let previewTarget = UIPreviewTarget(container: interactionView, center: centerPoint)
            let previewParams = UIPreviewParameters()
            previewParams.backgroundColor = .clear
            previewParams.shadowPath = UIBezierPath()
            
            return UITargetedPreview(view: container, parameters: previewParams, target: previewTarget)
        }
    }
}
