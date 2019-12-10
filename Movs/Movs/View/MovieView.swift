//
//  MovieView.swift
//  Movs
//
//  Created by Lucca Ferreira on 04/12/19.
//  Copyright © 2019 LuccaFranca. All rights reserved.
//

import UIKit

class MovieView: UIView {

    required init() {
        super.init(frame: .zero)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension MovieView: ViewCode {

    func buildViewHierarchy() {

    }

    func setupContraints() {

    }

    func setupAdditionalConfiguration() {}
    
}
