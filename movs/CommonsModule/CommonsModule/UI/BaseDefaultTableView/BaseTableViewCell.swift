//
//  BaseTableViewCell.swift
//  CommonsModule
//
//  Created by Marcos Felipe Souza on 18/03/20.
//  Copyright © 2020 Marcos Felipe Souza. All rights reserved.
//

import UIKit

open class BaseTableViewCell: UITableViewCell {
    
    
    var detailLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    var imageDetailImageView: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    public var informationCell: (detail: String?, image: UIImage?)? {
        didSet {
            self.fillUpUI()
        }
    }
    
    open override func didMoveToSuperview() {
        
        self.addSubview(self.detailLabel)
        self.addSubview(self.imageDetailImageView)
        
        self.setupConstraints()
    }
}

extension BaseTableViewCell {
    private func setupConstraints() {
        NSLayoutConstraint.activate([            
            self.imageDetailImageView.heightAnchor.constraint(equalToConstant: 10),
            self.imageDetailImageView.widthAnchor.constraint(equalToConstant: 10),
            self.imageDetailImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -3),
            self.imageDetailImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    private func fillUpUI() {
        if let informationCell = self.informationCell {
            self.detailLabel.text = informationCell.detail
            self.imageView?.image = informationCell.image
        }
    }
}
