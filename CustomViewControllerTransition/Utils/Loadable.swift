//
//  Loadable.swift
//  CustomViewControllerTransition
//
//  Created by Delan Wang on 2021/2/27.
//

import UIKit

protocol Identifiable {
    static var identifier: String { get }
}

extension Identifiable {
    static var identifier: String {
        return String(describing: Self.self)
    }
}

protocol Loadable: Identifiable {
    static func loadNib() -> UINib
    static func loadFromNib(bundle storyboardBundleOrNil: Bundle?) -> Self?
}

// MARK: - Loadable default implementation

extension Loadable {
    static func loadNib() -> UINib {
        return UINib(nibName: self.identifier, bundle: nil)
    }

    static func loadFromNib(bundle storyboardBundleOrNil: Bundle? = nil) -> Self? {
        return UINib(nibName: self.identifier, bundle: storyboardBundleOrNil).instantiate(withOwner: nil, options: nil).first as? Self
    }
}

extension Loadable where Self: UIViewController {
    static func loadFromNib(bundle storyboardBundleOrNil: Bundle? = nil) -> Self? {
        return self.init(nibName: self.identifier, bundle: storyboardBundleOrNil)
    }
}

enum MenuStoryboard: String {
    case main = "Main"
}

protocol StoryboardLoadable: Identifiable {
    
    static var storyboard: MenuStoryboard { get }
}

// MARK: - StoryboardLoadable default implementation

extension StoryboardLoadable {
    
    static func loadFromStoryBoard(bundle storyboardBundleOrNil: Bundle? = nil) -> Self? {
        return UIStoryboard(name: storyboard.rawValue, bundle: storyboardBundleOrNil).instantiateViewController(withIdentifier: identifier) as? Self
    }
}
