//
//  MenuDetailPresenter.swift
//  CustomViewControllerTransition
//
//  Created by Delan Wang on 2021/3/13.
//

import Foundation

protocol MenuDetailPresenterDelegate: AnyObject {
    func didDismiss()
}

protocol MenuDetailPresenterProtocol {
    func notifyViewDidLoad()
    func notifyCloseButtonDidTap()
}

final class MenuDetailPresenter: MenuDetailPresenterProtocol {
    weak var view: MenuDetailView?
    weak var delegate: MenuDetailPresenterDelegate?
    private let data: MenuData

    init(data: MenuData) {
        self.data = data
    }

    func notifyViewDidLoad() {
        view?.setupView(data: data)
    }

    func notifyCloseButtonDidTap() {
        delegate?.didDismiss()
    }
}
