//
//  FavoriteMoviesController.swift
//  TheMovies
//
//  Created by Matheus Bispo on 7/29/19.
//  Copyright © 2019 Matheus Bispo. All rights reserved.
//

import UIKit
import RxSwift

final class FavoriteMoviesController: UIViewController, StreamControllerProtocol {
    
    //MARK: - Variables -
    private var disposeBag = DisposeBag()
    private var presenter: FavoriteMoviesPresenterProtocol
    
    //MARK: - Filter Variables -
    private var favorites = BehaviorSubject<[Movie]>(value: [])
    private var filteredFavorites = BehaviorSubject<[Movie]>(value: [])
    private var yearFilter = ""
    private var genreFilter = ""
    private var isSearching = false
    
    private var customView = FavoriteMoviesView()
    
    //MARK: - Constructor -
    init(presenter: FavoriteMoviesPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        
        setupNavigationBar()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Override Methods -
    override func loadView() {
        super.loadView()
        self.view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLocalStreams()
        setupPresenterStreams()
        setupViewStreams()
        
        presenter.loadFavoriteMovies()
        
        self.toggleDismissButton(false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.presenter.loadFavoriteMovies()
    }
    
    //MARK: - Methods -
    
    
    /// Configura a navigation bar
    private func setupNavigationBar() {
        self.navigationItem.title = "Favorites"
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "FilterIcon"),
                                                                 style: .plain,
                                                                 target: nil,
                                                                 action: nil)
        self.navigationItem.rightBarButtonItem?.tintColor = .black
        
        self.navigationItem.rightBarButtonItem?.rx.tap.bind(onNext: { [weak self] (_) in
            self?.goToFilterPage()
        }).disposed(by: disposeBag)
    }
    
    func goToFilterPage() {
        self.navigationController?.pushViewController(FavoriteMoviesFilterController(presenter: self.presenter), animated: true)
    }
    
    
    /// Troca o estado do dismiss button (Botão desfazer filtro)
    ///
    /// - Parameter value: valor correspondente ao estado
    private func toggleDismissButton(_ value: Bool) {
        if !value {
            self.customView.dismissFilterButton.setTitle("No Filters", for: .disabled)
            self.customView.dismissFilterButton.isEnabled = false
            self.customView.dismissFilterButton.backgroundColor = .lightGray
        } else {
            self.customView.dismissFilterButton.setTitle("Dismiss Filter: \(yearFilter) \(genreFilter)", for: .normal)
            self.customView.dismissFilterButton.isEnabled = true
            self.customView.dismissFilterButton.backgroundColor = .purple
        }
    }
}

//MARK: - Configurações das Streams do armazenamento local  -
extension FavoriteMoviesController {
    func setupLocalStreams() {
        filteredFavorites.bind(to: customView.tableView.rx.items(cellIdentifier: "FavoriteMoviesTableCell")) {
            [weak self] row, data, cell in
            
            let movieCell = cell as! FavoriteMoviesTableCell
            movieCell.photoImage.image = data.image
            movieCell.title.text = data.title
            movieCell.year.text = String(data.releaseDate.prefix(4))
            movieCell.overview.text = data.overview
            movieCell.id = data.id
            movieCell.favoriteButton.rx.tap.asDriver().drive(onNext: { (_) in
                self?.presenter.unfavoriteMovieButtonWasTapped(id: data.id)
            }).disposed(by: movieCell.disposeBag)
        }.disposed(by: disposeBag)
        
        favorites.bind { [weak self] (movies) in
            self?.setFeedbackView(movies: movies)
            self?.filteredFavorites.onNext(movies)
        }.disposed(by: disposeBag)
    }
    
    func setFeedbackView(movies: [Movie], error: Bool = false) {
        if error {
            self.customView.feedbackView.show(type: .errorOccurred)
            return
        }
        
        if movies.isEmpty && self.yearFilter == "" && self.genreFilter == "" && !self.isSearching {
            self.customView.feedbackView.show(type: .noFavoritesAdded)
        } else if movies.isEmpty {
            self.customView.feedbackView.show(type: .noFavoritesFounded)
        } else {
            self.customView.feedbackView.isHidden = true
        }
    }
}

