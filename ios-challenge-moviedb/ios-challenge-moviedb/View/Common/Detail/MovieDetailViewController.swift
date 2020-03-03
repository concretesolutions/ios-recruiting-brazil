//
//  MovieDetailViewController.swift
//  ios-challenge-moviedb
//
//  Created by Giovanni Severo Barros on 24/02/20.
//  Copyright © 2020 Giovanni Severo Barros. All rights reserved.
//

import UIKit
import Kingfisher

class MovieDetailViewController: UIViewController {
    
    var presenter: MovieDetailPresenter?
    var movie: Movie
    
    var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .black
        return scrollView
    }()
    
    var movieImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8.0
        imageView.clipsToBounds = true
        return imageView
    }()
    
    var movieTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .white
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.backgroundColor = .clear
        return label
    }()
    
    var movieDetail: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .white
        label.font = .systemFont(ofSize: 18)
        label.textAlignment = .justified
        return label
    }()
    
    var movieReleaseDate: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .white
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        return label
    }()
    
    var movieGenre: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .white
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        return label
    }()
    
    var favoriteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: Constants.FavoriteButton.imageNamedNormal), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(handleFavorite(_:)), for: .touchUpInside)
        return button
    }()
    
    init(presenter: MovieDetailPresenter?, movie: Movie) {
        self.movie = movie
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        self.view.backgroundColor = .black
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupUI()
        loadDetail()
        applyGradient()
    }
    
    @objc func handleFavorite(_ sender: UIButton) {
        handleMovieFavorite(movie: self.movie)
        changeButtonImage(button: sender, movie: movie)
    }
    
    func applyGradient() {
        let myGradientLayer = CAGradientLayer()
        let colors: [CGColor] = [
          UIColor.clear.cgColor,
          UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor]
        myGradientLayer.colors = colors
        myGradientLayer.isOpaque = false
        myGradientLayer.locations = [0.8, 1.0]
        self.movieImage.layer.addSublayer(myGradientLayer)
        myGradientLayer.frame = CGRect(x: 0, y: 0, width: 780, height: 210)
    }
    
    func setupUI() {
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = "Detail"
        self.view.addSubview(scrollView)
        self.scrollView.addSubview(movieImage)
        self.scrollView.addSubview(movieTitle)
        self.scrollView.addSubview(movieGenre)
        self.scrollView.addSubview(movieReleaseDate)
        self.scrollView.addSubview(movieDetail)
        self.scrollView.addSubview(favoriteButton)
            
        setupConstaints()
    }
    
    func setupConstaints() {
        
        // MARK: - Scroll View Constraints
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        // MARK: - Movie Image Constraint
        movieImage.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10).isActive = true
        movieImage.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        movieImage.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width).isActive = true
        movieImage.heightAnchor.constraint(equalToConstant: 210).isActive = true
        
        
        // MARK: - Favorite Button Constraint
        favoriteButton.topAnchor.constraint(equalTo: movieImage.bottomAnchor, constant: -20).isActive = true
        favoriteButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        favoriteButton.widthAnchor.constraint(equalToConstant: 32).isActive = true
        favoriteButton.heightAnchor.constraint(equalToConstant: 31).isActive = true
        
        // MARK: - Movie Title
        movieTitle.topAnchor.constraint(equalTo: movieImage.bottomAnchor, constant: -20).isActive = true
        movieTitle.trailingAnchor.constraint(equalTo: favoriteButton.leadingAnchor, constant: -10).isActive = true
        movieTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        
        // MARK: - Movie Genre
        movieGenre.topAnchor.constraint(equalTo: movieTitle.bottomAnchor, constant: 15).isActive = true
        movieGenre.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        movieGenre.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        
        // MARK: - Release Date
        movieReleaseDate.topAnchor.constraint(equalTo: movieGenre.bottomAnchor, constant: 15).isActive = true
        movieReleaseDate.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        movieReleaseDate.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        
        // MARK: - Description
        movieDetail.topAnchor.constraint(equalTo: movieReleaseDate.bottomAnchor, constant: 15).isActive = true
        movieDetail.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        movieDetail.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        movieDetail.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -15).isActive = true
    }
    
    func loadDetail() {
        movieTitle.text = movie.title
        movieDetail.text = movie.overview
        movieReleaseDate.text = String(movie.releaseDate.prefix(4))
        changeButtonImage(button: favoriteButton, movie: movie)
        presenter?.getGenres(ids: movie.genreIds, completion: { [weak self] (genres) in
            guard let `self` = self else { return }
            if let genres = genres {
                let genreString = genres.joined(separator: ", ")
                self.movieGenre.text = genreString
            } else {
                self.movieGenre.text = ""
            }
        })
        
        let imageURL = presenter?.getMovieImageURL(width: 780, path: movie.backdropPath ?? "")
        movieImage.kf.setImage(with: imageURL) { [weak self] result in
            guard let `self` = self else { return }
            switch result {
            case .failure(let error): print("Não foi possivel carregar a imagem:", error.localizedDescription)
            self.movieImage.image = UIImage(named: Constants.ErrorValues.loadingImageError)
            default: break
                
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MovieDetailViewController: FavoriteMoviesProtocol {
    
    func handleMovieFavorite(movie: Movie) {
        presenter?.handleMovieFavoriteTap(movie: movie)
    }
    
    func changeButtonImage(button: UIButton, movie: Movie) {
        let isFavorite = presenter?.handleChangeButtonImage(movie: movie)
        
        if isFavorite == true {
            button.setImage(UIImage(named: Constants.FavoriteButton.imageNamedFull), for: .normal)
        } else {
            button.setImage(UIImage(named: Constants.FavoriteButton.imageNamedNormal), for: .normal)
        }
    }
}

extension MovieDetailViewController: MovieDetailViewDelegate {
    
}

