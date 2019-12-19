//
//  UIButton.swift
//  Movs
//
//  Created by Gabriel D'Luca on 03/12/19.
//  Copyright © 2019 Gabriel D'Luca. All rights reserved.
//

import UIKit

extension UIButton {
    override open func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let toleranceMargin = self.bounds.insetBy(dx: -30, dy: -30)
        return toleranceMargin.contains(point)
    }
}
