//
//  UIView+MovieCard.swift
//  Movs
//
//  Created by Maisa on 24/10/18.
//  Copyright © 2018 Maisa Milena. All rights reserved.
//

import UIKit

class UIViewMovieCard: UIView {
    
    private var shadowLayer: CAShapeLayer!
    private let cornerRadius: CGFloat = 4.0
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = cornerRadius
        
        // Create a smooth shadow to the card
        if shadowLayer == nil {
            shadowLayer = CAShapeLayer()

            shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
            shadowLayer.fillColor = UIColor.white.cgColor

            shadowLayer.shadowColor = UIColor.black.cgColor
            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.shadowOffset = CGSize(width: 0.0, height: 0.5)
            shadowLayer.shadowOpacity = 0.1
            shadowLayer.shadowRadius = cornerRadius

            layer.insertSublayer(shadowLayer, at: 0)
        }
    }

}
