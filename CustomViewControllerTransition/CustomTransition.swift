//
//  CustomTransition.swift
//  CustomViewControllerTransition
//
//  Created by Delan Wang on 2021/3/14.
//

import UIKit

final class CustomTransition: NSObject {
    private let appearAnimation: TransitionAnimation?
    private let disappearAnimation: TransitionAnimation?
    private let appearInteractive: InteractiveAnimation?
    private let disappearInteractive: InteractiveAnimation?

    init(
        appearAnimation: TransitionAnimation? = nil,
        disappearAnimation: TransitionAnimation? = nil,
        appearInteractive: InteractiveAnimation? = nil,
        disappearInteractive: InteractiveAnimation? = nil
    ) {
        self.appearAnimation = appearAnimation
        self.disappearAnimation = disappearAnimation
        self.appearInteractive = appearInteractive
        self.disappearInteractive = disappearInteractive
    }
}

extension CustomTransition: UIViewControllerTransitioningDelegate {

    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return appearAnimation
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return disappearAnimation
    }

    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return appearInteractive
    }

    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return disappearInteractive
    }
}

extension CustomTransition: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        switch operation {
        case .push:
            return appearAnimation
        default:
            return disappearAnimation
            
        }
    }

    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return appearInteractive
    }
}
