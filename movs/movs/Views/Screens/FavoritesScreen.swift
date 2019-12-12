//
//  FavoritesScreen.swift
//  movs
//
//  Created by Emerson Victor on 02/12/19.
//  Copyright © 2019 emer. All rights reserved.
//

import UIKit

class FavoritesScreen: UIView {
    // MARK: - Subview
    lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self.delegate
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search a movie by name"
        return searchController
    }()

    lazy var favoritesTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(FavoriteMovieCell.self,
                           forCellReuseIdentifier: "FavoriteMovieCell")
        tableView.separatorStyle = .none     
        tableView.dataSource = self.delegate
        tableView.delegate = self.delegate
        return tableView
    }()
    
    // MARK: - Delegate
    weak var delegate: FavoritesController?
    
    // MARK: - Initializers
    required init(frame: CGRect = .zero, delegate: FavoritesController) {
        self.delegate = delegate
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Exception view
    func showErrorView() {
        DispatchQueue.main.async {
            self.favoritesTableView.backgroundView = ExceptionView(type: .error)
        }
    }
    
    func presentEmptySearch(_ shouldPresent: Bool) {
        if shouldPresent {
            DispatchQueue.main.async {
                self.favoritesTableView.backgroundView = ExceptionView(type: .emptySearch)
            }
        } else {
            DispatchQueue.main.async {
                self.favoritesTableView.backgroundView = nil
            }
        }
    }
}

extension FavoritesScreen: CodeView {
    func buildViewHierarchy() {
        self.addSubview(self.favoritesTableView)
    }
    
    func setupConstraints() {
        self.favoritesTableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    func setupAdditionalConfiguration() {
        self.backgroundColor = .systemBackground
        self.delegate?.navigationItem.searchController = self.searchController
    }
}
