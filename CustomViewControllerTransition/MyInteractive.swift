//
//  MyInteractive.swift
//  CustomViewControllerTransition
//
//  Created by DelanWang on 05.04.21.
//

import UIKit

final class MyInteractive: UIPercentDrivenInteractiveTransition {
    private weak var targetViewController: UIViewController?

    init(targetViewController: UIViewController) {
        self.targetViewController = targetViewController
        super.init()
        prepareGestureRecognizer(in: targetViewController.view)
        wantsInteractiveStart = false
    }
    
    func prepareGestureRecognizer(in view: UIView) {
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(handleGesture(_:)))
        view.addGestureRecognizer(gesture)
    }
}

extension MyInteractive {
    @objc private func handleGesture(_ gestureRecognizer: UIPanGestureRecognizer) {
        
    }
}

