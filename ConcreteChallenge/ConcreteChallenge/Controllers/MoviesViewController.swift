//
//  ViewController.swift
//  ConcreteChallenge
//
//  Created by Kaique Damato on 10/1/20.
//  Copyright © 2020 KiQ. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController, UISearchResultsUpdating, MovieCollectionDelegate {
    
    private let spacing: CGFloat = 16.0
    
    var isFetchingData = false
    var loadingView: LoadingReusableView?
    
    let movieCollection: MovieColletion
    let genreCollection: GenreCollection
    
    var isSearchBarEmpty: Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }
    
    var isFiltering: Bool {
      return searchController.isActive && !isSearchBarEmpty
    }
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        
        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: Cells.movie)
        collectionView.register(LoadingReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: Cells.loading)
        
        return collectionView
    }()
    
    lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Movies"
        
        return searchController
    }()
    
    lazy var emptyStateView: EmptyStateView = {
        let emptyStateView = EmptyStateView()
        
        emptyStateView.translatesAutoresizingMaskIntoConstraints = false
        emptyStateView.isHidden = true
        emptyStateView.delegate = self
        
        return emptyStateView
    }()
    
    init(movieCollection: MovieColletion, genreCollection: GenreCollection) {
        self.movieCollection = movieCollection
        self.genreCollection = genreCollection
        super.init(nibName: nil, bundle: nil)
        
        movieCollection.delegate = self
        view.backgroundColor = .white
        
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieCollection.requestMovies()
        definesPresentationContext = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        
        self.navigationItem.searchController = searchController
    }
    
    func addSubviews() {
        view.addSubview(collectionView)
        view.addSubview(emptyStateView)
    }
    
    func setupConstraints() {
        emptyStateView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        emptyStateView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        emptyStateView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32).isActive = true
        emptyStateView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32).isActive = true
        
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        movieCollection.filterContentForSearchText(searchBar.text!)
        
        updateUIForEmptySearch()
    }
    
    func reload() {
        isFetchingData = false
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func failToFetch() {
        isFetchingData = false
        
        if movieCollection.count == 0 {
            emptyStateView.state = .requestError
            DispatchQueue.main.async {
                self.collectionView.isHidden = true
                self.emptyStateView.isHidden = false
            }
        }
    }
}

extension MoviesViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, EmptyStateViewDelegate {
    
    func retryRequest() {
        movieCollection.requestMovies()
        
        DispatchQueue.main.async {
            self.collectionView.isHidden = false
            self.emptyStateView.isHidden = true
        }
    }
    
    
    func updateUIForEmptySearch() {
        emptyStateView.state = .emptySearch
        
        if isFiltering && movieCollection.countFilteredMovies == 0 {
            collectionView.isHidden = true
            emptyStateView.isHidden = false
        } else {
            collectionView.isHidden = false
            emptyStateView.isHidden = true
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isFiltering {
            return movieCollection.countFilteredMovies
        }
        return movieCollection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cells.movie, for: indexPath) as? MovieCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let movie: Movie?
        
        if isFiltering {
            movie = movieCollection.filteredMovie(at: indexPath.row)
        } else {
            movie = movieCollection.movie(at: indexPath.row)
        }
        
        guard let m = movie else { return UICollectionViewCell() }
        
        cell.posterView = PosterView(for: m)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = view.frame.height * 0.35
        
        let numberOfItemsPerRow: CGFloat = 2
        let spacingBetweenCells: CGFloat = 16
        
        let totalSpacing = (2 * self.spacing) + ((numberOfItemsPerRow - 1) * spacingBetweenCells)
        
        let width = (collectionView.bounds.width - totalSpacing) / numberOfItemsPerRow
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie: Movie?
        
        if isFiltering {
            movie = movieCollection.filteredMovie(at: indexPath.row)
        } else {
            movie = movieCollection.movie(at: indexPath.row)
        }
        
        guard let m = movie else { return }
        
        let movieDetailViewController = MovieDetailViewController(movie: m, movieCollection: movieCollection, genreCollection: genreCollection)
        
        present(movieDetailViewController, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if isFetchingData || isFiltering {
            return CGSize.zero
        } else {
            return CGSize(width: collectionView.bounds.size.width, height: 55)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionFooter {
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Cells.loading, for: indexPath) as! LoadingReusableView
            
            footerView.setup()
            loadingView = footerView
            
            return footerView
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        if elementKind == UICollectionView.elementKindSectionFooter {
            self.loadingView?.activityIndicator.startAnimating()
        }
    }

    func collectionView(_ collectionView: UICollectionView, didEndDisplayingSupplementaryView view: UICollectionReusableView, forElementOfKind elementKind: String, at indexPath: IndexPath) {
        if elementKind == UICollectionView.elementKindSectionFooter {
            self.loadingView?.activityIndicator.stopAnimating()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == movieCollection.count - 1 && !self.isFetchingData {
            loadMoreData()
        }
    }

    func loadMoreData() {
        if !isFetchingData {
            isFetchingData = true
            movieCollection.requestMovies()
        }
    }
}
