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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        setupSearchBar()
        setupViewModel()
        setupFetchMovies()
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
    
//    @objc func btnFavorite(cell: MoviesListCell) {
//        if cell.favorite.currentImage == UIImage(named: "favorite_gray_icon") {
//            cell.favorite.setImage(UIImage(named: "favorite_full_icon"), for: .normal)
//        } else {
//            cell.favorite.setImage(UIImage(named: "favorite_gray_icon"), for: .normal)
//            print("Vish")
//        }
//    }
}

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
    }
}

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

extension MoviesListController: MoviesListDelegate {
    func buttonFavorite(movies: ResultMoviesDTO, cell: MoviesListCell) {
        if cell.favorite.currentImage == UIImage(named: "favorite_gray_icon") {
            cell.favorite.setImage(UIImage(named: "favorite_full_icon"), for: .normal)
            print("Boa")
            print(movies.title)
        } else {
            cell.favorite.setImage(UIImage(named: "favorite_gray_icon"), for: .normal)
            print("Vish")
            print(movies.title)
        }
    }
}

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
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = DetailsViewController()
        controller.movies = inSearchMode ? filteredMovies[indexPath.row] : moviesList[indexPath.row]
        navigationController?.pushViewController(controller, animated: true)
    }
}
