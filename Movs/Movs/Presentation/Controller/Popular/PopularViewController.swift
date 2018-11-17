//
//  PopularMoviesTableViewController.swift
//  Movs
//
//  Created by Adann Simões on 14/11/18.
//  Copyright © 2018 SAS. All rights reserved.
//

import UIKit

class PopularViewController: UITableViewController {
    // MARK: Behavior View IBOutlets
    @IBOutlet var emptySearchView: UIView!
    @IBOutlet var genericErrorView: UIView!
    @IBOutlet var loadingView: UIView!

    // MARK: Class Attributes
    var popularMovie: PopularMovie?
    var behavior: Behavior = .LoadingView {
        didSet {
            self.tableView.reloadData()
        }
    }
    let popularMovieCellIdentifier = "popularCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    func initialSetup() {
        fetchPopularMovieData(page: 1) { (data) -> Void in
            if data != nil {
                self.popularMovie = data
                self.setBehavior(newBehavior: .PopularMovies)
            }
        }
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        if popularMovie != nil {
            return 1
        }
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let numberOfRows = popularMovie?.results?.count {
            return numberOfRows
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: popularMovieCellIdentifier, for: indexPath) as? PopularTableViewCell
        if let data = popularMovie?.results?[indexPath.row] {
            cell?.setData(data: data, popularRanking: (indexPath.row + 1), isFavorite: false)
        }
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(200.0)
    }

}

// MARK: Frufru setup
extension PopularViewController {
    private func setBehavior(newBehavior: Behavior) {
        behavior = newBehavior
        switch behavior {
        case .PopularMovies:
            self.tableView.backgroundView?.isHidden = true
        case .EmptySearch:
            self.tableView.backgroundView?.isHidden = false
            self.tableView.backgroundView = emptySearchView
        case .LoadingView:
            self.tableView.backgroundView?.isHidden = false
            self.tableView.backgroundView = loadingView
        case .GenericError:
            self.tableView.backgroundView?.isHidden = false
            self.tableView.backgroundView = genericErrorView
        }
    }
}

// MARK: Service call
extension PopularViewController {
    func fetchPopularMovieData(page: Int, completionHandler: @escaping (PopularMovie?) -> Void) {
        setBehavior(newBehavior: .LoadingView)
        PopularMovieServices.getPopularMovie(page: page) { (data, _) in
            if data != nil {
                completionHandler(data)
            } else {
                self.setBehavior(newBehavior: .GenericError)
                completionHandler(nil)
            }
        }
    }
}
