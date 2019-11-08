//
//  DetailViewController.swift
//  MovieApp
//
//  Created by Giuliano Accorsi on 07/11/19.
//  Copyright © 2019 Giuliano Accorsi. All rights reserved.
//

import UIKit
import SDWebImage

class DetailViewController: UIViewController {
    
    var movie: Movie?
    var movieSave: MovieSave?
    var controller: DetailController?
    var genre: String?
    
    let viewBackground: StyleView = {
        let view = StyleView(frame: .zero)
        view.layer.cornerRadius = 20
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.borderColor = .clear
        view.shadowRadius = 7
        view.shadowOpacity = 46
        return view
    }()
    
    let imageMovie: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        return image
    }()
    let titleLabel: UILabel = {
        let title = UILabel(frame: .zero)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.numberOfLines = 2
        title.textColor = .black
        title.font = UIFont.boldSystemFont(ofSize: 24)
        return title
    }()
    
    let sinopseLabel: UILabel = {
        let title = UILabel(frame: .zero)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.numberOfLines = 1
        title.textColor = .darkGray
        title.font = UIFont(name: "Futura", size: 20)
        title.text = "Sinopse"
        return title
    }()
    
    
    let genresLabel: UILabel = {
        let title = UILabel(frame: .zero)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.numberOfLines = 0
        title.textColor = .orange
        title.font = UIFont(name: "Futura", size: 15)
        return title
    }()
    
    
    let releaseDateLabel: UILabel = {
        let title = UILabel(frame: .zero)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.numberOfLines = 1
        title.textColor = .darkGray
        title.font = UIFont(name: "Futura", size: 15)
        title.text = "Release: "
        return title
    }()
    
    let movieDateRelease: UILabel = {
        let title = UILabel(frame: .zero)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.numberOfLines = 1
        title.textColor = .darkGray
        title.font = UIFont(name: "Futura", size: 15)
        return title
    }()
    
    let favoriteButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "icons8-like"), for: .normal)
        button.setImage(#imageLiteral(resourceName: "icons8-like_filled"), for: .selected)
        return button
    }()
    
    let textView: UITextView = {
        let text = UITextView(frame: .zero)
        text.translatesAutoresizingMaskIntoConstraints = false
        text.allowsEditingTextAttributes = false
        text.backgroundColor = .white
        text.font = UIFont(name: "Futura", size: 18)
        text.textColor = .darkGray

        return text
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.controller = DetailController()
        favoriteButton.addTarget(self, action: #selector(saveMovie), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: favoriteButton)
        setupUI()
        setupMovie()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let movieSelected = movie, let detailController = controller {
            favoriteButton.isSelected = detailController.isFavorite(movie: movieSelected)
        }
    }
    
    @objc func saveMovie() {
        if let movieSelected = movie, let detailController = controller {
            detailController.saveMovie(movie: movieSelected)
            favoriteButton.isSelected = detailController.isFavorite(movie: movieSelected)
        }else if let movieSelectedSave = movieSave {
            controller?.saveMovieCoreData(movie: movieSelectedSave)
            favoriteButton.isSelected = controller?.isFavoriteMovieSave(movie: movieSelectedSave) ?? false
        }
    }
    
    func setupMovie() {
        if let movieSelect = movie {
            self.titleLabel.text = movieSelect.title
            let url = API.imageURL + (movieSelect.backdropPath ?? "")
            guard let urlTeste: URL = URL(string: url) else {return}
            self.imageMovie.sd_setImage(with: urlTeste, completed: nil)
            self.textView.text = movieSelect.overview
            self.movieDateRelease.text = controller?.dataFormatter(movie: movieSelect, movieSave: nil)
            self.genresLabel.text = controller?.getGenre(movie: movie)
        }
        
        if let movieSelect = movieSave {
            self.titleLabel.text = movieSelect.title
            let url = API.imageURL + (movieSelect.imageURL ?? "")
            guard let urlTeste: URL = URL(string: url) else {return}
            self.imageMovie.sd_setImage(with: urlTeste, completed: nil)
            self.textView.text = movieSelect.overview
            self.movieDateRelease.text = controller?.dataFormatter(movie: nil, movieSave: movieSelect)
            self.genresLabel.text = movieSelect.genres
            self.favoriteButton.isSelected = controller?.isFavoriteMovieSave(movie: movieSelect) ?? false
        }

        
    }
    
    func setupUI() {
        // MARK: - Screen
        
        self.view.backgroundColor = UIColor(red: 0.951, green: 0.949, blue: 0.968, alpha: 1.0)
        
        
        self.view.addSubview(imageMovie)
        self.view.addSubview(viewBackground)
        
        self.viewBackground.addSubview(titleLabel)
        self.viewBackground.addSubview(genresLabel)
        self.viewBackground.addSubview(sinopseLabel)
        self.viewBackground.addSubview(releaseDateLabel)
        self.viewBackground.addSubview(movieDateRelease)
        self.viewBackground.addSubview(textView)
        
        
        
        imageMovie.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.4).isActive = true
        imageMovie.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        imageMovie.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        imageMovie.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        
        viewBackground.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        viewBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        viewBackground.topAnchor.constraint(equalTo: imageMovie.bottomAnchor, constant: -70).isActive = true
        viewBackground.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: viewBackground.topAnchor, constant: 16).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: viewBackground.leadingAnchor, constant: 16).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: viewBackground.trailingAnchor, constant: -16).isActive = true
        
        genresLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8).isActive = true
        genresLabel.leadingAnchor.constraint(equalTo: viewBackground.leadingAnchor, constant: 16).isActive = true
        genresLabel.trailingAnchor.constraint(equalTo: viewBackground.trailingAnchor, constant: -16).isActive = true
        
        releaseDateLabel.topAnchor.constraint(equalTo: genresLabel.bottomAnchor, constant: 8).isActive = true
        releaseDateLabel.leadingAnchor.constraint(equalTo: viewBackground.leadingAnchor, constant: 16).isActive = true
        releaseDateLabel.sizeToFit()
        
        movieDateRelease.leadingAnchor.constraint(equalTo: releaseDateLabel.trailingAnchor, constant: 8).isActive = true
        movieDateRelease.trailingAnchor.constraint(equalTo: viewBackground.trailingAnchor, constant: -8).isActive = true
        movieDateRelease.centerYAnchor.constraint(equalTo: releaseDateLabel.centerYAnchor).isActive = true
        movieDateRelease.heightAnchor.constraint(equalTo: releaseDateLabel.heightAnchor).isActive = true
        
        sinopseLabel.topAnchor.constraint(equalTo: releaseDateLabel.bottomAnchor, constant: 8).isActive = true
        sinopseLabel.leadingAnchor.constraint(equalTo: viewBackground.leadingAnchor, constant: 16).isActive = true
        sinopseLabel.trailingAnchor.constraint(equalTo: viewBackground.trailingAnchor, constant: -16).isActive = true
        
        textView.topAnchor.constraint(equalTo: sinopseLabel.bottomAnchor, constant: 8).isActive = true
        textView.leadingAnchor.constraint(equalTo: viewBackground.leadingAnchor, constant: 16).isActive = true
        textView.trailingAnchor.constraint(equalTo: viewBackground.trailingAnchor, constant: -16).isActive = true
        textView.bottomAnchor.constraint(equalTo: viewBackground.bottomAnchor, constant: -16).isActive = true

    }
    
}

