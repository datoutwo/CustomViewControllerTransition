//
//  TransitionAnimation.swift
//  CustomViewControllerTransition
//
//  Created by Delan Wang on 2021/3/21.
//

import UIKit

enum TransitionType {
    case appear
    case disappear
}

class TransitionAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    private(set) var transitionType: TransitionType
    private var animator: UIViewPropertyAnimator?

    init(transitionType: TransitionType) {
        self.transitionType = transitionType
    }

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0
    }

    func setupAnimator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewPropertyAnimator {
        return UIViewPropertyAnimator(duration: 0, curve: .linear, animations: nil)
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
//        let animator = interruptibleAnimator(using: transitionContext)
//        animator.startAnimation()
        if let animator = animator {
            animator.startAnimation()
        }
        let animator = setupAnimator(using: transitionContext)
        self.animator = animator
        animator.startAnimation()
    }

    func animationEnded(_ transitionCompleted: Bool) {
        animator?.stopAnimation(transitionCompleted)
    }

//    func interruptibleAnimator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating {
//        if let animator = animator {
//            return animator
//        }
//
//        let interruptibleAnimator = setupAnimator(using: transitionContext)
//        animator = interruptibleAnimator
//        return interruptibleAnimator
//    }
}

