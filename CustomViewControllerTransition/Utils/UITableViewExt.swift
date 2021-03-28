//
//  UITableViewExt.swift
//  CustomViewControllerTransition
//
//  Created by Delan Wang on 2021/2/27.
//

import UIKit

extension UITableView {
    func dequeueReusable<T>(for indexPath: IndexPath) -> T where T: UITableViewCell, T: Loadable {
        guard let reusableCell = self.dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as? T else {
            return T()
        }
        return reusableCell
    }
}
