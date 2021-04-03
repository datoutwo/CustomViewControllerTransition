//
//  TransitionTableCell.swift
//  CustomViewControllerTransition
//
//  Created by Delan Wang on 2021/4/3.
//

import UIKit

class TransitionCellStyle: TransitionAnimation {

    private let duration: TimeInterval
    private let dampingRatio: CGFloat
    
    init(transitionType: TransitionType, duration: TimeInterval = 3.0, dampingRatio: CGFloat = 1.0) {
        self.duration = duration
        self.dampingRatio = dampingRatio
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
        let initialFrame = transitionContext.initialFrame(for: fromViewController)
        let finalFrame = transitionContext.finalFrame(for: toViewController)
        let containerView = transitionContext.containerView
        
        containerView.insertSubview(toView, belowSubview: fromView)
        
        fromView.frame = initialFrame
        toView.frame = finalFrame
        toView.layoutIfNeeded()
        
        let animationView = UIView(frame: toView.frame)
        animationView.clipsToBounds = true
        containerView.addSubview(animationView)
        
        switch transitionType {
        case .appear:
            if
                let cellFrame = fromTransitionVC?.transitionFrame,
                let infoFrame = toTransitionVC?.transitionFrame {
                
                let insets = UIEdgeInsets(top: infoFrame.minY,
                                          left: (toView.frame.width - cellFrame.width) / 2.0,
                                          bottom: toView.frame.height - infoFrame.maxY,
                                          right: (toView.frame.width - cellFrame.width) / 2.0)
                let insetsOffset = (insets.bottom - insets.top) / 2.0
                animationView.addSubview(toView)
                animationView.bounds = animationView.bounds.inset(by: insets)
                animationView.transform = CGAffineTransform(translationX: 0, y: cellFrame.minY - infoFrame.minY - insetsOffset)
                animationView.layer.cornerRadius = 40
            }
            
        case .disappear:
            if let fromViewSnapshot = fromView.snapshotView(afterScreenUpdates: true) {
                animationView.addSubview(fromViewSnapshot)
            }
            containerView.insertSubview(toView, aboveSubview: fromView)
        }
        
        let animator = UIViewPropertyAnimator(duration: duration, dampingRatio: dampingRatio) {
            switch self.transitionType {
            case .appear:
                animationView.bounds = finalFrame
                animationView.transform = .identity
                animationView.layer.cornerRadius = 0
                
            case .disappear:
                if
                    let cellFrame = self.toTransitionVC?.transitionFrame,
                    let infoFrame = self.fromTransitionVC?.transitionFrame {
                    
                    let insets = UIEdgeInsets(top: infoFrame.minY,
                                              left: (toView.frame.width - cellFrame.width) / 2.0,
                                              bottom: toView.frame.height - infoFrame.maxY,
                                              right: (toView.frame.width - cellFrame.width) / 2.0)
                    let insetsOffset = (insets.bottom - insets.top) / 2.0
                    animationView.bounds = animationView.bounds.inset(by: insets)
                    animationView.transform = CGAffineTransform(translationX: 0, y: cellFrame.minY - infoFrame.minY - insetsOffset)
                    animationView.layer.cornerRadius = 10
                }
            }
        }
        
        animator.addCompletion { (_) in
            animationView.removeFromSuperview()
            
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
