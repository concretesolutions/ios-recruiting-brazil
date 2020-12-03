//
//  Blurable.swift
//  Movs
//
//  Created by Gabriel Coutinho on 03/12/20.
//

// Fonte: https://stackoverflow.com/questions/41156542/how-to-blur-an-existing-image-in-a-uiimageview-with-swift

import Foundation
import UIKit

protocol Bluring {
    func addBlur(_ alpha: CGFloat)
}

extension Bluring where Self: UIView {
    func addBlur(_ alpha: CGFloat = 0.5) {
        // create effect
        let effect = UIBlurEffect(style: .dark)
        let effectView = UIVisualEffectView(effect: effect)

        // set boundry and alpha
        effectView.frame = self.bounds
        effectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        effectView.alpha = alpha

        self.addSubview(effectView)
    }
}

// Conformance
extension UIImageView: Bluring {}
