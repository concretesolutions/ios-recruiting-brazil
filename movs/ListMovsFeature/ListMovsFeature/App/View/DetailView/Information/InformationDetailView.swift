//
//  InformationDetailView.swift
//  ListMovsFeature
//
//  Created by Marcos Felipe Souza on 19/03/20.
//  Copyright © 2020 Marcos Felipe Souza. All rights reserved.
//

import UIKit
import AssertModule

class InformationDetailView: UIView {
    
    var detailLabel: UILabel = {
        let label = UILabel()
        label.font = FontAssets.avenirTextCell
        label.text = "A vida é uma caixa de surpresa"
        label.textColor = Colors.blueDark
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var favoriteImageView: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = Assets.Images.favoriteFullIcon
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    var lineView: UIView = {
        var line = UIView()
        line.backgroundColor = .red
        line.translatesAutoresizingMaskIntoConstraints = true
        return line
    }()

    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        self.backgroundColor = .white
        self.addSubview(self.detailLabel)
        self.addSubview(self.favoriteImageView)
        self.setupConstraints()
        
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            favoriteImageView.widthAnchor.constraint(equalToConstant: 20),
            favoriteImageView.heightAnchor.constraint(equalToConstant: 20),
            favoriteImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -4),
            favoriteImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 4),
            
            detailLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 4),
            detailLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            detailLabel.trailingAnchor.constraint(equalTo: favoriteImageView.leadingAnchor, constant: -4),
                        
            
//            lineView.leadingAnchor.constraint(equalTo: self.detailLabel.leadingAnchor),
//            lineView.topAnchor.constraint(equalTo: self.detailLabel.bottomAnchor, constant: 4),
//            lineView.trailingAnchor.constraint(equalTo: self.favoriteImageView.trailingAnchor),
//            lineView.heightAnchor.constraint(equalToConstant: 3)
        ])
    }
}
