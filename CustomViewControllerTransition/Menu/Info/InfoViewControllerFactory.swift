//
//  InfoViewControllerFactory.swift
//  CustomViewControllerTransition
//
//  Created by Delan Wang on 2021/4/3.
//

import Foundation

protocol InfoViewControllerFactoryProtocol {
    func make() -> InfoViewController
}

final class InfoViewControllerFactory: InfoViewControllerFactoryProtocol {
    func make() -> InfoViewController {
        guard let infoViewController = InfoViewController.loadFromStoryBoard() else {
            fatalError()
        }
        let presenter = InfoPresenter()
        infoViewController.presenter = presenter
        presenter.view = infoViewController
        return infoViewController
    }
}
