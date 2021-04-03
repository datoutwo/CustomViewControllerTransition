//
//  MenuFactory.swift
//  CustomViewControllerTransition
//
//  Created by Delan Wang on 2021/2/28.
//

import Foundation

protocol MenuFactoryProtocol {
    func make() -> MenuViewController
}

final class MenuFactory: MenuFactoryProtocol {
    private let menuDetailViewControllerFactory: MenuDetailViewControllerFactoryProtocol
    private let infoViewControllerFactory: InfoViewControllerFactoryProtocol
    
    init(
        menuDetailViewControllerFactory: MenuDetailViewControllerFactoryProtocol,
        infoViewControllerFactory: InfoViewControllerFactoryProtocol
    ) {
        self.menuDetailViewControllerFactory = menuDetailViewControllerFactory
        self.infoViewControllerFactory = infoViewControllerFactory
    }

    func make() -> MenuViewController {
        guard let menuViewController = MenuViewController.loadFromStoryBoard() else {
            fatalError()
        }
        let data = MenuDataTableView()
        let router = MenuRouter(
            menuDetailViewControllerFactory: menuDetailViewControllerFactory,
            infoViewControllerFactory: infoViewControllerFactory
        )
        let presenter = MenuPresenter(router: router)
        presenter.view = menuViewController
        menuViewController.presenter = presenter
        menuViewController.source = data
        data.presenter = presenter
        router.view = menuViewController
        return menuViewController
    }
}
