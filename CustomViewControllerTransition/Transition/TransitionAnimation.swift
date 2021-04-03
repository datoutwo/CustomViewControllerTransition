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

typealias TransitionAnimationViewController = UIViewController & TransitionAnimationProtocol

protocol TransitionAnimationProtocol {
    var appearingTransition: TransitionAnimation? { get }
    var disappearingTransition: TransitionAnimation? { get }
    var transitionFrame: CGRect? { get }

    func transitionDidStart(_ type: TransitionType)
    func transitionDidEnd(_ type: TransitionType)
}

class TransitionAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    private(set) var transitionType: TransitionType
    private var animator: UIViewPropertyAnimator?
    private(set) var fromTransitionVC: TransitionAnimationProtocol?
    private(set) var toTransitionVC: TransitionAnimationProtocol?

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
        let animator = interruptibleAnimator(using: transitionContext)
        animator.startAnimation()
        fromTransitionVC?.transitionDidStart(transitionType)
        toTransitionVC?.transitionDidStart(transitionType)
    }

    func animationEnded(_ transitionCompleted: Bool) {
        animator = nil
        fromTransitionVC?.transitionDidEnd(transitionType)
        toTransitionVC?.transitionDidEnd(transitionType)
    }

    func interruptibleAnimator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating {
        if let animator = animator {
            return animator
        }

        let interruptibleAnimator = setupAnimator(using: transitionContext)
        animator = interruptibleAnimator
        fromTransitionVC?.transitionDidStart(transitionType)
        toTransitionVC?.transitionDidStart(transitionType)
        return interruptibleAnimator
    }

    final func setupTransitionInitialState(using transitionContext: UIViewControllerContextTransitioning) {
        guard
            let fromViewController = transitionContext.viewController(forKey: .from),
            let toViewController = transitionContext.viewController(forKey: .to) else {
                return
        }
        fromTransitionVC = fromViewController as? TransitionAnimationProtocol
        toTransitionVC = toViewController as? TransitionAnimationProtocol
    }
}

