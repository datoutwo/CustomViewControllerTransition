//
//  MyCustomAnimation.swift
//  CustomViewControllerTransition
//
//  Created by DelanWang on 05.04.21.
//

import UIKit

final class MyCustomAnimation: NSObject, UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return nil //animator
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return nil
    }
}
