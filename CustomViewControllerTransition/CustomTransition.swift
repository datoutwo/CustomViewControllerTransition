//
//  CustomTransition.swift
//  CustomViewControllerTransition
//
//  Created by Delan Wang on 2021/3/14.
//

import UIKit

final class CustomTransition: NSObject, UIViewControllerTransitioningDelegate {
    private let appearAnimation: TransitionAnimation?
    private let disappearAnimation: TransitionAnimation?
    private let interactive: InteractiveAnimation?

    init(appearAnimation: TransitionAnimation? = nil, disappearAnimation: TransitionAnimation? = nil, interactive: InteractiveAnimation? = nil) {
        self.appearAnimation = appearAnimation
        self.disappearAnimation = disappearAnimation
        self.interactive = interactive
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return appearAnimation
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return disappearAnimation
    }

    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactive
    }
}