//MARK: - Configurações das Streams do presenter -
extension FavoriteMoviesController {
    func setupPresenterStreams() {
        presenter.loadFavoriteMoviesStream.subscribe(onNext: {
            [weak self] movies in
            self?.favoriteMoviesWasLoaded(movies: movies)
        }, onError: { [weak self]  _ in
            self?.setFeedbackView(movies: [], error: true)
        }).disposed(by: disposeBag)
        
        presenter.movieUnfavoritedStream.subscribe(onNext: { [weak self] (movie) in
            self?.presenter.loadFavoriteMovies()
        }, onError: { [weak self]  _ in
                self?.setFeedbackView(movies: [], error: true)
        }).disposed(by: disposeBag)
        
        presenter.setFilterStream.subscribe(onNext: { [weak self] (value) in
            let date = value.0
            let genre = value.1
            
            self?.yearFilter = date
            self?.genreFilter = genre
            
            self?.presenter.loadFavoriteMovies()
        }, onError: { [weak self]  _ in
                self?.setFeedbackView(movies: [], error: true)
        }).disposed(by: disposeBag)
    }
    
    func favoriteMoviesWasLoaded(movies: [Movie]) {
        var moviesAux = [Movie]()
        if !self.yearFilter.isEmpty || !self.genreFilter.isEmpty {
            self.toggleDismissButton(true)
            for movie in movies {
                if movie.releaseDate.contains(self.yearFilter) ||
                    movie.genres.map({ (genre) -> String in return genre.name })
                        .contains(self.genreFilter) {
                    moviesAux.append(movie)
                }
            }
            
            self.favorites.onNext(moviesAux)
        } else {
            self.toggleDismissButton(false)
            self.favorites.onNext(movies)
        }
    }
}

//MARK: - Configurações das Streams da view
extension FavoriteMoviesController {
    func setupViewStreams() {
        self.customView.dismissFilterButton.rx.tap.bind { [weak self] (_) in
            self?.yearFilter = ""
            self?.genreFilter = ""
            
            self?.presenter.loadFavoriteMovies()
        }.disposed(by: disposeBag)
        
        setupSearchBarStreams()
    }
}

//MARK: - Configurações das Streams da search bar
extension FavoriteMoviesController {
    func setupSearchBarStreams() {
        self.customView.searchBar.rx.text.orEmpty.bind { [weak self] (searchString) in
            var filteredMoviesAux = [Movie]()
            guard let favorites = try? self?.favorites.value() else {
                return
            }
            
            for favorite in favorites {
                if favorite.title.lowercased().contains(searchString.lowercased()) {
                    filteredMoviesAux.append(favorite)
                }
            }
            
            self?.filteredFavorites.onNext(filteredMoviesAux)
        }.disposed(by: disposeBag)
        
        self.customView.searchBar.rx.textDidBeginEditing.bind { [weak self] (_) in
            self?.customView.searchBar.showsCancelButton = true
            self?.isSearching = true
        }.disposed(by: disposeBag)
        
        self.customView.searchBar.rx.cancelButtonClicked.bind { [weak self] (_) in
            self?.customView.searchBar.endEditing(true)
            self?.customView.searchBar.showsCancelButton = false
            self?.customView.searchBar.text = ""
            self?.isSearching = false
            self?.presenter.loadFavoriteMovies()
        }.disposed(by: disposeBag)
        
        self.customView.searchBar.rx.searchButtonClicked.bind { [weak self] (_) in
            self?.customView.searchBar.endEditing(true)
            if let cancelButton = self?.customView.searchBar.value(forKey: "cancelButton") as? UIButton {
                cancelButton.isEnabled = true
            }
        }.disposed(by: disposeBag)
    }
}
