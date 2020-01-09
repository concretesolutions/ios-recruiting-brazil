//
//  FavoritesView.swift
//  ConcreteRecruiting
//
//  Created by Alysson Moreira on 09/01/20.
//  Copyright © 2020 Alysson Moreira. All rights reserved.
//

import UIKit

class FavoritesView: UIView {

    lazy var removeFilterButton: UIButton = {
        let button = UIButton()
        
        button.setTitleColor(UIColor(named: "CellBlue"), for: .normal)
        button.tintColor = UIColor(named: "MainYellow")
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension FavoritesView {
    
    func addViews() {
        self.addSubviews([removeFilterButton])
    }
    
    func setupLayout() {
        
        addViews()
        
        NSLayoutConstraint.activate([
            removeFilterButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            removeFilterButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            removeFilterButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor)
        ])
        
    }
    
}
