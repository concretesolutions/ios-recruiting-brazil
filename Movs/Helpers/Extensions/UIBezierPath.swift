//
//  UIBezierPath.swift
//  Movs
//
//  Created by Gabriel D'Luca on 23/12/19.
//  Copyright © 2019 Gabriel D'Luca. All rights reserved.
//

import UIKit

extension UIBezierPath {
    convenience init(withPoints points: [CGPoint]) {
        self.init()
        
        if points.count > 0 {
            self.move(to: points.first!)
            for point in points[1...] {
                self.addLine(to: point)
            }
        }
    }
}
