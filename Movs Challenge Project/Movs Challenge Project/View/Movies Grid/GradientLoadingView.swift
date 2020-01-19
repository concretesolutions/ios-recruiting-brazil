//
//  GradientLoadingView.swift
//  Movs Challenge Project
//
//  Created by Jezreel Barbosa on 18/01/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import UIKit

class GradientLoadingView: UIView {
    // Static Properties
    // Static Methods
    // Public Types
    // Public Properties
    // Public Methods
    
    func makeAnimation() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.lightGray.cgColor, UIColor.clear.cgColor]
        gradientLayer.locations = [0, 0.5, 1]
        gradientLayer.frame = CGRect(x: 0, y: 0, width: frame.height * 3, height: frame.width * 1.5)
        
        let angle: CGFloat = -.pi / 4.0
        gradientLayer.transform = CATransform3DMakeRotation(angle, 0, 0, 1)
        
        layer.mask = gradientLayer
        
        let animation = CABasicAnimation(keyPath: "transform.translation.x")
        animation.duration = 2
        animation.fromValue = -frame.height * 4
        animation.toValue = frame.height * 2
        animation.repeatCount = .infinity
        gradientLayer.add(animation, forKey: nil)
    }
    
    // Initialisation/Lifecycle Methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // Override Methods
    // Private Types
    // Private Properties
    // Private Methods
}
