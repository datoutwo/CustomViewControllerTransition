//
//  InteractiveDownGesture.swift
//  CustomViewControllerTransition
//
//  Created by Delan Wang on 2021/4/3.
//

import UIKit

final class InteractiveDownGesture: InteractiveAnimation {
    
    init(
        targetViewController: UIViewController,
        interactiveType: InteractiveType
    ) {
        super.init(
            targetViewController: targetViewController,
            interactiveType: interactiveType,
            direction: .down
        )
    }

    @objc override func handleGesture(_ gestureRecognizer: UIPanGestureRecognizer) {
        super.handleGesture(gestureRecognizer)
    }

    override func shouldCompleteTransition(
        distance: CGFloat,
        velocity: CGFloat
    ) -> Bool {
        return velocity > 200 || (distance / viewHeight) > 0.5
    }

    override func getProgress(
        distance: CGFloat,
        velocity: CGFloat
    ) -> CGFloat {
        distance / viewHeight
    }
}
