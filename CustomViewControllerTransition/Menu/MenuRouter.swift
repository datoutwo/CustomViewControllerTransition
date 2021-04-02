//
//  MenuRouter.swift
//  CustomViewControllerTransition
//
//  Created by Delan Wang on 2021/2/28.
//

import Foundation

protocol MenuRouterProtocol {
    func openDetail(args: MenuDetailViewControllerArgs)
    func dismissView()
}

final class MenuRouter: MenuRouterProtocol {
    weak var view: MenuViewController?
    private let menuDetailViewControllerFactory: MenuDetailViewControllerFactory
    private var transition: CustomTransition?
    init(menuDetailViewControllerFactory: MenuDetailViewControllerFactory) {
        self.menuDetailViewControllerFactory = menuDetailViewControllerFactory
    }

    func openDetail(args: MenuDetailViewControllerArgs) {
        let menuDetailViewController = menuDetailViewControllerFactory.make(args: args)
        let interactive = InteractiveAnimation(targetViewController: menuDetailViewController, direction: .down)
        let zoomIn = TransitionFlip(transitionType: .appear, duration: 1.0)
        let zoomOut = TransitionFlip(transitionType: .disappear, duration: 1.0)
        self.transition = CustomTransition(appearAnimation: zoomIn, disappearAnimation: zoomOut, interactive: interactive)
        menuDetailViewController.transitioningDelegate = transition
        menuDetailViewController.modalPresentationStyle = .fullScreen
        view?.navigationController?.present(menuDetailViewController, animated: true, completion: nil)
    }

    func dismissView() {
        view?.navigationController?.dismiss(animated: true, completion: nil)
    }
}
