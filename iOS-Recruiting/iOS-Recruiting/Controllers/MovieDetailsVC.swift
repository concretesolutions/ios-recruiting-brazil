//
//  MovieDetailsVC.swift
//  iOS-Recruiting
//
//  Created by Thiago Augusto on 15/12/19.
//  Copyright © 2019 sevontheedge. All rights reserved.
//

import UIKit
import Foundation

class MovieDetailsVC: UIViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    internal var refreshControl = UIRefreshControl()
    
    
    internal lazy var viewModel: MovieViewModel = {
        let vm = MovieViewModel()
        vm.setView(self)
        return vm
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(MovieMainHeaderCell.self)
        self.tableView.register(MovieTextCell.self)
        self.tableView.tableFooterView = UIView()
        self.refreshControl.addTarget(self, action: #selector(self.refreshList), for: .valueChanged)
        self.tableView.addSubview(self.refreshControl)
        
        self.viewModel.getMovieDetails()
    }
    
    private func refreshAction() {
        self.viewModel.getMovieDetails()
    }
    
    
    @objc func refreshList() {
        if !self.tableView.isDragging {
            self.refreshAction()
        }
        if self.refreshControl.isRefreshing {
            self.activityIndicator.startAnimating()
        }
    }

}

extension MovieDetailsVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let isEmpty = self.viewModel.movie?.original_title?.isEmpty ?? true
        return isEmpty ? 0 : 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell: MovieMainHeaderCell = tableView.dequeue(for: indexPath)
            cell.configure(self.viewModel.movie)
            return cell
        case 1:
            let cell: MovieTextCell = tableView.dequeue(for: indexPath)
            cell.mainTextLabel.text = self.viewModel.movie?.release_date?.split{$0 == "-"}.map(String.init).first
            return cell
        case 2:
            let cell: MovieTextCell = tableView.dequeue(for: indexPath)
            cell.mainTextLabel.text =  self.viewModel.movie?.genres?.map({ $0.name ?? "" }).joined(separator: ", ")
            return cell
        case 3:
            let cell: MovieTextCell = tableView.dequeue(for: indexPath)
            cell.mainTextLabel.text = self.viewModel.movie?.overview
            return cell
        default:
            return UITableViewCell()
        }
    }

}

extension MovieDetailsVC: UITableViewDelegate {
    
   

}

extension MovieDetailsVC: UIScrollViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if self.refreshControl.isRefreshing {
            self.refreshAction()
        }
    }

}

extension MovieDetailsVC: MovieDelegate {
    
    func reloadData() {
         if self.refreshControl.isRefreshing {
             self.refreshControl.endRefreshing()
         }

        if let isAnimating = self.activityIndicator?.isAnimating, isAnimating {
            self.activityIndicator?.stopAnimating()
        }
        
         self.tableView.reloadData()
    }
}
