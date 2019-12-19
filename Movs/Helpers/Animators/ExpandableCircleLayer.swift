//
//  ExpandableCircleLayer.swift
//  Movs
//
//  Created by Gabriel D'Luca on 18/12/19.
//  Copyright © 2019 Gabriel D'Luca. All rights reserved.
//

import UIKit

class ExpandableCircleLayer: CAShapeLayer {
    
    // MARK: - Initializers and Deinitializers
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override required internal init() {
        super.init()
        self.bounds = CGRect(x: self.bounds.origin.x, y: self.bounds.origin.y, width: self.bounds.width * 2, height: self.bounds.height * 2)
    }
    
    convenience init(toBounds bounds: CGRect, origin: CGPoint, fillColor: UIColor?) {
        self.init()
        self.fillColor = fillColor?.cgColor
        
        let shapeBounds = CGRect(x: origin.x - 12.5, y: origin.y - 12.5, width: 25.0, height: 25.0)
        let expandedBounds = CGRect(x: origin.x - bounds.width * 1.25, y: origin.y - bounds.width * 1.25, width: bounds.width * 3.0, height: bounds.width * 3.0)

        self.path = UIBezierPath(roundedRect: shapeBounds, cornerRadius: 12.5).cgPath
        let expandedPath = UIBezierPath(roundedRect: expandedBounds, cornerRadius: bounds.width * 3.0).cgPath

        self.updatePath(to: expandedPath, duration: 0.375)
    }
}
