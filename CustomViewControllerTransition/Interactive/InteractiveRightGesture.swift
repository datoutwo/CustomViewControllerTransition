//
//  InteractiveRightGesture.swift
//  CustomViewControllerTransition
//
//  Created by Delan Wang on 2021/4/3.
//

import UIKit

final class InteractiveRightGesture: InteractiveAnimation {
    
    init(targetViewController: UIViewController, interactiveType: InteractiveType) {
        super.init(targetViewController: targetViewController, direction: .right, interactiveType: interactiveType)
    }

    @objc override func handleGesture(_ gestureRecognizer: UIPanGestureRecognizer) {
        super.handleGesture(gestureRecognizer)
    }

    override func shouldCompleteTransition(distance: CGFloat, velocity: CGFloat) -> Bool {
        return velocity > 150 || (distance / viewWidth) > 0.5
    }
}
