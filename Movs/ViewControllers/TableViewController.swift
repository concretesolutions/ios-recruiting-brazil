//
//  TableViewController.swift
//  Movs
//
//  Created by Filipe Merli on 19/06/19.
//  Copyright © 2019 Filipe Merli. All rights reserved.
//

import UIKit

class TableViewController: UIViewController, Alerts {
// MARK: - Properties
    private let list = "fcell"
    private var viewModel: MoviesViewModel!
    @IBOutlet var indicatorView: UIActivityIndicatorView!
    @IBOutlet var tableView: UITableView!
    
    private var shouldShowLoadingCell = false
    
// MARK: - ViewController Delegates
    override func viewDidLoad() {
        super.viewDidLoad()
        indicatorView.isHidden = false
        indicatorView.startAnimating()
        tableView.isHidden = true
        tableView.dataSource = self
        tableView.prefetchDataSource = self
        viewModel = MoviesViewModel(delegate: self)
        viewModel.fetchPopularMovies()
    }
    
    func isLoadingCell(for indexPath: IndexPath) -> Bool {
        return indexPath.row >= viewModel.currentCount
    }
    
    func visibleIndexPathsToReload(intersecting indexPaths: [IndexPath]) -> [IndexPath] {
        let indexPathsForVisibleRows = tableView.indexPathsForVisibleRows ?? []
        let indexPathsIntersection = Set(indexPathsForVisibleRows).intersection(indexPaths)
        return Array(indexPathsIntersection)
    }
}

// MARK: - UITableViewDataSource
extension TableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.totalCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: list, for: indexPath)
        if isLoadingCell(for: indexPath) {
            indicatorView.isHidden = false
            indicatorView.startAnimating()
        } else {
            cell.textLabel?.text = viewModel.movie(at: indexPath.row).title
            cell.detailTextLabel?.text = viewModel.movie(at: indexPath.row).posterUrl
            indicatorView.isHidden = true
            indicatorView.stopAnimating()
        }
        return cell
    }
}

// MARK: - UITableViewDataSourcePrefetching
extension TableViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(where: isLoadingCell) {
            viewModel.fetchPopularMovies()
        }
    }
}

// MARK: - MoviesViewModelDelegate
extension TableViewController: MoviesViewModelDelegate {
    func onFetchCompleted(with newIndexPathsToReload: [IndexPath]?) {
        guard let newIndexPathsToReload = newIndexPathsToReload else {
            DispatchQueue.main.async {
                self.indicatorView.stopAnimating()
                self.tableView.isHidden = false
                self.tableView.reloadData()
            }
            return
        }
        let indexPathsToReload = visibleIndexPathsToReload(intersecting: newIndexPathsToReload)
        tableView.reloadRows(at: indexPathsToReload, with: .automatic)
    }
    
    func onFetchFailed(with reason: String) {
        indicatorView.stopAnimating()
        
        let title = "Alerta"
        let action = UIAlertAction(title: "OK", style: .default)
        displayAlert(with: title , message: reason, actions: [action])
    }
}
