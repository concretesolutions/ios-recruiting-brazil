//
//  FavoriteView.swift
//  ConcreteChallenge
//
//  Created by Kaique Damato on 14/1/20.
//  Copyright © 2020 KiQ. All rights reserved.
//

import UIKit

class FavoriteView: UIView {
    lazy var favoriteButton: UIButton = {
        let favoriteButton = UIButton(type: .system)
        
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        favoriteButton.setImage(UIImage(named: "favorite"), for: .normal)
        favoriteButton.tintColor = .white
        
        return favoriteButton
    }()
    
    init() {
        super.init(frame: .zero)
        
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        self.addSubview(favoriteButton)
    }
    
    func setupConstraints() {
        favoriteButton.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        favoriteButton.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        favoriteButton.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
}
