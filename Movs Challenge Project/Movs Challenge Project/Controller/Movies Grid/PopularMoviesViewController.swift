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
    
    // Private Methods
    
    private func initController() {
        self.view = PopularMoviesView()
        
        popularMoviesView.collectionView.dataSource = self
        popularMoviesView.collectionView.delegate = self
        popularMoviesView.collectionView.register(PopularMovieCollectionViewCell.self, forCellWithReuseIdentifier: PopularMovieCollectionViewCell.reuseIdentifier)
        
        PopularMovieCollectionViewCell.setSize(screenSize: UIScreen.main.bounds.size)
        
        NotificationCenter.default.addObserver(self, selector: #selector(didDownloadPage), name: TmdbAPI.didDownloadPageNN, object: nil)
        
        TmdbAPI.fetchPopularMovies()
    }
    
    @objc private func didDownloadPage() {
        DispatchQueue.main.async {
            self.popularMoviesView.collectionView.reloadData()
        }
    }
}

extension PopularMoviesViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return TmdbAPI.popularMoviePages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return TmdbAPI.popularMoviePages[section].movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularMovieCollectionViewCell.reuseIdentifier, for: indexPath) as! PopularMovieCollectionViewCell
        let movie = TmdbAPI.popularMoviePages[indexPath.section].movies[indexPath.row]
        cell.fill(movie: movie)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return PopularMovieCollectionViewCell.size
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let moviePage = TmdbAPI.popularMoviePages.last, indexPath.section == moviePage.page - 1, indexPath.row >= moviePage.movies.count - 1 {
            TmdbAPI.fetchPopularMovies()
        }
    }
}
