//
//  FavoriteMoviesFiltersViewScreen.swift
//  Movs
//
//  Created by Gabriel D'Luca on 19/12/19.
//  Copyright © 2019 Gabriel D'Luca. All rights reserved.
//

import UIKit
import SnapKit

final class FavoriteMoviesFiltersViewScreen: UIView {
    lazy var yearPicker: UIPickerView = {
        let picker = UIPickerView()
        return picker
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FavoriteMoviesFiltersViewScreen: CodeView {
    func buildViewHierarchy() {
        self.addSubview(self.yearPicker)
    }
    
    func setupConstraints() {
        self.yearPicker.snp.makeConstraints({ make in
            make.centerX.width.equalTo(self)
            make.top.equalTo(self).inset(24.0)
            make.height.equalTo(self.yearPicker.snp.width).multipliedBy(0.6)
        })
    }
    
    func setupAdditionalConfiguration() {
        self.backgroundColor = .systemBackground
    }
}
