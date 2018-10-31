//
//  CALayer+SketchShadow.swift
//  Hashtag
//
//  Created by Gustavo Arthur Vollbrecht on 25/04/18.
//  Copyright © 2018 Jonas de Castro Leitao. All rights reserved.
//
import UIKit

extension CALayer {
    func applySketchShadow(
        color: UIColor = UIColor.black.withAlphaComponent(0.09),
        alpha: Float = 1,
        x: CGFloat = 1,
        y: CGFloat = 2,
        blur: CGFloat = 6,
        spread: CGFloat = 0)
    {
        shadowColor = color.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = blur / 2.0
        if spread == 0 {
            shadowPath = nil
        } else {
            let dx = -spread
            let rect = bounds.insetBy(dx: dx, dy: dx)
            shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }
}
