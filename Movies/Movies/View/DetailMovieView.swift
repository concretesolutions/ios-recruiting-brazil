//
//  DetailMovieView.swift
//  Movies
//
//  Created by Jonathan Martins on 18/09/18.
//  Copyright © 2018 Jonathan Martins. All rights reserved.
//

import UIKit

class DetailMovieView: UIView {
    
    // The movie's image
    let poster: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // The gradient view
    private let gradient: UIView = {
        let view = UIView()
        view.alpha = 0.7
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // The movie's name
    let movieName: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // The movie's release date
    let movieDate: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // The movie's genres
    let movieGenre: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 12, weight: .black)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // The movie's overview
    let movieOverview: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Adds the constraints to this view
    private func setupConstraints(){
        self.addSubview(poster)
        self.addSubview(gradient)
        self.addSubview(movieName)
        self.addSubview(movieDate)
        self.addSubview(movieGenre)
        self.addSubview(movieOverview)
        
        NSLayoutConstraint.activate([
            poster.topAnchor     .constraint(equalTo: self.topAnchor),
            poster.bottomAnchor  .constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            poster.leadingAnchor .constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            poster.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            
            gradient.topAnchor     .constraint(equalTo: self.topAnchor),
            gradient.bottomAnchor  .constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            gradient.leadingAnchor .constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            gradient.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            
            movieName.topAnchor     .constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            movieName.leadingAnchor .constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 5),
            movieName.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -5),
            
            movieDate.topAnchor     .constraint(equalTo: movieName.bottomAnchor),
            movieDate.leadingAnchor .constraint(equalTo: movieName.leadingAnchor),
            movieDate.trailingAnchor.constraint(equalTo: movieName.trailingAnchor),
            
            movieOverview.topAnchor     .constraint(equalTo: movieDate.bottomAnchor, constant: 10),
            movieOverview.leadingAnchor .constraint(equalTo: movieDate.leadingAnchor),
            movieOverview.trailingAnchor.constraint(equalTo: movieDate.trailingAnchor),
            
            movieGenre.topAnchor     .constraint(equalTo: movieOverview.bottomAnchor, constant: 5),
            movieGenre.leadingAnchor .constraint(equalTo: movieName.leadingAnchor),
            movieGenre.trailingAnchor.constraint(equalTo: movieName.trailingAnchor),
        ])
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .appColor
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
