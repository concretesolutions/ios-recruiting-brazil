//
//  MovieDetailViewController.swift
//  MyMoviesCollection
//
//  Created by Filipe Merli on 13/03/20.
//  Copyright © 2020 Filipe Merli. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController, Alerts {
    
    // MARK: - Properties
    
    private lazy var imageView: UIImageView = {
        let poster = UIImageView()
        poster.translatesAutoresizingMaskIntoConstraints = false
        poster.contentMode = .scaleAspectFit
        return poster
    }()
    
    
    private lazy var infosView: UIView = {
        let infos = UIView()
        infos.translatesAutoresizingMaskIntoConstraints = false
        return infos
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var yearLabel: UILabel = {
        let year = UILabel()
        year.translatesAutoresizingMaskIntoConstraints = false
        return year
    }()
    
    private lazy var overview: UITextView = {
        let descrp = UITextView()
        descrp.translatesAutoresizingMaskIntoConstraints = false
        descrp.isEditable = false
        return descrp
    }()
    
    private lazy var genres: UILabel = {
        let gen = UILabel()
        gen.translatesAutoresizingMaskIntoConstraints = false
        return gen
    }()
    
    private lazy var favButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        let iconNormal = #imageLiteral(resourceName: "favorite_empty_icon")
        btn.setImage(iconNormal, for: .normal)
        let iconSelected = #imageLiteral(resourceName: "favorite_full_icon")
        btn.setImage(iconSelected, for: .selected)
        btn.imageView?.contentMode = .scaleAspectFit
        return btn
    }()
    
    private lazy var loadingIndicator: UIActivityIndicatorView = {
        let ind = UIActivityIndicatorView()
        ind.translatesAutoresizingMaskIntoConstraints = false
        ind.style = .medium
        ind.hidesWhenStopped = true
        return ind
    }()
    
    private var viewModel: MovieDetailViewModel?
    public var movieToPresent: Movie?
    private var isFavorite: Bool = false

    // MARK: - ViewController life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setMovieDetails()
        viewModel = MovieDetailViewModel(delegate: self)
        viewModel?.fetchMovieDetail()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setUpFavButton()
    }
    
    override func viewDidLayoutSubviews() {
        setUpBorders()
    }
    
    // MARK: - Class Functions
    
    private func setUpView() {
        self.view.backgroundColor = .white
        view.addSubview(imageView)
        view.addSubview(infosView)
        infosView.addSubview(titleLabel)
        infosView.addSubview(yearLabel)
        infosView.addSubview(genres)
        infosView.addSubview(overview)
        infosView.addSubview(favButton)
        imageView.addSubview(loadingIndicator)
        
        imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        imageView.bottomAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        
        infosView.topAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        infosView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        infosView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        infosView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: infosView.topAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: infosView.trailingAnchor, constant: -45).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: infosView.leadingAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        yearLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        yearLabel.trailingAnchor.constraint(equalTo: infosView.trailingAnchor).isActive = true
        yearLabel.leadingAnchor.constraint(equalTo: infosView.leadingAnchor).isActive = true
        yearLabel.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        genres.topAnchor.constraint(equalTo: yearLabel.bottomAnchor).isActive = true
        genres.trailingAnchor.constraint(equalTo: infosView.trailingAnchor).isActive = true
        genres.leadingAnchor.constraint(equalTo: infosView.leadingAnchor).isActive = true
        genres.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        overview.topAnchor.constraint(equalTo: genres.bottomAnchor).isActive = true
        overview.trailingAnchor.constraint(equalTo: infosView.trailingAnchor).isActive = true
        overview.leadingAnchor.constraint(equalTo: infosView.leadingAnchor).isActive = true
        overview.bottomAnchor.constraint(equalTo: infosView.bottomAnchor).isActive = true
        
        favButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor).isActive = true
        favButton.trailingAnchor.constraint(equalTo: infosView.trailingAnchor).isActive = true
        favButton.widthAnchor.constraint(equalToConstant: 45).isActive = true
        favButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        loadingIndicator.centerYAnchor.constraint(equalTo: imageView.centerYAnchor).isActive = true
        loadingIndicator.centerXAnchor.constraint(equalTo: imageView.centerXAnchor).isActive = true
        
    }
    
    private func setUpFavButton() {
        favButton.addTarget(self, action: #selector(favoriteMovie), for: .touchUpInside)
        favButton.isEnabled = false
        checkIfFavorite()
    }
    
    private func checkIfFavorite() {
        guard let idFavorite = movieToPresent?.id else {
            return
        }
        viewModel?.checkIfFavorite(id: idFavorite, completion: { result in
            if result {
                self.isFavorite = true
            } else {
                self.isFavorite = false
            }
            self.updateFavButtonFeedback()
        })
    }
    
    private func updateFavButtonFeedback() {
        DispatchQueue.main.async {
            self.favButton.isSelected = self.isFavorite
            self.favButton.isEnabled = true
        }
    }
    
    private func setUpBorders() {
        titleLabel.layer.addBottomBorders()
        yearLabel.layer.addBottomBorders()
        favButton.layer.addBottomBorders()
        genres.layer.addBottomBorders()
    }
    
    private func setMovieDetails() {
        guard let movieUrl = movieToPresent?.posterUrl else { return }
        LoadImageWithCache.shared.downloadMovieAPIImage(posterUrl: movieUrl, completion: { result in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    self.loadingIndicator.stopAnimating()
                }
                debugPrint("Erro ao baixar imagem: \(error.reason)")
            case .success(let response):
                DispatchQueue.main.async {
                    self.loadingIndicator.stopAnimating()
                    self.imageView.image = response.banner
                }
            }
        })
        DispatchQueue.main.async {
            self.yearLabel.text = self.movieToPresent?.releaseDate
            self.overview.text = self.movieToPresent?.overview
            self.titleLabel.text = self.movieToPresent?.title
        }
    }
    
    @objc func favoriteMovie(sender: UIButton!) {
        if !isFavorite {
            guard let movie = movieToPresent else {
                return
            }
            viewModel?.favoriteMovie(movie: movie, completion: { (success) in
                self.isFavorite = true
                self.favButton.isSelected = true
            })
        }
    }
    
}

// MARK: - MovieDetailViewModelDelegate

extension MovieDetailViewController: MovieDetailViewModelDelegate {
    func fetchGenresCompleted() {
        guard let movieGens = movieToPresent?.generedIds else { return }
        DispatchQueue.main.async {
            self.genres.text = self.viewModel?.findGens(genIds: movieGens)
            self.loadingIndicator.stopAnimating()
        }
    }
    
    func fetchGenresFailed(with reason: String) {
        DispatchQueue.main.async {
            self.loadingIndicator.stopAnimating()
        }
        let action = UIAlertAction(title: "OK", style: .default)
        displayAlert(with: "Alerta" , message: reason, actions: [action])
    }
}
