//
//  TransitionTableCell.swift
//  CustomViewControllerTransition
//
//  Created by Delan Wang on 2021/4/3.
//

import UIKit

protocol TransitionTableCellDelegate: AnyObject {
    var fromViewFrame: CGRect { get }
    var toViewFrame: CGRect { get }
}

class TransitionTableCell: TransitionAnimation {

    private weak var delegate: TransitionTableCellDelegate?
    private let duration: TimeInterval
    
    init(transitionType: TransitionType, duration: TimeInterval = 3.0) {
        self.duration = duration
        super.init(transitionType: transitionType)
    }
    
    override func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }

//    override func setupAnimator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewPropertyAnimator {
//        guard
//            let
//    }
}
