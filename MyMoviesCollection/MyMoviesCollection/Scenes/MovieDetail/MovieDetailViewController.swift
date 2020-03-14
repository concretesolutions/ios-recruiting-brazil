//
//  MovieDetailViewController.swift
//  MyMoviesCollection
//
//  Created by Filipe Merli on 13/03/20.
//  Copyright © 2020 Filipe Merli. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController, Alerts {
    
    private lazy var imageView: UIImageView = {
        let poster = UIImageView()
        poster.translatesAutoresizingMaskIntoConstraints = false
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
    
    private lazy var overview: UILabel = {
        let descrp = UILabel()
        descrp.translatesAutoresizingMaskIntoConstraints = false
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
        let icon = #imageLiteral(resourceName: "favorite_empty_icon")
        btn.setImage(icon, for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        return btn
    }()
    
    private var viewModel: MovieDetailViewModel?
    public var movieToPresent: Movie?

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = MovieDetailViewModel(delegate: self)
        viewModel?.fetchMovieDetail()
        setUpView()
        setMovieDetails()
    }
    
    private func setUpView() {
        view.addSubview(imageView)
        view.addSubview(infosView)
        infosView.addSubview(titleLabel)
        infosView.addSubview(yearLabel)
        infosView.addSubview(genres)
        infosView.addSubview(overview)
        titleLabel.addSubview(favButton)
        
        imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        imageView.bottomAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        
        infosView.topAnchor.constraint(equalTo: view.centerYAnchor, constant: 1).isActive = true
        infosView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        infosView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        infosView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: infosView.topAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: infosView.trailingAnchor).isActive = true
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
        favButton.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: -5).isActive = true
        favButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        favButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
    }
    
    private func setMovieDetails() {
        guard let movieUrl = movieToPresent?.posterUrl else { return }
        LoadImageWithCache.shared.downloadMovieAPIImage(posterUrl: movieUrl, imageView: imageView, completion: { result in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    //self.activityIndicator.stopAnimating()
                }
                debugPrint("Erro ao baixar imagem: \(error.reason)")
            case .success(let response):
                DispatchQueue.main.async {
                    //self.activityIndicator.stopAnimating()
                    self.imageView.image = response.banner
                }
            }
        })
        DispatchQueue.main.async {
            self.yearLabel.text = self.movieToPresent?.releaseDate
            self.overview.text = self.movieToPresent?.overview
        }
    }
    
    private func setGenresInfo() {
    }
    
}

// MARK: - MovieDetailViewModelDelegate

extension MovieDetailViewController: MovieDetailViewModelDelegate {
    func onFetchCompleted() {
        DispatchQueue.main.async {
            //self.loadingIndicator.stopAnimating()
            //self.collectionView.reloadData()
        }
    }
    
    func onFetchFailed(with reason: String) {
        DispatchQueue.main.async {
            //self.loadingIndicator.stopAnimating()
        }
        let title = "Alerta"
        let action = UIAlertAction(title: "OK", style: .default)
        displayAlert(with: title , message: reason, actions: [action])
    }
}
