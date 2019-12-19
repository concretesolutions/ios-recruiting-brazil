//
//  CAShapeLayer.swift
//  Movs
//
//  Created by Gabriel D'Luca on 18/12/19.
//  Copyright © 2019 Gabriel D'Luca. All rights reserved.
//

import UIKit

extension CAShapeLayer {
    func updatePath(to newPath: CGPath, duration: Double = 0.0, animated: Bool = true) {
        if animated {
            let animation = CABasicAnimation(keyPath: "path")
            animation.duration = duration
            animation.fromValue = self.path!
            animation.toValue = newPath
            animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName(rawValue: "easeInEaseOut"))
            self.add(animation, forKey: "path")
        }
        self.path = newPath
    }
}
