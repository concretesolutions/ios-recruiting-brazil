//
//  GenreCollectionViewCell.swift
//  Movs
//
//  Created by Gabriel D'Luca on 16/12/19.
//  Copyright © 2019 Gabriel D'Luca. All rights reserved.
//

import UIKit

class GenreCollectionViewCell: UICollectionViewCell {

    // MARK: - Interface Elements
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16.0, weight: .bold)
        label.textColor = UIColor.white
        return label
    }()
    
    // MARK: - Initializers and Deinitializers
        
    override required init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension GenreCollectionViewCell: CodeView {
    func buildViewHierarchy() {
        self.contentView.addSubview(self.nameLabel)
    }
    
    func setupConstraints() {
        self.nameLabel.snp.makeConstraints({ make in
            make.centerX.centerY.equalTo(self.contentView)
        })
    }
    
    func setupAdditionalConfiguration() {
        self.contentView.backgroundColor = UIColor(named: "palettePurple")
        self.contentView.layer.masksToBounds = true
        self.contentView.layer.cornerRadius = self.contentView.bounds.height / 2.0
    }
}
