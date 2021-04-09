//
//  TransitionZoomOut.swift
//  CustomViewControllerTransition
//
//  Created by Delan Wang on 2021/3/21.
//

import UIKit

final class TransitionZoomOut: TransitionAnimation {
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
            let toView = transitionContext.view(forKey: .to),
            let fromViewController = transitionContext.viewController(forKey: .from),
            let toViewController = transitionContext.viewController(forKey: .to) else {
            return super.setupAnimator(using: transitionContext)
        }
        let containerView = transitionContext.containerView
        let initialFrame = transitionContext.initialFrame(for: fromViewController)
        let finalFrame = transitionContext.finalFrame(for: toViewController)
        
        containerView.insertSubview(toView, belowSubview: fromView)
        
        fromView.frame = initialFrame
        toView.frame = finalFrame
        toView.layoutIfNeeded()
        fromView.alpha = 1.0
        toView.alpha = 0.0
        fromView.transform = .identity
        
        let animator = UIViewPropertyAnimator(duration: duration, curve: .easeInOut) {
            fromView.alpha = 0.0
            toView.alpha = 1.0
            fromView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        }
        
        animator.addCompletion { (_) in
            fromView.alpha = 1.0
            toView.alpha = 1.0
            fromView.transform = .identity
            toView.transform = .identity
            
            let isCancelled = transitionContext.transitionWasCancelled
            
            if isCancelled {
                toView.removeFromSuperview()
            }
            transitionContext.completeTransition(!isCancelled)
        }
        return animator
    }
}
