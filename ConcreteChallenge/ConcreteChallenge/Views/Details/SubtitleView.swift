//
//  SubtitleView.swift
//  ConcreteChallenge
//
//  Created by Kaique Damato on 11/1/20.
//  Copyright © 2020 KiQ. All rights reserved.
//

import UIKit

class SubtitleView: UIView {
    
    let rating: Double
    let releaseDate: String
    let genres: [Genre]

    lazy var ratingLabel: UILabel = {
        let ratingLabel = UILabel()
        
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingLabel.text = "\(rating)"
        ratingLabel.backgroundColor = .white
        ratingLabel.font = UIFont.systemFont(ofSize: 26, weight: .bold)
        ratingLabel.textColor = .black
        ratingLabel.layer.cornerRadius = 7
        ratingLabel.layer.cornerCurve = .continuous
        ratingLabel.clipsToBounds = true
        ratingLabel.textAlignment = .center
        
        return ratingLabel
    }()
    
    lazy var yearLabel: UILabel = {
        let yearLabel = UILabel()
        
        yearLabel.translatesAutoresizingMaskIntoConstraints = false
        yearLabel.text = releaseDate
        yearLabel.font = UIFont.systemFont(ofSize: 18, weight: .light)
        yearLabel.textColor = .white
        
        
        return yearLabel
    }()
    
    lazy var genreLabel: UILabel = {
        let genreLabel = UILabel()
        
        genreLabel.translatesAutoresizingMaskIntoConstraints = false
        genreLabel.text = genres.description
        genreLabel.font = UIFont.systemFont(ofSize: 18, weight: .light)
        genreLabel.textColor = .white
//        genreLabel.adjustsFontSizeToFitWidth = true
//        genreLabel.numberOfLines = 0
        
        return genreLabel
    }()
    
    init(rating: Double, releaseDate: String, genres: [Genre]) {
        self.rating = rating
        self.releaseDate = releaseDate
        self.genres = genres
        super.init(frame: .zero)
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        self.addSubview(ratingLabel)
        self.addSubview(yearLabel)
        self.addSubview(genreLabel)
    }
    
    func setupConstraints() {
        ratingLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        ratingLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        ratingLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        ratingLabel.widthAnchor.constraint(equalToConstant: 48).isActive = true
        ratingLabel.heightAnchor.constraint(equalToConstant: 48).isActive = true
        
        yearLabel.leadingAnchor.constraint(equalTo: ratingLabel.trailingAnchor, constant: 18).isActive = true
        yearLabel.topAnchor.constraint(equalTo: ratingLabel.topAnchor).isActive = true
        
        genreLabel.leadingAnchor.constraint(equalTo: yearLabel.leadingAnchor).isActive = true
        genreLabel.bottomAnchor.constraint(equalTo: ratingLabel.bottomAnchor).isActive = true
        genreLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
}
