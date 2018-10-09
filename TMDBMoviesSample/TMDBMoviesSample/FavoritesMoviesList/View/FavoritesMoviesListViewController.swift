//
//  MoviesListViewController.swift
//  TMDBMoviesSample
//
//  Created by Breno Rage Aboud on 03/10/18.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import UIKit

class FavoritesMoviesListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private lazy var tableViewManager = FavoritesMoviesTableViewManager(with: presenter)
    private lazy var presenter: FavoritesMoviesListPresenterProtocol = FavoritesMoviesListPresenter(with: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

//MARK: - SetupMethods -
extension FavoritesMoviesListViewController {
    private func setupCollectionView() {
        tableView.delegate = tableViewManager
        tableView.dataSource = tableViewManager
        registerCells()
    }
    
    private func registerCells() {
        tableView.register(cellType: FavoriteMovieCell.self)
    }
}

//MARK: - ViewProtocol methods -
extension FavoritesMoviesListViewController: FavoritesMoviesListViewProtocol {
    func show(with vc: UIViewController) {
        navigationController?.show(vc, sender: nil)
    }
}
