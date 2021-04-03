//
//  MenuRouter.swift
//  CustomViewControllerTransition
//
//  Created by Delan Wang on 2021/2/28.
//

import Foundation

protocol MenuRouterProtocol {
    func openDetail(args: MenuDetailViewControllerArgs)
    func openInfo()
    func dismissView()
}

final class MenuRouter: MenuRouterProtocol {
    weak var view: MenuViewController?
    private let menuDetailViewControllerFactory: MenuDetailViewControllerFactoryProtocol
    private let infoViewControllerFactory: InfoViewControllerFactoryProtocol
    private var detailTransition: CustomTransition?
    private var popInfoTransition: CustomTransition?
    private var showInfoTransition: CustomTransition?

    init(
        menuDetailViewControllerFactory: MenuDetailViewControllerFactoryProtocol,
        infoViewControllerFactory: InfoViewControllerFactoryProtocol
    ) {
        self.menuDetailViewControllerFactory = menuDetailViewControllerFactory
        self.infoViewControllerFactory = infoViewControllerFactory
    }

    func openDetail(args: MenuDetailViewControllerArgs) {
        let menuDetailViewController = menuDetailViewControllerFactory.make(args: args)
        let interactive = InteractiveAnimation(targetViewController: menuDetailViewController, direction: .down, interactiveType: .presentation)
        let appearFlip = TransitionFlip(transitionType: .appear, duration: 1.0)
        let disappearFlip = TransitionFlip(transitionType: .disappear, duration: 1.0)
        self.detailTransition = CustomTransition(appearAnimation: appearFlip, disappearAnimation: disappearFlip, disappearInteractive: interactive)
        menuDetailViewController.transitioningDelegate = detailTransition
        menuDetailViewController.modalPresentationStyle = .fullScreen
        view?.navigationController?.present(menuDetailViewController, animated: true, completion: nil)
    }

    func openInfo() {
        let infoViewController = infoViewControllerFactory.make()
        let interactive = InteractiveRightGesture(targetViewController: infoViewController, interactiveType: .navigation)
        let zoomIn = TransitionZoomIn(transitionType: .appear, duration: 1.0)
        let zoomOut = TransitionZoomOut(transitionType: .disappear, duration: 1.0)
        self.popInfoTransition = CustomTransition(disappearAnimation: zoomOut, appearInteractive: interactive)
        self.showInfoTransition = CustomTransition(appearAnimation: zoomIn)
        view?.navigationController?.delegate = showInfoTransition
        view?.navigationController?.show(infoViewController, sender: nil)
        infoViewController.navigationController?.delegate = popInfoTransition
    }

    func dismissView() {
        view?.navigationController?.dismiss(animated: true, completion: nil)
    }
}
