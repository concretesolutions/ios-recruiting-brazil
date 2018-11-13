//
//  PopularMoviesViewController.swift
//  Test-MovieDB
//
//  Created by Gabriel Soria Souza on 12/11/18.
//  Copyright © 2018 Gabriel Sória Souza. All rights reserved.
//

import UIKit

class PopularMoviesViewController: UIViewController {
    
    @IBOutlet weak var popularMoviesTableView: UITableView!
    @IBOutlet weak var indicatorOfActivity: UIActivityIndicatorView!
    
    var middle: PopularMoviesMiddle!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        popularMoviesTableView.delegate = self
        popularMoviesTableView.dataSource = self
        popularMoviesTableView.prefetchDataSource = self

        indicatorOfActivity.startAnimating()
        
        middle = PopularMoviesMiddle(delegate: self)
        middle.fetchMovies()
        
    }
    
    func isLoadingCell(for indexPath: IndexPath) -> Bool {
        print("middle.currentPage \(middle.currentPage)")
        return indexPath.row >= middle.currentPage
    }
    
    func visibleIndexPathsToReload(paths: [IndexPath]) -> [IndexPath] {
        let indexPathsOfVisibleRows = popularMoviesTableView.indexPathsForVisibleRows ?? []
        let indexPathsIntersection = Set(indexPathsOfVisibleRows).intersection(paths)
        return Array(indexPathsIntersection)
    }
}

extension PopularMoviesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height / 4
    }
    
}

extension PopularMoviesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return middle.popularResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "popular", for: indexPath) as! PopularMoviesTableViewCell
        if isLoadingCell(for: indexPath) {
            cell.configure(with: .none)
        } else {
            cell.configure(with: middle.movieData(at: indexPath.row))
        }
        return cell
    }
}

extension PopularMoviesViewController: PopularMoviesMiddleDelegate {
    
    func fetchCompleted(with newIndexPathsToReload: [IndexPath]?) {
        guard let newToReload = newIndexPathsToReload else {
            indicatorOfActivity.stopAnimating()
            popularMoviesTableView.reloadData()
            return
        }
        let pathsToReload = visibleIndexPathsToReload(paths: newToReload)
        popularMoviesTableView.reloadRows(at: pathsToReload, with: .automatic)
    }
    
    func fetchFailed() {
        indicatorOfActivity.stopAnimating()
        let alert = UIAlertController(title: "Ops!", message: "Erro ao carregar", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension PopularMoviesViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(where: isLoadingCell) {
            middle.fetchMovies()
        }
    }
}
