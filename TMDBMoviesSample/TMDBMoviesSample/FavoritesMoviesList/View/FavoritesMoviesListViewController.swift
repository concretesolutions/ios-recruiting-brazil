//
//  MoviesListViewController.swift
//  TMDBMoviesSample
//
//  Created by Breno Rage Aboud on 03/10/18.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import UIKit

class FavoritesMoviesListViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var emptyLabel: UILabel!
    
    private lazy var tableViewManager = FavoritesMoviesTableViewManager(with: presenter)
    private lazy var presenter: FavoritesMoviesListPresenterProtocol = FavoritesMoviesListPresenter(with: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
}

//MARK: - SetupMethods -
extension FavoritesMoviesListViewController {
    private func setupTableView() {
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
    func showEmptyState() {
        emptyLabel.isHidden = false
        tableView.isHidden = true
    }
    
    func showTableView() {
        emptyLabel.isHidden = true
        tableView.isHidden = false
    }
    
    func removeRow(in indexPath: IndexPath) {
        tableView.reloadSections(IndexSet(integersIn: 0...0), with: .automatic)
    }
    
    func show(with vc: UIViewController) {
        navigationController?.show(vc, sender: nil)
    }
}
