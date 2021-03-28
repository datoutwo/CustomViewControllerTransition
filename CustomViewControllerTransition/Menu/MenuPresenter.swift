//
//  MenuPresenter.swift
//  CustomViewControllerTransition
//
//  Created by Delan Wang on 2021/2/28.
//

import Foundation

protocol MenuPresenterProtocol: AnyObject {
    func notifyViewDidLoad()
    func didSelect(data: MenuData)
}

final class MenuPresenter: MenuPresenterProtocol {
    private let router: MenuRouterProtocol
    weak var view: MenuView?

    init(router: MenuRouterProtocol) {
        self.router = router
    }

    func notifyViewDidLoad() {
        view?.setupView()
    }

    func didSelect(data: MenuData) {
        let args = MenuDetailViewControllerArgs(data: data, delegate: self)
        router.openDetail(args: args)
    }
}

// MARK: - MenuDetailPresenterDelegate
extension MenuPresenter: MenuDetailPresenterDelegate {
    func didDismiss() {
        router.dismissView()
    }
}
