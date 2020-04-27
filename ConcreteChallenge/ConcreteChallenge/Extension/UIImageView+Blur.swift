//
//  UIImageView+Blur.swift
//  ConcreteChallenge
//
//  Created by Erick Pinheiro on 25/04/20.
//  Copyright © 2020 Erick Martins Pinheiro. All rights reserved.
//

import UIKit

extension UIImageView {
    func blurred(style: UIBlurEffect.Style = .light) -> UIVisualEffectView {
        let blurEffect = UIBlurEffect(style: style)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        self.addSubview(blurEffectView)
        blurEffectView.fillSuperview()
        return blurEffectView
    }
}
