//
//  GradientImageView.swift
//  ConcreteChallenge
//
//  Created by Alexandre Abrahão on 08/12/19.
//  Copyright © 2019 Concrete. All rights reserved.
//

import UIKit

/// A UIImage with gradient
class GradientImageView: UIImageView {
    // MARK: - Properties
    let gradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.isOpaque = false
        gradient.locations = [0.0, 0.9]
        return gradient
    }()

    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View methods
    func setup() {
        gradient.colors = [
            UIColor.clear.cgColor,
            UIColor(red: 0, green: 0, blue: 0, alpha: 0.5).cgColor
        ]
        self.layer.addSublayer(gradient)
    }

    override func layoutSubviews() {
        gradient.frame = self.layer.bounds
    }
}
