//
//  PosterView.swift
//  ConcreteChallenge
//
//  Created by Kaique Damato on 10/1/20.
//  Copyright © 2020 KiQ. All rights reserved.
//

import UIKit
import Kingfisher

class PosterView: UIView {
    
    let imageURL: URL
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(with: imageURL)
        imageView.layer.cornerRadius = 20
        imageView.layer.cornerCurve = .continuous
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    lazy var gradientView: GradientView = {
        let gradientView = GradientView()
        
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        
        return gradientView
    }()
    
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return titleLabel
    }()
    
    lazy var favoriteButton: UIButton = {
        let favoriteButton = UIButton()
        
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        
        return favoriteButton
    }()
    
    init(title: String, imageURL: URL) {
        self.imageURL = imageURL
        super.init(frame: .zero)
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        self.addSubview(imageView)
        imageView.addSubview(gradientView)
        //        self.addSubview(titleLabel)
        //        self.addSubview(favoriteButton)
    }
    
    func setupConstraints() {
        imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        gradientView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor).isActive = true
        gradientView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor).isActive = true
        gradientView.topAnchor.constraint(equalTo: imageView.topAnchor).isActive = true
        gradientView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
    }
}
