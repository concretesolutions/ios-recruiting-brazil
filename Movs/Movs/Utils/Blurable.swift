//
//  Blurable.swift
//  Movs
//
//  Created by Gabriel Coutinho on 03/12/20.
//

// Fonte: https://stackoverflow.com/questions/41156542/how-to-blur-an-existing-image-in-a-uiimageview-with-swift

import Foundation
import UIKit

protocol Maskable {
    func addGradientBottomMask()
}

extension Maskable where Self: UIView {
    func addGradientBottomMask() {
        let gradient = CAGradientLayer()
        gradient.startPoint = CGPoint(x: 0.5, y: 1.0)
        gradient.endPoint = CGPoint(x: 0.5, y: 0.7)
        let bgColor = UIColor.systemBackground
        gradient.colors = [
            bgColor.withAlphaComponent(0.0).cgColor,
            bgColor.withAlphaComponent(1.0).cgColor
        ]
        gradient.locations = [
            NSNumber(value: 0.0),
            NSNumber(value: 1.0)
        ]
        gradient.frame = self.bounds
        self.layer.mask = gradient
    }
}

// Conformance
extension UIImageView: Maskable {}
