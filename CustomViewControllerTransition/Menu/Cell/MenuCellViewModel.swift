//
//  MenuCellViewModel.swift
//  CustomViewControllerTransition
//
//  Created by Delan Wang on 2021/2/28.
//

import UIKit

protocol MenuCellViewModelProtocol {
    func config(cell: MenuCell)
}

class MenuCellViewModel: MenuCellViewModelProtocol {
    private let data: MenuData

    init(data: MenuData) {
        self.data = data
    }

    func config(cell: MenuCell) {
        cell.titleLabel.text = data.title
        cell.descriptionLabel.text = data.description
        cell.ingredientImageView.image = data.image
    }
}
