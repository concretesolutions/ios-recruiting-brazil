//
//  MoviesListController.swift
//  Movs
//
//  Created by Joao Lucas on 08/10/20.
//

import UIKit

class MoviesListController: UICollectionViewController {

    private let searchController = UISearchController(searchResultsController: nil)
    private var moviesList = [ResultMoviesDTO]()
    
    private var viewModel: MoviesListViewModel!

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
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.searchBar.placeholder = "Search a movie"

        self.navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    @objc func btnFavorite(cell: MoviesListCell) {
        if cell.favorite.currentImage == UIImage(named: "favorite_gray_icon") {
            cell.favorite.setImage(UIImage(named: "favorite_full_icon"), for: .normal)
            print("Boa")
        } else {
            cell.favorite.setImage(UIImage(named: "favorite_gray_icon"), for: .normal)
            print("Vish")
        }
    }
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
        print(message.localizedDescription)
    }
}

extension MoviesListController: UICollectionViewDelegateFlowLayout {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesList.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "moviesList", for: indexPath) as! MoviesListCell
        
        let movies = moviesList[indexPath.row]
    
        cell.backgroundColor = .systemBlue
        cell.favorite.addTarget(self, action: #selector(btnFavorite(cell:)), for: .touchUpInside)
        
        cell.title.text = movies.title

        return cell
    }
}
