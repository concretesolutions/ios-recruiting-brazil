//
//  UIView+gradientToView.swift
//  Movs
//
//  Created by Julio Brazil on 24/11/18.
//  Copyright © 2018 Julio Brazil. All rights reserved.
//

import UIKit

extension UIView {
    public static func addGradient(toView view: UIView){
        for layer in view.layer.sublayers ?? []{
            if layer.name == "GradientLayer" {
                return
            }
        }
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.colors = [UIColor.white.withAlphaComponent(0).cgColor, UIColor.white.cgColor]
        gradient.zPosition = -1
        gradient.name = "GradientLayer"
        view.layer.addSublayer(gradient)
    }
}
