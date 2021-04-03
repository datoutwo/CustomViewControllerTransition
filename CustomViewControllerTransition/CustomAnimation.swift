//
//  CustomAnimation.swift
//  CustomViewControllerTransition
//
//  Created by Delan Wang on 2021/3/14.
//

import UIKit

final class CustomAnimation: NSObject {
    private let interactive: InteractiveAnimation?

    init(interactive: InteractiveAnimation? = nil) {
        self.interactive = interactive
    }
}

// MARK: - UIViewControllerTransitioningDelegate

extension CustomAnimation: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return (presented as? TransitionAnimationViewController)?.appearingTransition
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return (dismissed as? TransitionAnimationViewController)?.disappearingTransition
    }

    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        
        return interactive
    }
}

// MARK: - UINavigationControllerDelegate

extension CustomAnimation: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        switch operation {
        case .push:
            return (toVC as? TransitionAnimationViewController)?.appearingTransition
        default:
            return (fromVC as? TransitionAnimationViewController)?.disappearingTransition
        }
    }

    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactive
    }
}
