//
//  SearchView.swift
//  ListMovsFeature
//
//  Created by Marcos Felipe Souza on 03/03/20.
//  Copyright © 2020 Marcos Felipe Souza. All rights reserved.
//

import UIKit
import AssertModule

class EmptySearchView: UIView {

    let messageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont(name: "Avenir Next Bold", size: 85)
        label.text = "A busca por 'X' não resultou em nenhum resultado."
        label.textColor = Colors.blueDark
        label.textAlignment = .center
        return label
    }()
    
    let searchImageView: UIImageView = {
        let imageView = UIImageView()
        var image = Assets.Images.searchIcon?.withRenderingMode(.alwaysTemplate)
        imageView.image = image
        imageView.tintColor = Colors.blueDark
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
}

//MARK: - Lifecycle -
extension EmptySearchView {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.addSubview(searchImageView)
        self.addSubview(messageLabel)
        
        NSLayoutConstraint.activate([
            searchImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.25),
            searchImageView.widthAnchor.constraint(equalToConstant: 350),
            searchImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            searchImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -50),
            
            messageLabel.topAnchor.constraint(equalTo: self.searchImageView.bottomAnchor, constant: 14),
            messageLabel.leadingAnchor.constraint(equalTo: self.searchImageView.leadingAnchor),
            messageLabel.trailingAnchor.constraint(equalTo: self.searchImageView.trailingAnchor),
        ])
    }
}


