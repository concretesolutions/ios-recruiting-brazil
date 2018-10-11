//
//  DMCircleButton.swift
//  DataMovie
//
//  Created by Andre on 02/05/2018.
//  Copyright © 2018 Andre. All rights reserved.
//

import UIKit
import CoreGraphics

@IBDesignable
class DMCircleButton: UIButton {

    private var circleLayer : CALayer!
    
    private var planeRotation: CGFloat = 0.0 {
        didSet {
            CATransaction.begin()
            CATransaction.setDisableActions(true)
            CATransaction.commit()
        }
    }
    
    @IBInspectable var fillColor: UIColor = .blueColor {
        didSet {
            updateViewsFromIB()
            if let layer = circleLayer {
                 layer.backgroundColor = fillColor.cgColor
            }
        }
    }
    
    override var tintColor: UIColor! {
        didSet {
            if let imageView = imageView {
                imageView.tintColor = tintColor
            }
        }
    }
    
    // limit touch to circle path
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        return UIBezierPath(ovalIn: self.bounds).contains(point) ? self : nil
    }
    
    @objc internal func touchDown(sender: DMCircleButton) {
        animateOnTouch(inside: true)
    }
    @objc internal func touchUpInside(sender: DMCircleButton) {
        animateOnTouch(inside: false)
    }
    @objc internal func touchDragExit(sender: DMCircleButton) {
        animateOnTouch(inside: false)
    }
    @objc internal func touchDragEnter(sender: DMCircleButton) {
        animateOnTouch(inside: true)
    }
    @objc internal func touchCancel(sender: DMCircleButton) {
        animateOnTouch(inside: false)
    }
    
    override public func draw(_ rect: CGRect) {
        super.draw(rect)
        setupView()
    }

}

//MARK: - Functions -

extension DMCircleButton {
    
    private func animateOnTouch(inside : Bool) {
        if !inside {
            circleLayer.shadowOpacity = 0.7
            circleLayer.transform = CATransform3DIdentity
            return
        }
        
        let scale : CGFloat = 0.9
        let scaleTransform = CATransform3DMakeScale(scale, scale, 1.0)
        
        // update main cirle, the scale will also influence the sublayers
        circleLayer.transform = scaleTransform
        circleLayer.shadowOpacity = 0.3
    }
    
    private func addTargets() {
        self.addTarget(self, action: #selector(touchDown(sender:)), for: .touchDown)
        self.addTarget(self, action: #selector(touchUpInside(sender:)), for: .touchUpInside)
        self.addTarget(self, action: #selector(touchDragExit(sender:)), for: .touchDragExit)
        self.addTarget(self, action: #selector(touchDragEnter(sender:)), for: .touchDragEnter)
        self.addTarget(self, action: #selector(touchCancel(sender:)), for: .touchCancel)
    }
    
    func setIcon(image: UIImage, animation: UIView.AnimationOptions = .transitionFlipFromBottom) {
        if let imageView = imageView {
            UIView.transition(with: imageView, duration:0.3, options: [animation, .curveEaseInOut], animations: {
                self.setImage(image.withRenderingMode(.alwaysTemplate), for: .normal)
            },completion: nil)
        }
        
    }
    
}

//MARK: - BaseViewProtocol -

extension DMCircleButton: BaseViewProtocol {

    func setupView() {
        if(circleLayer == nil) {
            backgroundColor = .clear
            
            circleLayer = CALayer()
            circleLayer.frame = self.bounds
            circleLayer.cornerRadius = bounds.width/2.0
            circleLayer.backgroundColor = fillColor.cgColor
            
            layer.addSublayer(circleLayer)
            layer.backgroundColor = nil // copied backgroundColor from button layer to circleLayer
            
            circleLayer.cornerRadius = bounds.width/2.0
            circleLayer.shadowPath = UIBezierPath(ovalIn: self.bounds).cgPath
            circleLayer.shadowOpacity = 0.7
            circleLayer.shadowOffset = CGSize(width: 0.0, height: 3.0)
            
            if let imageView = imageView, let image = image(for: .normal) {
                imageView.tintColor = tintColor
                setImage(image.withRenderingMode(.alwaysTemplate), for: .normal)
                circleLayer.addSublayer(imageView.layer)
            }
            
            addTargets()
        }
    }
    
}
