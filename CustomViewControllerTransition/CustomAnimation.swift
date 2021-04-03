//
//  CustomAnimation.swift
//  CustomViewControllerTransition
//
//  Created by Delan Wang on 2021/3/14.
//

import UIKit

final class CustomAnimation: NSObject {
    private let appearAnimation: TransitionAnimation?
    private let disappearAnimation: TransitionAnimation?
    private let disappearInteractive: InteractiveAnimation?

    init(
        appearAnimation: TransitionAnimation? = nil,
        disappearAnimation: TransitionAnimation? = nil,
        disappearInteractive: InteractiveAnimation? = nil
    ) {
        self.appearAnimation = appearAnimation
        self.disappearAnimation = disappearAnimation
        self.disappearInteractive = disappearInteractive
    }
}

// MARK: - UIViewControllerTransitioningDelegate

extension CustomAnimation: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return appearAnimation
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return disappearAnimation
    }

    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return disappearInteractive
    }
}

// MARK: - UINavigationControllerDelegate

extension CustomAnimation: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        switch operation {
        case .push:
            return appearAnimation
        default:
            return disappearAnimation
        }
    }

    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return disappearInteractive
    }
}
