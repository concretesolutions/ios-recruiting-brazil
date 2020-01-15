//
//  FavMovieTableViewCell.swift
//  ConcreteChallenge
//
//  Created by Kaique Damato on 15/1/20.
//  Copyright © 2020 KiQ. All rights reserved.
//

import UIKit

class FavMovieTableViewCell: UITableViewCell {

   private var posterView: PosterView? {
        didSet {
            setupPoster()
        }
    }
    
    lazy var ratingLabel: UILabel = {
        let ratingLabel = UILabel()
        
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingLabel.backgroundColor = .black
        ratingLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        ratingLabel.textColor = .white
        ratingLabel.layer.cornerRadius = 7
        ratingLabel.layer.cornerCurve = .continuous
        ratingLabel.clipsToBounds = true
        ratingLabel.textAlignment = .center
        
        return ratingLabel
    }()
    
    lazy var overviewLabel: UILabel = {
        let overviewLabel = UILabel()
        
        overviewLabel.translatesAutoresizingMaskIntoConstraints = false
        overviewLabel.numberOfLines = 0
        overviewLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        overviewLabel.textAlignment = .justified
        
        return overviewLabel
    }()
    
    override func prepareForReuse() {
        posterView?.removeFromSuperview()
        ratingLabel.removeFromSuperview()
        overviewLabel.removeFromSuperview()
        posterView = nil
    }
    
    func setup(for movie: Movie) {
        posterView = PosterView(for: movie)
        
        ratingLabel.text = "\(movie.voteAverage)"
        overviewLabel.text = movie.overview
        
        addSubviews()
        setupConstraints()
    }
    
    private func addSubviews() {
        guard let posterView = self.posterView else { return }
        
        contentView.addSubview(posterView)
        contentView.addSubview(ratingLabel)
        contentView.addSubview(overviewLabel)
    }
    
    private func setupConstraints() {
        guard let posterView = self.posterView else { return }
        
        posterView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
        posterView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        posterView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).isActive = true
        posterView.widthAnchor.constraint(equalTo: posterView.heightAnchor, multiplier: 0.65, constant: 0).isActive = true
        
        ratingLabel.leadingAnchor.constraint(equalTo: posterView.trailingAnchor, constant: 8).isActive = true
        ratingLabel.topAnchor.constraint(equalTo: posterView.topAnchor).isActive = true
        ratingLabel.widthAnchor.constraint(equalToConstant: 42).isActive = true
        ratingLabel.heightAnchor.constraint(equalToConstant: 42).isActive = true
        
        overviewLabel.topAnchor.constraint(equalTo: ratingLabel.bottomAnchor, constant: 8).isActive = true
        overviewLabel.leadingAnchor.constraint(equalTo: ratingLabel.leadingAnchor).isActive = true
        overviewLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        overviewLabel.bottomAnchor.constraint(lessThanOrEqualTo: posterView.bottomAnchor).isActive = true
    }
    
    private func setupPoster() {
        guard let posterView = self.posterView else { return }
        
        posterView.translatesAutoresizingMaskIntoConstraints = false
        
        posterView.layer.shadowColor = UIColor.black.cgColor
        posterView.layer.shadowOpacity = 0.8
        posterView.layer.shadowOffset = .zero
        posterView.layer.shadowRadius = 3
        posterView.layer.shouldRasterize = true
        posterView.layer.rasterizationScale = UIScreen.main.scale
    }

}
