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
    private var detailTransition: CustomAnimation?
    private var showInfoTransition: CustomAnimation?

    init(
        menuDetailViewControllerFactory: MenuDetailViewControllerFactoryProtocol,
        infoViewControllerFactory: InfoViewControllerFactoryProtocol
    ) {
        self.menuDetailViewControllerFactory = menuDetailViewControllerFactory
        self.infoViewControllerFactory = infoViewControllerFactory
    }

    func openDetail(args: MenuDetailViewControllerArgs) {
        let menuDetailViewController = menuDetailViewControllerFactory.make(args: args)
        let interactive = InteractiveDownGesture(targetViewController: menuDetailViewController, interactiveType: .presentation)
        self.detailTransition = CustomAnimation(interactive: interactive)
        menuDetailViewController.transitioningDelegate = detailTransition
        menuDetailViewController.modalPresentationStyle = .fullScreen
        view?.present(menuDetailViewController, animated: true, completion: nil)
    }

    func openInfo() {
        let infoViewController = infoViewControllerFactory.make()
        let interactive = InteractiveRightGesture(targetViewController: infoViewController, interactiveType: .navigation)
        self.showInfoTransition = CustomAnimation(interactive: interactive)
        view?.navigationController?.delegate = showInfoTransition
        view?.navigationController?.show(infoViewController, sender: nil)
        infoViewController.navigationController?.delegate = showInfoTransition
    }

    func dismissView() {
        view?.dismiss(animated: true, completion: nil)
    }
}
