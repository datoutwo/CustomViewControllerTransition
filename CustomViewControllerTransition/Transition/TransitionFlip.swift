//
//  TransitionFlip.swift
//  CustomViewControllerTransition
//
//  Created by Delan Wang on 2021/3/21.
//

import UIKit

class TransitionFlip: TransitionAnimation {
    private let duration: TimeInterval
    
    init(transitionType: TransitionType, duration: TimeInterval = 3.0) {
        self.duration = duration
        super.init(transitionType: transitionType)
    }
    
    override func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    override func setupAnimator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewPropertyAnimator {

        guard
            let fromView = transitionContext.view(forKey: .from),
            let toView = transitionContext.view(forKey: .to) else {
            return super.setupAnimator(using: transitionContext)
        }
        let containerView = transitionContext.containerView
        
        containerView.insertSubview(toView, belowSubview: fromView)
        fromView.alpha = 1.0
        toView.layer.transform = CATransform3DMakeRotation(CGFloat.pi, 0, 1, 0)
        
        var perspectiveIdentity = CATransform3DIdentity
        perspectiveIdentity.m34 = -0.002
        
        containerView.layer.transform = perspectiveIdentity
        let animator = UIViewPropertyAnimator(duration: duration, curve: .easeInOut) {
            fromView.alpha = 0.0
            containerView.layer.transform = CATransform3DMakeRotation(super.transitionType == .appear ? 3.14 : -3.14, 0, 1, 0)
        }
        
        animator.addCompletion { (_) in
            fromView.alpha = 1.0
            toView.alpha = 1.0
            toView.transform = .identity
            containerView.layer.transform = CATransform3DIdentity
            
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
