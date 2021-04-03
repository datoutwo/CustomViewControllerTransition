//
//  MenuCell.swift
//  CustomViewControllerTransition
//
//  Created by Delan Wang on 2021/2/27.
//

import UIKit

class MenuCell: UITableViewCell {
    @IBOutlet var containerView: InspectableView!
    @IBOutlet var ingredientImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        ingredientImageView.layer.cornerRadius = 8
        ingredientImageView.layer.masksToBounds = true
    }
}

// MARK: - Loadable

extension MenuCell: Loadable {}
