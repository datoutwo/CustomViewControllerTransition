//
//  InfoViewController.swift
//  CustomViewControllerTransition
//
//  Created by Delan Wang on 2021/4/3.
//

import UIKit

protocol InfoView: AnyObject {
    func setupView()
}

final class InfoViewController: UIViewController, InfoView {
    var presenter: InfoPresenterProtocol!

    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var headerLabel: UILabel!

    override func viewDidLoad() {
        presenter.notifyViewDidLoad()
    }

    func setupView() {
        titleLabel.text = "This is scam info"
        headerLabel.text = "The 1-bedroom apartment offers a piece of home in the middle of the most exciting and colorful district of Berlin, in Neukölln. Whether you are traveling for work, traveling or temporarily need a pleasant accommodation, here you will find your smart apartment on time.\nThe apartment is located on the 4th floor in the wing at the top in a well-kept Berlin apartment building.\nThe kitchen is equipped with kitchen utensils, fridge with freezer, coffee machine [incl. Starter pack coffee capsules], stove, sink and a sitting area.\nThe bright tiled bathroom has a shower tray, toilet, vanity and a shelf for your bath utensils, hair dryer and towels.\nThe separate bedroom has a 1.40m bed and is suitable for one to two people. Bed linen is included. Furthermore, there is a Smart TV with Netflixx, Amazon, etc. [Wi-Fi included]. Furthermore, you will find next to the clothes rail, a spacious closet, which provides space for stowing and hanging clothes. There is an iron and ironing board in the closet.\nThe apartment is fitted with floorboards and the walls, ceilings and windows are repainted and tastefully furnished in an industrial minimalist style. There is also a cellar room available. The apartment has a kitchen with a separate sleeping area.\nSelf check-inYou can access the apartment using a key lockbox which does not require previous human contact."
    }
}

// MARK: - StoryboardLoadable

extension InfoViewController: StoryboardLoadable {
    static var storyboard: MenuStoryboard = .main
}
