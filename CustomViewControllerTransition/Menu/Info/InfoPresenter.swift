//
//  InfoPresenter.swift
//  CustomViewControllerTransition
//
//  Created by Delan Wang on 2021/4/3.
//

import Foundation

protocol InfoPresenterProtocol {
    func notifyViewDidLoad()
}

final class InfoPresenter: InfoPresenterProtocol {
    weak var view: InfoView?
    func notifyViewDidLoad() {
        view?.setupView()
    }
}
