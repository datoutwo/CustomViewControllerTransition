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

    private lazy var headerButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 40))
        button.backgroundColor = .blue
        button.setTitle("GO", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(didTapGo), for: .touchUpInside)
        return button
    }()
    @IBOutlet private var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.notifyViewDidLoad()
    }

    func setupView() {
        tableView.delegate = source
        tableView.dataSource = source
        tableView.register(MenuCell.loadNib(), forCellReuseIdentifier: MenuCell.identifier)
        tableView.tableHeaderView = headerButton
    }
}

// MARK: - private

extension MenuViewController {
    @objc private func didTapGo() {
        presenter.notifyDidTapGoButton()
    }
}

// MARK: - StoryboardLoadable

extension MenuViewController: StoryboardLoadable {
    static var storyboard: MenuStoryboard = .main
}

// MARK: - TransitionAnimationProtocol

extension MenuViewController: TransitionAnimationProtocol {
    var appearingTransition: TransitionAnimation? {
        return TransitionZoomIn(transitionType: .appear, duration: 1.0)
    }
    
    var disappearingTransition: TransitionAnimation? {
        return nil
    }
    
    var transitionFrame: CGRect? {
        guard let selectedCell = source.selectedCell else {
            return nil
        }
        let containerFrame = selectedCell.convert(selectedCell.containerView.frame, to: tableView)
        let cellFrame = tableView.convert(containerFrame, to: view)
        return cellFrame
    }
    
    func transitionDidStart(_ type: TransitionType) {}
    
    func transitionDidEnd(_ type: TransitionType) {}
}
