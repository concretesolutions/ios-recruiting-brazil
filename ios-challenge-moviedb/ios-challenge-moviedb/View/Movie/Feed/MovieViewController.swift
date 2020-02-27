//
//  MovieCollectionViewController.swift
//  ios-challenge-moviedb
//
//  Created by Giovanni Severo Barros on 22/02/20.
//  Copyright © 2020 Giovanni Severo Barros. All rights reserved.
//

import UIKit
import Kingfisher

class MovieViewController: UIViewController {
    
    var presenter: MoviePresenter?
    
    private var estimatedCellWidth: CGFloat = Constants.MovieCollectionView.estimatedCellWidth
    private var cellMargin: CGFloat = Constants.MovieCollectionView.cellMargin
    
    var movieCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: Constants.MovieCollectionView.cellMargin,
                                           left: 7,
                                           bottom: Constants.MovieCollectionView.cellMargin,
                                           right: 7)
        layout.minimumLineSpacing = Constants.MovieCollectionView.cellMargin
        layout.minimumInteritemSpacing = Constants.MovieCollectionView.cellMargin
        layout.estimatedItemSize = CGSize(width: Constants.MovieCollectionView.estimatedCellWidth,
                                          height: Constants.MovieCollectionView.estimatedCellHeight + 30)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: Constants.MovieCollectionView.cellId)
        collectionView.backgroundColor = .black
        
        return collectionView
    }()
    
    init(presenter: MoviePresenter) {
        super.init(nibName: nil, bundle: nil)
        self.presenter = presenter
        self.navigationItem.title = "Movies"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // MARK: - Loads Movies Data
        DispatchQueue.main.async { [weak self] in
            guard let `self` = self else { return }
            self.presenter?.loadCollectionView(page: 1)
         }
        setupUI()
    }
    
    override func viewDidLoad() {
        movieCollectionView.dataSource = self
        movieCollectionView.delegate = self
    }
    
    @objc func handleFavorite(_ sender: UIButton) {
        var cellMovie: Movie?
        guard let movies = presenter?.movies else { return }
        for movie in movies {
            if movie.id == sender.tag {
                cellMovie = movie
            }
        }
        guard let movie = cellMovie else { return }
        presenter?.handleMovieFavorite(movie: movie)
        presenter?.changeButtonImage(button: sender, movie: movie)
     }
    
    func setupUI() {
        self.view.addSubview(movieCollectionView)
        setupConstaints()
    }
    
    func setupConstaints() {
        // MARK: - Collection View Constraints
        movieCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        movieCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        movieCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        movieCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
}

extension MovieViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.numberOfMovies ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.MovieCollectionView.cellId, for: indexPath) as? MovieCollectionViewCell else {
            fatalError("Wrong Cell ID")
        }
        
        if let movies = presenter?.movies {
            cell.movieImage.kf.indicatorType = .activity
            let movie = movies[indexPath.item]
            cell.movieTitle.text = movie.title
            presenter?.changeButtonImage(button: cell.favoriteButton, movie: movie)
            cell.favoriteButton.tag = movie.id
            cell.favoriteButton.addTarget(self, action: #selector(handleFavorite(_:)), for: .touchUpInside)
            let moviePosterImageURL = presenter?.getMovieImageURL(width: 200, path: movie.posterPath)
            cell.movieImage.kf.setImage(with: moviePosterImageURL) { result in
                switch result {
                case .failure(let error): print("Não foi possivel carregar a imagem:", error.localizedDescription)
                    // Tratar o error
                default: break
                    
                }
            }
        } else {
            // Tratar o erro
        }
        return cell
    }
}

extension MovieViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.showMovieDetails(movie: indexPath.item)
    }
}

extension MovieViewController: MovieViewDelegate {
    func reloadData() {
        DispatchQueue.main.async { [weak self] in
            guard let `self` = self else { return }
            self.movieCollectionView.reloadData()
        }
    }
}

