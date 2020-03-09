//
//  BaseSearchView.swift
//  ListMovsFeature
//
//  Created by Marcos Felipe Souza on 04/03/20.
//  Copyright © 2020 Marcos Felipe Souza. All rights reserved.
//

import UIKit
import AssertModule

class BaseSearchView: UIView {

    
    let messageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont(name: "Avenir Next Bold", size: 85)
        label.textColor = Colors.blueDark
        label.textAlignment = .center
        return label
    }()
    
    let baseImageView: UIImageView = {
        let imageView = UIImageView()        
        imageView.tintColor = Colors.blueDark
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    func setMessageNotFound(_ message: String) {
        self.messageLabel.text = message
    }
}

//MARK: - Lifecycle -
extension BaseSearchView {
    override func layoutSubviews() {
        super.layoutSubviews()
         
        self.addSubview(baseImageView)
        self.addSubview(messageLabel)
        
        NSLayoutConstraint.activate([
            baseImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.25),
            baseImageView.widthAnchor.constraint(equalToConstant: 350),
            baseImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            baseImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -50),
            
            messageLabel.topAnchor.constraint(equalTo: self.baseImageView.bottomAnchor, constant: 14),
            messageLabel.leadingAnchor.constraint(equalTo: self.baseImageView.leadingAnchor),
            messageLabel.trailingAnchor.constraint(equalTo: self.baseImageView.trailingAnchor),
        ])
    }
}


