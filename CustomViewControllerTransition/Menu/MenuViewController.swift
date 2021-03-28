//
//  MenuViewController.swift
//  CustomViewControllerTransition
//
//  Created by Delan Wang on 2021/2/27.
//

import UIKit

protocol MenuView: class {
    func setupView()
}

final class MenuViewController: UIViewController, MenuView {
    var presenter: MenuPresenterProtocol!
    var source: MenuDataTableViewProtocol!
    @IBOutlet private var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.notifyViewDidLoad()
    }

    func setupView() {
        tableView.delegate = source
        tableView.dataSource = source
        tableView.register(MenuCell.loadNib(), forCellReuseIdentifier: MenuCell.identifier)
    }
}

extension MenuViewController: StoryboardLoadable {
    static var storyboard: MenuStoryboard = .main
}
