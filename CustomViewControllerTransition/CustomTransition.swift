//
//  CustomTransition.swift
//  CustomViewControllerTransition
//
//  Created by Delan Wang on 2021/3/14.
//

import UIKit

final class CustomTransition: NSObject, UIViewControllerTransitioningDelegate {
    private let appearAnimation: TransitionAnimation?
    private let disAppearAnimation: TransitionAnimation?

    init(appearAnimation: TransitionAnimation? = nil, disAppearAnimation: TransitionAnimation? = nil) {
        self.appearAnimation = appearAnimation
        self.disAppearAnimation = disAppearAnimation
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return appearAnimation//TransitionFlip(transitionType: .appear, duration: 1.0)
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return disAppearAnimation//TransitionFlip(transitionType: .disappear, duration: 1.0)
    }
}

