//
//  TransitionWolt.swift
//  CustomViewControllerTransition
//
//  Created by Delan Wang on 2021/4/4.
//

import UIKit

final class TransitionWolt: TransitionAnimation {

    private let duration: TimeInterval

    init(transitionType: TransitionType, duration: TimeInterval = 0.3) {
        self.duration = duration
        super.init(transitionType: transitionType)
    }

    override func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    override func setupAnimator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewPropertyAnimator {
        super.setupTransitionInitialState(using: transitionContext)
        guard
            let fromView = transitionContext.view(forKey: .from),
            let toView = transitionContext.view(forKey: .to) else {
            return super.setupAnimator(using: transitionContext)
        }

        let containerView = transitionContext.containerView
        switch transitionType {
        case .appear:
            containerView.insertSubview(toView, aboveSubview: fromView)
            let scale = CGAffineTransform(scaleX: 1.5, y: 1.5)
            let translate = CGAffineTransform(translationX: toView.frame.width, y: 0)
            toView.transform = scale.concatenating(translate)
        case .disappear:
            containerView.insertSubview(toView, belowSubview: fromView)
            toView.transform = CGAffineTransform(translationX: -toView.frame.width/5, y: 0)
            toView.alpha = 0.5
        }

        let animator = UIViewPropertyAnimator(duration: duration, curve: .easeInOut) {
            switch self.transitionType {
            case .appear:
                toView.transform = CGAffineTransform(translationX: 0.5, y: 0)
                fromView.transform = CGAffineTransform(translationX: -toView.frame.width/5, y: 0)
                fromView.alpha = 0.5
            case .disappear:
                let scale = CGAffineTransform(scaleX: 1.5, y: 1.5)
                let translate = CGAffineTransform(translationX: fromView.frame.width * 1.2, y: 0)
                fromView.transform = scale.concatenating(translate)
                toView.transform = CGAffineTransform(translationX: 1, y: 0)
            }
        }
        animator.addCompletion { (_) in
            fromView.alpha = 1.0
            toView.alpha = 1.0
            fromView.transform = .identity
            toView.transform = .identity
            
            let isCancelled = transitionContext.transitionWasCancelled
            
            if isCancelled {
                toView.removeFromSuperview()
            } else {
                containerView.insertSubview(toView, belowSubview: fromView)
            }
            
            transitionContext.completeTransition(!isCancelled)
        }
        return animator
    }
}
