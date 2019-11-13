//
//  FavoriteViewController.swift
//  MovieApp
//
//  Created by Giuliano Accorsi on 07/11/19.
//  Copyright © 2019 Giuliano Accorsi. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController {
    
    let controller: FavoriteController = FavoriteController()
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.backgroundColor = .background
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    private lazy var dataSource = FavoriteTableViewDataSource(tableView: self.tableView, delegate: self)
    
    override func loadView() {
        super.loadView()
        setupView()
        setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        controller.getMovies()
        tableView.reloadData()
    }
    
    func setupView() {
        self.navigationController?.view.tintColor = .orange
        title = Strings.titleFavorites
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.font: UIFont(name: Strings.fontProject, size: 30)!,
             NSAttributedString.Key.foregroundColor: UIColor.orange]
        controller.delegate = self
    }
    
    func setupLayout() {
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    
}

extension FavoriteViewController: FavoriteDataSourceDelegate {
    func editStyle(movie: MovieSave) {
        controller.delete(movie: movie) { (success) in
            if success {
                controller.getMovies()
                tableView.reloadData()
            }
        }
    }
    
    func didSelected(movie: MovieSave) {
        let viewController = DetailViewController(movie: movie)
        navigationController?.pushViewController(viewController, animated: true)
        
    }
}

extension FavoriteViewController: FavoriteControllerDelegate {
    func showMovies(movies: [MovieSave]) {
        dataSource.updateMovies(movies: movies)
    }
}
