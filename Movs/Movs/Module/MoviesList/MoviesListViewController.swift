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
    
    var viewModel = MoviesListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(self.moviesCollectionView)
        self.view.addSubview(self.loadingIndicator)
        self.view.addSubview(self.errorView)
        self.toggleErrorMessage(show: false)
        
        self.loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.moviesCollectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.moviesCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.moviesCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.moviesCollectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
            self.loadingIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.loadingIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            
            self.errorView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.errorView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.errorView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.errorView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
        self.moviesCollectionView.dataSource = self
        self.moviesCollectionView.delegate = self
        self.viewModel.delegate = self
        
        self.viewModel.fetchMovies()
    }

    func toggleErrorMessage(show: Bool) {
        UIView.animate(withDuration: 0.5) {
            self.errorView.alpha = show ? 1 : 0
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MoviesListViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = self.moviesCollectionView.cellSize
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfCells
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoviesListCollectionView.MOVIE_CELL_IDENTIFIER, for: indexPath)
        
        if let cellViewModel = self.viewModel.getViewModelForCell(at: indexPath), cell is MovieCollectionCell {
            (cell as! MovieCollectionCell).viewModel = cellViewModel
        }
        
        return cell
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
        self.toggleErrorMessage(show: false)
    }
    
    func errorFetchingMovies(error: APIError) {
        self.errorView.viewModel = MessageViewModel(withImageNamed: "error", andMessage: error.rawValue)
        self.toggleErrorMessage(show: true)
    }
    
}
