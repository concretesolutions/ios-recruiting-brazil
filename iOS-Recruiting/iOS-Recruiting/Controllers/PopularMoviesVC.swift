//
//  PopularMoviesVC.swift
//  iOS-Recruiting
//
//  Created by Thiago Augusto on 10/12/19.
//  Copyright © 2019 sevontheedge. All rights reserved.
//

import UIKit

class PopularMoviesVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    internal var refreshControl = UIRefreshControl()
    
    internal lazy var viewModel: PopularMoviesViewModel = {
        let vm = PopularMoviesViewModel()
        vm.setView(self)
        return vm
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        let flowLayout = CollectionViewFlowLayout()
        flowLayout.flowDelegate = self
        self.collectionView.collectionViewLayout = flowLayout
        self.collectionView.register(MovieGridCell.self)
        self.refreshControl.addTarget(self, action: #selector(self.refreshList), for: .valueChanged)
        self.collectionView.addSubview(self.refreshControl)
        
        self.viewModel.getPopularMovies(reload: true)
        
    }
    
    @objc func refreshList() {
        if !self.collectionView.isDragging {
            self.refreshAction()
        }
        if self.refreshControl.isRefreshing {
            self.activityIndicator.startAnimating()
        }
    }
    
    private func refreshAction() {
        self.viewModel.getPopularMovies(reload: true)
       }
    
    private func getMovie(indexPath: IndexPath) -> Movie? {
        let movies = self.viewModel.movies?.results ?? []
        
        guard movies.indices.contains(indexPath.row) else {
            return nil
        }
        
        return movies[indexPath.row]
    }

}

extension PopularMoviesVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        guard let movies = self.viewModel.movies?.results,
            let currentPage = self.viewModel.movies?.page,
            let pages = self.viewModel.movies?.total_pages else {
                return
        }
        
        let count = movies.count

        if currentPage < pages, indexPath.row == count - 5 {
            self.viewModel.getPopularMovies()
        }
    }
}

extension PopularMoviesVC: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if self.viewModel.movies != nil {
            self.activityIndicator.startAnimating()
        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.viewModel.movies != nil {
            self.activityIndicator.stopAnimating()
        }
        
        return self.viewModel.movies?.results?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: MovieGridCell = collectionView.dequeue(for: indexPath)
        
        if let movie = self.getMovie(indexPath: indexPath) {
            cell.configure(movie)
        }
        
        return cell
    }
}

extension PopularMoviesVC: CollectionViewFlowLayoutDelegate {
    
    func numberOfColumns() -> Int {
        return 2
    }
    
    func height(at indexPath: IndexPath) -> CGFloat {
        return 350
    }
}

extension PopularMoviesVC: PopularMoviesDelegate {
    
    func reloadData() {
        
        if self.refreshControl.isRefreshing {
                   self.refreshControl.endRefreshing()
        }

       if let isAnimating = self.activityIndicator?.isAnimating, isAnimating {
           self.activityIndicator?.stopAnimating()
       }
       
       self.collectionView?.reloadData()
    }
    
}

