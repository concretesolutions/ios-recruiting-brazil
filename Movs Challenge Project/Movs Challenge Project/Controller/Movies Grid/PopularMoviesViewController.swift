//
//  PopularMoviesViewController.swift
//  Movs Challenge Project
//
//  Created by Jezreel de Oliveira Barbosa on 13/01/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import UIKit

class PopularMoviesViewController: UIViewController {
    // Static Properties
    // Static Methods
    // Public Types
    // Public Properties
    // Public Methods
    // Initialisation/Lifecycle Methods
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        initController()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initController()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // Override Methods
    // Private Types
    // Private Properties
    
    private var popularMoviesView: PopularMoviesView {
        return self.view as! PopularMoviesView
    }
    
    private let movieDetailsVC = MovieDetailsViewController()
    
    private var lastPage: Int? {
        return TmdbAPI.movies.max(by: {$0.page ?? -1 < $1.page ?? -1})?.page
    }
    
    private var isFetchingNewPage: Bool = true
    private var isFetchingFirstPage: Bool = true
    
    // Private Methods
    
    private func initController() {
        self.view = PopularMoviesView()
        
        movieDetailsVC.setCustomNavigationBar(title: "Movie Details", color: .mvText)
        
        popularMoviesView.collectionView.dataSource = self
        popularMoviesView.collectionView.delegate = self
        popularMoviesView.collectionView.register(PopularMovieCollectionViewCell.self, forCellWithReuseIdentifier: PopularMovieCollectionViewCell.reuseIdentifier)
        
        PopularMovieCollectionViewCell.setSize(screenSize: UIScreen.main.bounds.size)
        
        NotificationCenter.default.addObserver(self, selector: #selector(didDownloadPage), name: TmdbAPI.didDownloadPageNN, object: nil)
        
        popularMoviesView.collectionView.isUserInteractionEnabled = false
        
        TmdbAPI.fetchPopularMoviesSet()
    }
    
    @objc private func didDownloadPage() {
        DispatchQueue.main.async {
            if let page = self.lastPage, page - 1 >= 0 {
                self.isFetchingNewPage = false
                self.isFetchingFirstPage = false
                self.popularMoviesView.collectionView.reloadData()
                self.popularMoviesView.collectionView.isUserInteractionEnabled = true
            }
        }
    }
    
    @objc private func didTouchFavoriteButton(_ sender: UIButton) {
        if let cell = sender.superview?.superview as? PopularMovieCollectionViewCell, let movie = cell.movie {
            movie.isFavorite = !movie.isFavorite
        }
    }
    
    private func moviesFiltered(by section: Int) -> [Movie] {
        return TmdbAPI.movies.filter({($0.page ?? 0) - 1 == section}).sorted(by: {$0.index ?? 0 < $1.index ?? 0})
    }
}

// MARK: - CollectionView Delegate
extension PopularMoviesViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if self.isFetchingFirstPage {
            return 1
        }
        return self.lastPage ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.isFetchingFirstPage {
            return 20
        }
        return moviesFiltered(by: section).count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularMovieCollectionViewCell.reuseIdentifier, for: indexPath) as! PopularMovieCollectionViewCell
        
        if !self.isFetchingFirstPage {
            let movie = moviesFiltered(by: indexPath.section)[indexPath.row]
            cell.fill(movie: movie)
            cell.favoriteMovieButton.addTarget(self, action: #selector(didTouchFavoriteButton(_:)), for: .touchUpInside)
        }
            
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return PopularMovieCollectionViewCell.size
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if !self.isFetchingNewPage, (self.lastPage ?? 0) - 1 == indexPath.section, indexPath.row >= moviesFiltered(by: indexPath.section).count - 1  {
            self.isFetchingNewPage = true
            TmdbAPI.fetchPopularMoviesSet()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if !self.isFetchingFirstPage {
            let movie = moviesFiltered(by: indexPath.section)[indexPath.row]
            movieDetailsVC.movie = movie
            navigationController?.pushViewController(movieDetailsVC, animated: true)
        }
    }
}
