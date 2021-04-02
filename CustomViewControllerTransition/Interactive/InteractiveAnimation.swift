//
//  InteractiveAnimation.swift
//  CustomViewControllerTransition
//
//  Created by Delan Wang on 2021/4/2.
//

import UIKit

enum InteractiveGestureDirection {
    case up
    case left
    case down
    case right
}

class InteractiveAnimation: UIPercentDrivenInteractiveTransition {
    private weak var targetViewController: UIViewController?
    private var direction: InteractiveGestureDirection
    var shouldCompleteTransition: Bool = false
    init(targetViewController: UIViewController, direction: InteractiveGestureDirection) {
        self.direction = direction
        self.targetViewController = targetViewController
        super.init()
        prepareGestureRecognizer(in: targetViewController.view)
    }
    
    func prepareGestureRecognizer(in view: UIView) {
        let gesture = UIPanGestureRecognizer(target: self,
                                             action: #selector(handleGesture(_:)))
        view.addGestureRecognizer(gesture)
    }
    
    func shouldCompleteTransition(distance: CGFloat, velocity: CGFloat) -> Bool {
        let progress = distance / 400.0
        let percentage = min(max(progress, 0.0), 1.0)
        return percentage > 0.5
    }

    func getProgress(distance: CGFloat, velocity: CGFloat) -> CGFloat {
        return distance / 400.0
    }
    
    @objc func handleGesture(_ gestureRecognizer: UIPanGestureRecognizer) {

        let translationPoint = gestureRecognizer.translation(in: gestureRecognizer.view)
        let velocityPoint = gestureRecognizer.velocity(in: gestureRecognizer.view)
        let distance = computeGestureValue(by: translationPoint)
        let velocity = computeGestureValue(by: velocityPoint)
        let progress = getProgress(distance: distance, velocity: velocity)
        
        switch gestureRecognizer.state {
        case .began:
            wantsInteractiveStart = true
            targetViewController?.dismiss(animated: true, completion: nil)
        case .changed:
            update(progress)
        case .cancelled:
            wantsInteractiveStart = false
            cancel()
        case .ended:
            wantsInteractiveStart = false
            if shouldCompleteTransition(distance: distance, velocity: velocity) {
                finish()
            } else {
                cancel()
            }
        default:
            break
        }
    }

    private func computeGestureValue(by point: CGPoint) -> CGFloat {
        switch direction {
        case .up:
            return -point.y
        case .down:
            return point.y
        case .left:
            return -point.x
        case .right:
            return point.x
        }
    }
}

extension InteractiveAnimation: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
