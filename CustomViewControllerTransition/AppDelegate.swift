//
//  AppDelegate.swift
//  CustomViewControllerTransition
//
//  Created by Delan Wang on 2021/2/27.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        showMenuViewController()
        return true
    }
}

// MARK: - private

extension AppDelegate {
    private func showMenuViewController() {
        let menuDetailViewControllerFactory = MenuDetailViewControllerFactory()
        let factory = MenuFactory(menuDetailViewControllerFactory: menuDetailViewControllerFactory)
        let menuViewController = factory.make()
        let root = UINavigationController(rootViewController: menuViewController)
        window = UIWindow()
        window?.rootViewController = root
        window?.makeKeyAndVisible()
    }
}
