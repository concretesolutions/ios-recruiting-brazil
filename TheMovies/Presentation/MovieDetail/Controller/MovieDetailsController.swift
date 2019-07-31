//
//  MovieDetailsController.swift
//  TheMovies
//
//  Created by Matheus Bispo on 7/28/19.
//  Copyright © 2019 Matheus Bispo. All rights reserved.
//

import UIKit
import RxSwift

final class MovieDetailsController: UIViewController {
    
    private var disposeBag = DisposeBag()
    private var presenter: MovieDetailsPresenterProtocol
    
    var id = 0
    
    private var detailsView = MovieDetailsView()
    
    init(presenter: MovieDetailsPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        
        setupPresenterStreams()
        
        setupViewStreams()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        self.view = detailsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.loadMovieDetail(id: self.id)
        
        setupNavigationBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        setNavigationBarToDefault()
    }
    
    /// Configura a navigation bar
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.tintColor = .white
        self.detailsView.setGradientBackground(colorTop: .clear, colorBottom: .white)
        self.navigationController?.navigationBar.barStyle = .black
    }
    
    
    /// Atribui o estado inicial para a navigation bar
    private func setNavigationBarToDefault() {
        self.navigationController?.navigationBar.barStyle = .default
        self.navigationController?.popViewController(animated: true)
    }
}

//MARK: - Configurações das Streams do presenter -
extension MovieDetailsController {
    func setupPresenterStreams() {
        presenter.loadMovieDetailStream.bind { [weak self] (moviesResult) in
            if let movie = moviesResult.first {
                self?.fillInfo(with: movie)
            }
        }.disposed(by: disposeBag)
        
        presenter.movieWasFavoritedStream.bind { [weak self] (movie) in
            self?.detailsView.favoriteButton.isSelected = movie.liked
        }.disposed(by: disposeBag)
    }
    
    private func fillInfo(with movie: Movie) {
        var genreNames = ""
        for genre in movie.genres {
            genreNames += genre.name + ", "
        }
        
        genreNames.removeLast()
        genreNames.removeLast()
        
        self.detailsView.title.text = movie.title
        self.detailsView.image.image = movie.image
        self.detailsView.year.text = String(movie.releaseDate.prefix(4))
        self.detailsView.genre.text = genreNames
        self.detailsView.overview.text = movie.overview
        self.detailsView.favoriteButton.isSelected = movie.liked
    }
}

//MARK: - Configurações das Streams da view -
extension MovieDetailsController {
    func setupViewStreams() {
        detailsView.favoriteButton.rx.tap.bind { [weak self] (_) in
            self?.favoriteMovie()
        }.disposed(by: disposeBag)
    }
    
    private func favoriteMovie() {
        self.presenter.favoriteMovieButtonWasTapped(id: self.id)
    }
}


