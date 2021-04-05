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

    init(
        menuDetailViewControllerFactory: MenuDetailViewControllerFactoryProtocol,
        infoViewControllerFactory: InfoViewControllerFactoryProtocol
    ) {
        self.menuDetailViewControllerFactory = menuDetailViewControllerFactory
        self.infoViewControllerFactory = infoViewControllerFactory
    }

    func openDetail(args: MenuDetailViewControllerArgs) {
        let menuDetailViewController = menuDetailViewControllerFactory.make(args: args)
        menuDetailViewController.modalPresentationStyle = .fullScreen
        view?.present(menuDetailViewController, animated: true, completion: nil)
    }

    func openInfo() {
        let infoViewController = infoViewControllerFactory.make()
        view?.navigationController?.show(infoViewController, sender: nil)
    }

    func dismissView() {
        view?.dismiss(animated: true, completion: nil)
    }
}
