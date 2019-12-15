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
    @IBOutlet weak var searchBar: UISearchBar!
    
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
        self.collectionView.register(ActivityIndicationFooter.self, kind: .footer)
        self.refreshControl.addTarget(self, action: #selector(self.refreshList), for: .valueChanged)
        self.collectionView.addSubview(self.refreshControl)
        self.refreshControl.beginRefreshing()
        self.searchBar.delegate = self
        
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
        let movies = self.viewModel.movieList ?? []
        
        guard movies.indices.contains(indexPath.row) else {
            return nil
        }
        
        return movies[indexPath.row]
    }

}

extension PopularMoviesVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        guard let movies = self.viewModel.movieList,
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

extension PopularMoviesVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let selector = #selector(self.searchBarTextDidEndTyping)
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: selector, object: searchBar)
        self.perform(selector, with: searchBar, afterDelay: 1)
    }

    
    @objc private func searchBarTextDidEndTyping(searchBar: UISearchBar) {
        guard let text = searchBar.text, text.count >= 3 else {
            self.viewModel.resetSearch()
            return
        }
        
        if text.count >= 3 {
            self.viewModel.search(byName: text)
        }
    }
    
}

extension PopularMoviesVC: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        guard self.viewModel.movieList != nil else {
            self.activityIndicator.startAnimating()
            return 0
        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return self.viewModel.movieList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionFooter:
            let currentPage = self.viewModel.movies?.page ?? 0
            let pages = self.viewModel.movies?.total_pages ?? 0
            if currentPage < pages {
                let footer: ActivityIndicationFooter = collectionView.dequeue(for: indexPath, kind: .footer)
                footer.activityIndicatorView.startAnimating()
                return footer
            }
            
        default:
            break
        }
        
        return UICollectionReusableView()
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
       
        self.collectionView.reloadData()
        self.collectionView.collectionViewLayout.invalidateLayout()
    }
    
    
     func showTableError(type: errorType) {
        self.activityIndicator.stopAnimating()
        switch type {
        case .undefined:
            let error = ErrorView()
            error.configure(type: type)
            error.delegate = self
            self.collectionView.backgroundView = error
        case .none:
            self.collectionView.backgroundView = nil
        default:
            break
        }
    }
}


extension PopularMoviesVC: UIScrollViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if self.refreshControl.isRefreshing {
            self.refreshAction()
        }
    }

}

extension PopularMoviesVC: ErrorDelegate {
    
    func retry() {
        self.collectionView.backgroundView = nil
        self.refreshList()
    }

}

