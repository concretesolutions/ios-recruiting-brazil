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
    
    let movie: Movie
    let notificationCenter = NotificationCenter.default
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(with: movie.posterURL)
        imageView.layer.cornerRadius = 5
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
        titleLabel.text = movie.title
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 12, weight: .heavy)
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.numberOfLines = 2
        
        return titleLabel
    }()
    
    lazy var subtitleLabel: UILabel = {
        let subtitleLabel = UILabel()
        
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.text = movie.releaseDate
        subtitleLabel.textColor = .white
        subtitleLabel.font = UIFont.systemFont(ofSize: 10, weight: .light)
        
        return subtitleLabel
    }()
    
    lazy var triangleView: UIView = {
        let triangleView = TriangleView()
        
        triangleView.translatesAutoresizingMaskIntoConstraints = false
        triangleView.layer.shadowColor = UIColor.black.cgColor
        triangleView.layer.shadowOpacity = 0.8
        triangleView.layer.shadowOffset = .zero
        triangleView.layer.shadowRadius = 3
        triangleView.isHidden = !movie.isFavorite()
        
        return triangleView
    }()
    
    init(for movie: Movie) {
        self.movie = movie
        super.init(frame: .zero)
        
        addSubviews()
        setupConstraints()
        
        notificationCenter.addObserver(self, selector: #selector(updateFavoriteMovies), name: Notification.Name("NewFavoriteMovie"), object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    func updateFavoriteMovies() {
        triangleView.isHidden = !movie.isFavorite()
    }
    
    func addSubviews() {
        self.addSubview(imageView)
        imageView.addSubview(gradientView)
        self.addSubview(titleLabel)
        self.addSubview(subtitleLabel)
        gradientView.addSubview(triangleView)
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
        
        titleLabel.leadingAnchor.constraint(equalTo: subtitleLabel.leadingAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: subtitleLabel.topAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: subtitleLabel.trailingAnchor).isActive = true
        
        subtitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5).isActive = true
        subtitleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
        subtitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5).isActive = true
        
        triangleView.leadingAnchor.constraint(equalTo: gradientView.leadingAnchor).isActive = true
        triangleView.topAnchor.constraint(equalTo: gradientView.topAnchor).isActive = true
        triangleView.widthAnchor.constraint(equalTo: gradientView.widthAnchor, multiplier: 0.3).isActive = true
        triangleView.heightAnchor.constraint(equalTo: triangleView.widthAnchor).isActive = true
    }
}
