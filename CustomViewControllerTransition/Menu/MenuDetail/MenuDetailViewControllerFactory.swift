//
//  MenuDetailViewControllerFactory.swift
//  CustomViewControllerTransition
//
//  Created by Delan Wang on 2021/3/13.
//

import Foundation

protocol MenuDetailViewControllerFactoryProtocol {
    func make(args: MenuDetailViewControllerArgs) -> MenuDetailViewController
}

final class MenuDetailViewControllerFactory: MenuDetailViewControllerFactoryProtocol {
    func make(args: MenuDetailViewControllerArgs) -> MenuDetailViewController {
        guard let menuDetailViewController = MenuDetailViewController.loadFromStoryBoard() else {
            fatalError()
        }
        let presenter = MenuDetailPresenter(data: args.data)
        presenter.view = menuDetailViewController
        presenter.delegate = args.delegate
        menuDetailViewController.presenter = presenter
        return menuDetailViewController
    }
}
