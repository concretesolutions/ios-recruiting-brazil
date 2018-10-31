//
//  UIViewHelper.swift
//  concreto-filmes
//
//  Created by Leonel Menezes on 30/10/18.
//  Copyright © 2018 Leonel Menezes. All rights reserved.
//

import UIKit

extension UIView {
    /**
     Aplly a grandient through the whole view
     - Parameters:
     - colours: the colors of the gradient.
     */
    func applyGradient(colours: [UIColor]) {
        self.applyGradient(colours: colours, locations: nil)
    }
    
    /**
     Applies a gradient to a view with determined colors and locations
     - Parameters:
     - colours: the colors of the gradient
     - locations: the locations of the colors of the gradient
     */
    func applyGradient(colours: [UIColor], locations: [NSNumber]?) {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.cornerRadius = self.layer.cornerRadius
        gradient.colors = colours.map { $0.cgColor }
        gradient.locations = locations
        gradient.zPosition = self.layer.zPosition + 2
        gradient.name = "gradient"
        self.layer.addSublayer(gradient)
    }
    
    func removeGradientLayer() {
        if self.layer.sublayers != nil {
            for layer in self.layer.sublayers! where layer.name == "gradient" {
                layer.removeFromSuperlayer()
            }
        }
    }
}
