//
//  GradientView.swift
//  ConcreteChallenge
//
//  Created by Kaique Damato on 10/1/20.
//  Copyright © 2020 KiQ. All rights reserved.
//

import UIKit

class GradientView: UIView {
    
    private let gradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        
        return layer
    }()
    
    override func draw(_ rect: CGRect) {
        self.layer.addSublayer(gradientLayer)
        gradientLayer.frame = self.bounds
        gradientLayer.startPoint = self.startPoint
        gradientLayer.endPoint = self.endPoint
        gradientLayer.colors = self.colors
        gradientLayer.type = self.type
        gradientLayer.locations = self.locations
    }
    
    public var colors: [CGColor] = [UIColor.clear.cgColor, UIColor.black.cgColor] {
        didSet{
            self.gradientLayer.colors = self.colors
        }
    }
    
    public var startPoint: CGPoint = CGPoint(x: 0.5, y: 0) {
        didSet {
            self.gradientLayer.startPoint = startPoint
        }
    }
    
    public var endPoint: CGPoint = CGPoint(x: 0.5, y: 1) {
        didSet{
            self.gradientLayer.endPoint = self.endPoint
        }
    }
    
    public var type: CAGradientLayerType = .axial {
        didSet {
            gradientLayer.type = self.type
        }
    }
    
    public var locations: [NSNumber] = [0.55, 1] {
        didSet {
            gradientLayer.locations = self.locations
        }
    }
}
