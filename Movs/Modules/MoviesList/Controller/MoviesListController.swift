//
//  MoviesListController.swift
//  Movs
//
//  Created by Joao Lucas on 08/10/20.
//

import UIKit
import RealmSwift

class MoviesListController: UICollectionViewController {

    private let searchController = UISearchController(searchResultsController: nil)
    private var moviesList = [ResultMoviesDTO]()
    
    private var viewModel: MoviesListViewModel!
    
    private var filteredMovies = [ResultMoviesDTO]()
    private var inSearchMode = false
    private var searchBar: UISearchBar!
    
    private let realm = try! Realm()
        
    private var itemsFavorites = [FavoriteEntity]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        setupSearchBar()
        setupViewModel()
        setupFetchMovies()
        setupStates()
        setupFetchGenres()
    }
    
    private func setupCollectionView() {
        self.collectionView!.register(MoviesListCell.self, forCellWithReuseIdentifier: "moviesList")
        self.collectionView.backgroundColor = .white
    }
    
    private func setupSearchBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(showSearchBar))
                    
        navigationItem.rightBarButtonItem?.tintColor = .systemBlue
    }
    
    @objc func showSearchBar() {
        configureSearchBar()
    }
        
    private func configureSearchBar() {
        searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.sizeToFit()
        searchBar.showsCancelButton = true
        searchBar.becomeFirstResponder()
        searchBar.tintColor = .black
                
        navigationItem.rightBarButtonItem = nil
        navigationItem.titleView = searchBar
    }
}

// - MARK: View State popular movies

extension MoviesListController {
    private func setupViewModel() {
        viewModel = MoviesListViewModelFactory().create()
    }
    
    private func setupFetchMovies() {
        viewModel.fetchMoviesList()
            .successObserver(onSuccess)
            .loadingObserver(onLoading)
            .errorObserver(onError)
    }
    
    private func onSuccess(movies: MoviesDTO) {
        moviesList = movies.results
        collectionView.reloadData()
    }
    
    private func onLoading() {
        print("carregando")
    }
    
    private func onError(message: HTTPError) {
        let errorView = ErrorView()
        self.view = errorView
        
        print(message.localizedDescription)
    }
}

// - MARK: View State genres

extension MoviesListController {
    private func setupFetchGenres() {
        viewModel.fetchGenres()
            .successObserver(onSuccessGenres)
            .errorObserver(onErrorGenres)
    }
    
    private func onSuccessGenres(genres: GenresDTO) {
        let genres = genres
        GenresDTO.shared = genres
    }
    
    private func onErrorGenres(message: HTTPError) {
        print(message.localizedDescription)
    }
}

// - MARK: Setup search bar

extension MoviesListController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        navigationItem.titleView = nil
        setupSearchBar()
        inSearchMode = false
        collectionView.reloadData()
    }
        
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" || searchBar.text == nil {
            inSearchMode = false
            collectionView.reloadData()
            view.endEditing(true)
        } else {
            inSearchMode = true
            filteredMovies = moviesList.filter({ $0.title.range(of: searchText) != nil })
            collectionView.reloadData()
        }
    }
}

// - MARK: Button favorite

extension MoviesListController: MoviesListDelegate {
    func buttonFavorite(movies: ResultMoviesDTO, cell: MoviesListCell) {
        if cell.favorite.currentImage == UIImage(named: "favorite_gray_icon") {
            cell.favorite.setImage(UIImage(named: "favorite_full_icon"), for: .normal)
            addToFavorite(movie: movies)
        } else {
            cell.favorite.setImage(UIImage(named: "favorite_gray_icon"), for: .normal)
            removeFavorite(movie: movies)
        }
    }
    
    private func addToFavorite(movie: ResultMoviesDTO) {
        viewModel.loadAddToFavorite(realm: realm, movie: movie)
    }
    
    private func removeFavorite(movie: ResultMoviesDTO) {
        viewModel.loadRemoveFavorite(realm: realm, movie: movie)
    }
    
    private func setupStates() {
        viewModel.successAdding.observer(viewModel) { message in
            print(message)
        }
        
        viewModel.successRemoving.observer(viewModel) { message in
            print(message)
        }
    }
}

// Collection View delegate

extension MoviesListController: UICollectionViewDelegateFlowLayout {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if inSearchMode {
            if self.filteredMovies.isEmpty {
                let emptyView = EmptyView()
                collectionView.backgroundView = emptyView
            } else {
                collectionView.backgroundView = nil
            }
            return self.filteredMovies.count
        }
        
        return moviesList.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "moviesList", for: indexPath) as! MoviesListCell
        
        let movies = inSearchMode ? filteredMovies[indexPath.row] : moviesList[indexPath.row]
    
        cell.backgroundColor = .systemBlue
        cell.delegate = self
        cell.addComponents(with: movies)
        
        itemsFavorites = realm.objects(FavoriteEntity.self).map({ $0 })
                
        if itemsFavorites.contains(where: {$0.id == movies.id}) {
            cell.favorite.setImage(UIImage(named: "favorite_full_icon"), for: .normal)
        } else {
            cell.favorite.setImage(UIImage(named: "favorite_gray_icon"), for: .normal)
        }
    
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = DetailsViewController()
        controller.movies = inSearchMode ? filteredMovies[indexPath.row] : moviesList[indexPath.row]
        navigationController?.pushViewController(controller, animated: true)
    }
}
