//
//  DMCardView.swift
//  DataMovie
//
//  Created by Andre on 02/05/2018.
//  Copyright © 2018 Andre. All rights reserved.
//

import UIKit

@IBDesignable
class DMCardView: UIView {
    
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var shadowColor: UIColor = .clear {
        didSet {
            updateViewsFromIB()
        }
    }
    
    @IBInspectable var layerBackgroundColor: UIColor = .clear {
        didSet {
            layer.backgroundColor = layerBackgroundColor.cgColor
        }
    }
    
    @IBInspectable var shadowOpacity: Float = 0.0 {
        didSet {
            updateViewsFromIB()
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            updateViewsFromIB()
        }
    }
    
    @IBInspectable var borderColor: UIColor = .clear {
        didSet {
            updateViewsFromIB()
        }
    }
    
    override public func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        updateViewsFromIB()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        setupView()
    }
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        setupView()
//    }
}


extension DMCardView: BaseViewProtocol {
    
    internal func setupView() {
        layer.cornerRadius = cornerRadius
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = borderWidth
        layer.masksToBounds = false
        //Shadow
        let shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOpacity = shadowOpacity
        layer.shadowOffset = CGSize.zero
        layer.shadowPath = shadowPath
        layer.shouldRasterize = true
    }
    
}
