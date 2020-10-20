//
//  CastViewCell.swift
//  Movs
//
//  Created by Joao Lucas on 19/10/20.
//

import UIKit

class CastViewCell: UICollectionViewCell {
    
    let photo: UIImageView = {
        var image = UIImageView()
        image.backgroundColor = .yellow
        return image
    }()
    
    let name: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupBaseView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CastViewCell: ViewCode {
    func buildViewHierarchy() {
        addSubview(photo)
        photo.addSubview(name)
    }
    
    func setupConstraints() {
        photo.layout.applyConstraint { view in
            view.topAnchor(equalTo: topAnchor)
            view.leadingAnchor(equalTo: leadingAnchor)
            view.trailingAnchor(equalTo: trailingAnchor)
            view.bottomAnchor(equalTo: bottomAnchor)
        }
        
        name.layout.applyConstraint { view in
            view.bottomAnchor(equalTo: bottomAnchor, constant: -8)
            view.leadingAnchor(equalTo: leadingAnchor, constant: 8)
            view.trailingAnchor(equalTo: trailingAnchor, constant: -8)
        }
    }
}
