//
//  DMButton.swift
//  DataMovie
//
//  Created by Andre on 02/05/2018.
//  Copyright © 2018 Andre. All rights reserved.
//

import UIKit

enum DMButtonStatus {
    case normal(String?, UIImage?, Bool)
    case loading
    case hideLoading
    case done
}

@IBDesignable
class DMButton: UIButton {
    
    private var originalButtonText: String?
    private var originalImage: UIImage?
    private var activityIndicator: UIActivityIndicatorView!
    
    @IBInspectable var fillColor: UIColor = .clear {
        didSet {
            updateViewsFromIB()
            layer.backgroundColor = fillColor.cgColor
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            updateViewsFromIB()
        }
    }
    
    @IBInspectable var shadowColor: UIColor = .clear {
        didSet {
            updateViewsFromIB()
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
    
    override public var isEnabled: Bool {
        didSet {
            alpha = isEnabled ? 1 : 0.4
        }
    }
    
    override open var isHighlighted: Bool {
        didSet {
            if fillColor != .clear {
               layer.backgroundColor = isHighlighted ? fillColor.withAlphaComponent(0.8).cgColor : fillColor.withAlphaComponent(1).cgColor
            }
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

// MARK: - Setup -

extension DMButton: BaseViewProtocol {
    
    func setupView() {
        
        if let image = image(for: .normal) {
            setImage(image.withRenderingMode(.alwaysTemplate), for: .normal)
        }
        
        layer.cornerRadius = cornerRadius
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
        layer.masksToBounds = false
        
        //Shadow
        let shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOpacity = shadowOpacity
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = cornerRadius
        layer.shadowPath = shadowPath
        layer.shouldRasterize = true
        
        if(isEnabled) {
            alpha = 1
        } else {
            alpha = 0.4
        }
        
        addTargets()
    }
    
}

// MARK: - Loading -

extension DMButton {
    
    private func showLoading() {
        originalImage = image(for: .normal)
        originalButtonText = titleLabel?.text
        setTitle("", for: .normal)
        setImage(nil, for: .normal)
        
        if (activityIndicator == nil) {
            activityIndicator = createActivityIndicator()
        }
        
        showSpinning()
        isUserInteractionEnabled = false
    }
    
    private func hideLoading() {
        setImage(originalImage, for: .normal)
        setTitle(originalButtonText, for: .normal)
        activityIndicator.stopAnimating()
        isUserInteractionEnabled = true
        originalButtonText = nil
        originalImage = nil
    }
    
    private func showDone() {
        if activityIndicator != nil {
            hideLoading()
        }
        setImage(#imageLiteral(resourceName: "ic_check").withRenderingMode(.alwaysTemplate), for: .normal)
        isUserInteractionEnabled = false
    }
    
    private func createActivityIndicator() -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = tintColor
        return activityIndicator
    }
    
    private func showSpinning() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        addSubview(activityIndicator)
        centerActivityIndicatorInButton()
        activityIndicator.startAnimating()
    }
    
    private func centerActivityIndicatorInButton() {
        let xCenterConstraint = NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: activityIndicator, attribute: .centerX, multiplier: 1, constant: 0)
        addConstraint(xCenterConstraint)
        
        let yCenterConstraint = NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: activityIndicator, attribute: .centerY, multiplier: 1, constant: 0)
        addConstraint(yCenterConstraint)
    }
    
    func showStatus(_ status: DMButtonStatus) {
        switch status {
        case .normal(let title, let image, let isEnable):
            if activityIndicator != nil {
                activityIndicator.stopAnimating()
            }
            self.isEnabled = isEnable
            setTitle(title, for: .normal)
            setImage(image?.withRenderingMode(.alwaysTemplate), for: .normal)
            isUserInteractionEnabled = true
            break
        case .loading:
            showLoading()
            break
        case .hideLoading:
            hideLoading()
            break
        case .done:
            showDone()
            break
        }
    }
    
}

//MARK: - Touch animations -

extension DMButton {
    
    private func animateOnTouch(inside : Bool) {
        if !inside {
            layer.shadowOpacity = 0.7
            layer.transform = CATransform3DIdentity
            return
        }
        
        let scale : CGFloat = 0.97
        let scaleTransform = CATransform3DMakeScale(scale, scale, 1.0)
        
        // update main cirle, the scale will also influence the sublayers
        layer.transform = scaleTransform
        layer.shadowOpacity = 0.3
    }
    
    private func addTargets() {
        self.addTarget(self, action: #selector(touchDown(sender:)), for: .touchDown)
        self.addTarget(self, action: #selector(touchUpInside(sender:)), for: .touchUpInside)
        self.addTarget(self, action: #selector(touchDragExit(sender:)), for: .touchDragExit)
        self.addTarget(self, action: #selector(touchDragEnter(sender:)), for: .touchDragEnter)
        self.addTarget(self, action: #selector(touchCancel(sender:)), for: .touchCancel)
    }
    
    @objc internal func touchDown(sender: DMButton) {
        animateOnTouch(inside: true)
    }
    @objc internal func touchUpInside(sender: DMButton) {
        animateOnTouch(inside: false)
    }
    @objc internal func touchDragExit(sender: DMButton) {
        animateOnTouch(inside: false)
    }
    @objc internal func touchDragEnter(sender: DMButton) {
        animateOnTouch(inside: true)
    }
    @objc internal func touchCancel(sender: DMButton) {
        animateOnTouch(inside: false)
    }
    
}
