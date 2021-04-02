//
//  InteractiveLeftGesture.swift
//  CustomViewControllerTransition
//
//  Created by Delan Wang on 2021/4/2.
//

import UIKit

final class InteractiveLeftGesture: InteractiveAnimation {
    
    init(targetViewController: UIViewController) {
        super.init(targetViewController: targetViewController, direction: .left)
    }

    @objc override func handleGesture(_ gestureRecognizer: UIPanGestureRecognizer) {
        super.handleGesture(gestureRecognizer)
    }

    override func shouldCompleteTransition(distance: CGFloat, velocity: CGFloat) -> Bool {
        return velocity > 150
    }
}
