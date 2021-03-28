//
//  InspectableView.swift
//  CustomViewControllerTransition
//
//  Created by Delan Wang on 2021/2/27.
//

import UIKit

@IBDesignable
class InspectableView: UIView {

    @objc enum ViewCorner: Int {
        case none
        case top
        case left
        case bottom
        case right
        case full
        
        func cornerMask() -> CACornerMask {
            switch self {
            case .none:
                return []
            case .top:
                return [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            case .left:
                return [.layerMinXMinYCorner, .layerMinXMaxYCorner]
            case .bottom:
                return [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            case .right:
                return [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
            case .full:
                return [.layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner]
            }
        }
 
    }

    var cornerStyle: ViewCorner = .top {
        didSet {
            layer.maskedCorners = cornerStyle.cornerMask()
        }
    }

    @IBInspectable
    private var _cornerStyle: Int {
        get {
            return cornerStyle.rawValue
        }
        set {
            cornerStyle = ViewCorner(rawValue: newValue) ?? .none
        }
    }

    @IBInspectable
    var cornerRadius: CGFloat = 0 {
        didSet {
            setupView()
        }
    }

    @IBInspectable
    var borderColor: UIColor = .clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }

    @IBInspectable
    var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }

    @IBInspectable
    var shadowRadius: CGFloat = 0 {
        didSet {
            layer.shadowRadius = shadowRadius
        }
    }

    @IBInspectable
    var shadowColor: UIColor = .clear {
        didSet {
            layer.shadowColor = shadowColor.cgColor
        }
    }

    @IBInspectable
    var shadowOffset: CGSize = .zero {
        didSet {
            layer.shadowOffset = shadowOffset
        }
    }

    @IBInspectable
    var shadowOpacity: Float = 0.0 {
        didSet {
            layer.shadowOpacity = shadowOpacity
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }

    func setupView() {
        layer.cornerRadius = cornerRadius
        layer.maskedCorners = cornerStyle.cornerMask()
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
        layer.shadowRadius = shadowRadius
        layer.shadowOpacity = shadowOpacity
        layer.shadowOffset = shadowOffset
        layer.shadowColor = shadowColor.cgColor
    }
}
