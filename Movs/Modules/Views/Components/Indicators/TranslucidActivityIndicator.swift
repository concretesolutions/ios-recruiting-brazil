//
//  TranslucidActivityIndicator.swift
//  Movs
//
//  Created by Gabriel D'Luca on 18/12/19.
//  Copyright © 2019 Gabriel D'Luca. All rights reserved.
//

import UIKit

class TranslucidActivityIndicatorView: UIVisualEffectView {
    
    // MARK: - Properties
    
    internal var indicatorView: UIActivityIndicatorView
    
    // MARK: - Initializers
    
    override init(effect: UIVisualEffect?) {
        self.indicatorView = UIActivityIndicatorView()
        super.init(effect: effect)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TranslucidActivityIndicatorView: CodeView {
    func buildViewHierarchy() {
        self.contentView.addSubview(self.indicatorView)
    }
    
    func setupConstraints() {
        self.indicatorView.snp.makeConstraints({ make in
            make.centerX.centerY.equalTo(self.contentView)
            make.width.height.equalTo(self.contentView)
        })
    }
}
