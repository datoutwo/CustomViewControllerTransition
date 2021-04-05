//
//  TransitionCrossDissolve.swift
//  CustomViewControllerTransition
//
//  Created by Delan Wang on 2021/3/21.
//

import UIKit

class TransitionCrossDissolve: TransitionAnimation {
    private let duration: TimeInterval
    
    init(transitionType: TransitionType, duration: TimeInterval = 1.0) {
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
        
        containerView.insertSubview(toView, belowSubview: fromView)
        fromView.alpha = 1.0
        toView.alpha = 0.0
        
        let animator = UIViewPropertyAnimator(duration: duration, curve: .easeInOut) {
            fromView.alpha = 0.0
            toView.alpha = 1.0
        }
        
        animator.addCompletion { (_) in
            fromView.alpha = 1.0
            toView.alpha = 1.0
            
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
