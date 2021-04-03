//
//  InteractiveAnimation.swift
//  CustomViewControllerTransition
//
//  Created by Delan Wang on 2021/4/2.
//

import UIKit

enum InteractiveType {
    case navigation
    case presentation
}

enum InteractiveGestureDirection {
    case up
    case left
    case down
    case right
}

class InteractiveAnimation: UIPercentDrivenInteractiveTransition {
    private weak var targetViewController: UIViewController?
    private let interactiveType: InteractiveType
    private var direction: InteractiveGestureDirection
    var shouldCompleteTransition: Bool = false
    var viewWidth: CGFloat {
        return targetViewController?.view.frame.width ?? 400.0
    }

    var viewHeight: CGFloat {
        return targetViewController?.view.frame.height ?? 800.0
    }

    init(targetViewController: UIViewController, direction: InteractiveGestureDirection, interactiveType: InteractiveType) {
        self.interactiveType = interactiveType
        self.direction = direction
        self.targetViewController = targetViewController
        super.init()
        prepareGestureRecognizer(in: targetViewController.view)
        wantsInteractiveStart = false
    }
    
    func prepareGestureRecognizer(in view: UIView) {
        let gesture = UIPanGestureRecognizer(target: self,
                                             action: #selector(handleGesture(_:)))
        view.addGestureRecognizer(gesture)
    }
    
    func shouldCompleteTransition(distance: CGFloat, velocity: CGFloat) -> Bool {
        let progress = distance / viewWidth
        let percentage = min(max(progress, 0.0), 1.0)
        return percentage > 0.5
    }

    func getProgress(distance: CGFloat, velocity: CGFloat) -> CGFloat {
        return distance / viewWidth
    }
    
    func computeGestureValue(by point: CGPoint) -> CGFloat {
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
    
    @objc func handleGesture(_ gestureRecognizer: UIPanGestureRecognizer) {

        let translationPoint = gestureRecognizer.translation(in: gestureRecognizer.view)
        let velocityPoint = gestureRecognizer.velocity(in: gestureRecognizer.view)
        let distance = computeGestureValue(by: translationPoint)
        let velocity = computeGestureValue(by: velocityPoint)
        let progress = getProgress(distance: distance, velocity: velocity)
        
        switch gestureRecognizer.state {
        case .began:
            wantsInteractiveStart = true
            dismissView()
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
}

// MARK: - private
extension InteractiveAnimation {
    private func dismissView() {
        switch interactiveType {
        case .navigation:
            targetViewController?.navigationController?.popViewController(animated: true)
        case .presentation:
            targetViewController?.dismiss(animated: true)
        }
    }
}

// MARK: - UIGestureRecognizerDelegate
extension InteractiveAnimation: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
