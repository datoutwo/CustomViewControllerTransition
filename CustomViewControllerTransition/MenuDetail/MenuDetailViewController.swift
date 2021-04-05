//
//  MenuDetailViewController.swift
//  CustomViewControllerTransition
//
//  Created by Delan Wang on 2021/3/13.
//

import UIKit

protocol MenuDetailView: AnyObject {
    func setupView(data: MenuData)
}

final class MenuDetailViewController: UIViewController, MenuDetailView  {
    var presenter: MenuDetailPresenterProtocol!
    
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var descriptionLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.notifyViewDidLoad()
    }

    func setupView(data: MenuData) {
        imageView.image = data.image
        titleLabel.text = data.title
        descriptionLabel.text = data.description
    }
    @IBAction func didTapClose(_ sender: UIButton) {
        presenter.notifyCloseButtonDidTap()
    }
}

// MARK: - StoryboardLoadable

extension MenuDetailViewController: StoryboardLoadable {
    static var storyboard: MenuStoryboard = .main
}
