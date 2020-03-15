//
//  CALayer+Extensions.swift
//  MyMoviesCollection
//
//  Created by Filipe Merli on 14/03/20.
//  Copyright © 2020 Filipe Merli. All rights reserved.
//

import UIKit

extension CALayer {
    func addBottomBorders() {
        let subLayer = CALayer()
        subLayer.frame = CGRect(x: 0, y: frame.height - CGFloat(0.5), width: frame.width, height: CGFloat(0.5))
        subLayer.backgroundColor = UIColor.lightGray.cgColor
        self.addSublayer(subLayer)
        
    }
}
