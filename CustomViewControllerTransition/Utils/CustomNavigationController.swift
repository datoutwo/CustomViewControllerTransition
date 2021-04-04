//
//  CustomNavigationController.swift
//  CustomViewControllerTransition
//
//  Created by Delan Wang on 2021/4/3.
//

import UIKit

final class CustomNavigationController: UINavigationController {}

extension CustomNavigationController: TransitionAnimationProtocol {
    
    var appearingTransition: TransitionAnimation? {
        let topVC = topViewController as? TransitionAnimationViewController
        return topVC?.appearingTransition
    }
    
    var disappearingTransition: TransitionAnimation? {
        let topVC = topViewController as? TransitionAnimationViewController
        return topVC?.disappearingTransition
    }
    
    var transitionFrame: CGRect? {
        let topVC = topViewController as? TransitionAnimationViewController
        return topVC?.transitionFrame
    }
    
    func transitionDidStart(_ type: TransitionType) {
        let topVC = topViewController as? TransitionAnimationViewController
        topVC?.transitionDidStart(type)
    }
    
    func transitionDidEnd(_ type: TransitionType) {
        let topVC = topViewController as? TransitionAnimationViewController
        topVC?.transitionDidEnd(type)
    }
    
}
