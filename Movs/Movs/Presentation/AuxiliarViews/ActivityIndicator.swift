//
//  ActivityIndicator.swift
//  Movs
//
//  Created by Douglas Silveira Machado on 12/08/19.
//  Copyright © 2019 Douglas Silveira Machado. All rights reserved.
//

import UIKit

class ActivityIndicator: UIActivityIndicatorView {

    override init(frame: CGRect) {
        super.init(style: .whiteLarge)
        self.color = Design.Colors.darkBlue
        self.contentMode = .scaleAspectFit
        self.backgroundColor = .white
        self.translatesAutoresizingMaskIntoConstraints = false
        self.startAnimating()
    }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
