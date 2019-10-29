//
//  MoviesListViewController.swift
//  Movs
//
//  Created by Bruno Barbosa on 26/10/19.
//  Copyright © 2019 Bruno Barbosa. All rights reserved.
//

import UIKit

class MoviesListViewController: UIViewController {

    private var moviesCollectionView = MoviesListCollectionView()
    private var loadingIndicator = UIActivityIndicatorView(style: .large)
    private var errorView = MessageView()
    
    var viewModel: MoviesListViewModel
    
    init(with viewModel: MoviesListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Popular Movies"

        self.errorView.addAsSubview(to: self.view)
        self.view.addSubviews([self.moviesCollectionView, self.loadingIndicator])
        
        self.loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.moviesCollectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.moviesCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.moviesCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.moviesCollectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
            self.loadingIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.loadingIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
        self.moviesCollectionView.dataSource = self
        self.moviesCollectionView.delegate = self
        self.viewModel.delegate = self
        
        self.viewModel.fetchMovies()
    }

}

extension MoviesListViewController: MoviesListDelegate {
    func toggleLoading(_ isLoading: Bool) {
        if isLoading {
            self.loadingIndicator.startAnimating()
        } else {
            self.loadingIndicator.stopAnimating()
        }
        
        UIView.animate(withDuration: 0.5) {
            self.moviesCollectionView.alpha = isLoading ? 0 : 1
        }
    }
    
    func moviesListUpdated() {
        self.moviesCollectionView.reloadData()
        self.errorView.toggle(show: false)
    }
    
    func errorFetchingMovies(error: APIError) {
        self.errorView.viewModel = MessageViewModel(withImageNamed: "error", andMessage: error.rawValue)
    }
    
}

extension MoviesListViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = self.moviesCollectionView.cellSize
        return CGSize(width: size, height: size*1.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.cellCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoviesListCollectionView.MOVIE_CELL_IDENTIFIER, for: indexPath)
        
        if let cellViewModel = self.viewModel.getViewModelForCell(at: indexPath), cell is MovieCollectionCell {
            (cell as! MovieCollectionCell).viewModel = cellViewModel
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.viewModel.selectMovie(at: indexPath)
    }
}
