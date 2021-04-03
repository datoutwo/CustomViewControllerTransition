//
//  TransitionDropDown.swift
//  CustomViewControllerTransition
//
//  Created by Delan Wang on 2021/3/21.
//

import UIKit

final class TransitionDropDown: TransitionAnimation {
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
        
        containerView.insertSubview(toView, belowSubview: fromView)
        
        switch transitionType {
        case .appear:
            containerView.insertSubview(toView, aboveSubview: fromView)
            toView.transform = CGAffineTransform(translationX: 0, y: -toView.frame.height)
            
        case .disappear:
            containerView.insertSubview(toView, belowSubview: fromView)
        }
        
        let animator = UIViewPropertyAnimator(duration: duration, curve: .easeInOut) {
            switch self.transitionType {
            case .appear:
                toView.transform = .identity
                
            case .disappear:
                fromView.transform = CGAffineTransform(translationX: 0, y: -toView.frame.height)
            }
        }
        
        animator.addCompletion { (_) in
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
