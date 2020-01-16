//
//  MovieDetailViewController.swift
//  ConcreteChallenge
//
//  Created by Kaique Damato on 11/1/20.
//  Copyright © 2020 KiQ. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    let movie: Movie
    let movieCollection: MovieColletion
    let genreCollection: GenreCollection
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.clipsToBounds = true
        stackView.spacing = 36
        stackView.alpha = 0
        
        return stackView
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(with: movie.posterURL)
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    lazy var blurView: UIView = {
        let blurView = UIView()
        
        blurView.translatesAutoresizingMaskIntoConstraints = false
        blurView.backgroundColor = .black
        blurView.alpha = 0.87
        
        return blurView
    }()
    
    lazy var anchorView: UIView = {
        let anchorView = UIView()
        
        anchorView.translatesAutoresizingMaskIntoConstraints = false
        anchorView.backgroundColor = .lightGray
        anchorView.layer.cornerRadius = 3
        anchorView.layer.cornerCurve = .continuous
        anchorView.alpha = 0.8
        
        return anchorView
    }()
    
    lazy var titleView: TitleView = {
        let titleView = TitleView(title: movie.title)
        
        titleView.translatesAutoresizingMaskIntoConstraints = false
        
        return titleView
    }()
    
    lazy var subtitleView: SubtitleView = {
        let subtitleView = SubtitleView(rating: movie.voteAverage, releaseDate: movie.releaseYear, genres: genreCollection.genres(for: movie.genreIDs))
        
        subtitleView.translatesAutoresizingMaskIntoConstraints = false
        
        return subtitleView
    }()
    
    lazy var bodyView: BodyView = {
        let bodyView = BodyView(text: movie.overview)
        
        bodyView.translatesAutoresizingMaskIntoConstraints = false
        
        return bodyView
    }()
    
    lazy var favoriteButton: UIButton = {
        let favoriteButton = UIButton(type: .custom)
        
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        favoriteButton.setImage(UIImage(named: Images.heartHollow)?.withRenderingMode(.alwaysTemplate), for: .normal)
        favoriteButton.setImage(UIImage(named: Images.heartFilled)?.withRenderingMode(.alwaysTemplate), for: .selected)
        favoriteButton.tintColor = .white
        favoriteButton.addTarget(self, action: #selector(addToFavorites), for: .touchUpInside)
        favoriteButton.isSelected = movie.isFavorite()
        
        return favoriteButton
    }()
    
    init(movie: Movie, movieCollection: MovieColletion, genreCollection: GenreCollection) {
        self.movie = movie
        self.movieCollection = movieCollection
        self.genreCollection = genreCollection
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        addSubviews()
        setupConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateStack()
    }
    
    func addSubviews() {
        view.addSubview(imageView)
        view.addSubview(blurView)
        view.addSubview(anchorView)
        view.addSubview(stackView)
        
        stackView.addArrangedSubview(titleView)
        stackView.addArrangedSubview(subtitleView)
        stackView.addArrangedSubview(bodyView)
        stackView.addArrangedSubview(favoriteButton)
    }
    
    func setupConstraints() {
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        blurView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        blurView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        blurView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        blurView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        anchorView.topAnchor.constraint(equalTo: view.topAnchor, constant: 14).isActive = true
        anchorView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        anchorView.heightAnchor.constraint(equalToConstant: 6).isActive = true
        anchorView.widthAnchor.constraint(equalToConstant: 38).isActive = true
        
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        stackBottomConstraint = stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 30)
        
        stackBottomConstraint?.isActive = true
    }
    
    var stackBottomConstraint: NSLayoutConstraint?
    
    func animateStack() {
        stackBottomConstraint?.constant = 0
        
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
            self.stackView.alpha = 1
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
}

extension MovieDetailViewController {
    
    @objc
    func addToFavorites() {
        movieCollection.updateState(for: movie)
        favoriteButton.isSelected = movie.isFavorite()
    }
}
