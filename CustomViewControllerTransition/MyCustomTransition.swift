//
//  MyCustomTransition.swift
//  CustomViewControllerTransition
//
//  Created by DelanWang on 05.04.21.
//

import UIKit

enum MyCustomTransitionType {
    case appear
    case disappear
}

final class MyCustomTransition: NSObject, UIViewControllerAnimatedTransitioning {
    private var animator: UIViewPropertyAnimator?
    private let transitionType: MyCustomTransitionType
    private let duration: TimeInterval

    init(transitionType: MyCustomTransitionType, duration: TimeInterval) {
        self.transitionType = transitionType
        self.duration = duration
    }

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        animator = setupAnimator(using: transitionContext)
        animator?.startAnimation()
    }

    func animationEnded(_ transitionCompleted: Bool) {
        animator = nil
    }
}

extension MyCustomTransition {
    
    private func setupAnimator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewPropertyAnimator {

        return UIViewPropertyAnimator(duration: 0, curve: .linear, animations: nil)
    }
}
