//
//  FavoritesScreen.swift
//  movs
//
//  Created by Emerson Victor on 02/12/19.
//  Copyright © 2019 emer. All rights reserved.
//

import UIKit

class FavoritesScreen: UIView {
    // MARK: - Subviews
    lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self.controller
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search a movie by name"
        return searchController
    }()
    
    lazy var removeFiltersButton: UIButton = {
        let button = UIButton()
        button.setTitle("remove filters", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        button.backgroundColor = .label
        button.setTitleColor(UIColor(named: "LabelInverse"), for: .normal)
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.addTarget(self.controller,
                         action: #selector(self.controller?.removeFilters),
                         for: .touchUpInside)
        return button
    }()
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self.controller,
                                 action: #selector(self.controller?.reloadTableView),
                                 for: .valueChanged)
        return refreshControl
    }()
    
    lazy var favoritesTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(FavoriteMovieCell.self,
                           forCellReuseIdentifier: "FavoriteMovieCell")
        tableView.separatorStyle = .none     
        tableView.dataSource = self.controller
        tableView.delegate = self.controller
        tableView.refreshControl = self.refreshControl
        return tableView
    }()
    
    // MARK: - Controller
    weak var controller: FavoritesController?
    
    // MARK: - Initializers
    required init(frame: CGRect = .zero, controller: FavoritesController) {
        self.controller = controller
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Exception view
    func showErrorView() {
        DispatchQueue.main.async {
            self.favoritesTableView.backgroundView = ExceptionView(imageNamed: "Error",
                                                                   title: "An error has occurred. Please try again")
        }
    }
    
    func presentEmptySearch(_ shouldPresent: Bool) {
        if shouldPresent {
            DispatchQueue.main.async {
                self.favoritesTableView.backgroundView = ExceptionView(imageNamed: "EmptySearch",
                                                                       title: "Your search returned no results")
            }
        } else {
            DispatchQueue.main.async {
                self.favoritesTableView.backgroundView = nil
            }
        }
    }
    
    // MARK: - Remove filters button
    func hideButton() {
        self.removeFiltersButton.snp.updateConstraints { (make) in
            make.height.equalTo(0)
        }
        
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
    }
    
    func showButton() {
        self.removeFiltersButton.snp.updateConstraints { (make) in
            make.height.equalTo(45)
        }
        
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
    }
}

extension FavoritesScreen: CodeView {
    func buildViewHierarchy() {
        self.addSubview(self.removeFiltersButton)
        self.addSubview(self.favoritesTableView)
    }
    
    func setupConstraints() {
        self.removeFiltersButton.snp.makeConstraints { (make) in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(8)
            make.right.equalToSuperview().inset(16)
            make.left.equalToSuperview().offset(16)
            make.height.equalTo(0)
        }
        
        self.favoritesTableView.snp.makeConstraints { (make) in
            make.right.bottom.left.equalToSuperview()
            make.top.equalTo(self.removeFiltersButton.snp.bottom)
        }
    }
    
    func setupAdditionalConfiguration() {
        self.backgroundColor = .systemBackground
        self.controller?.navigationItem.searchController = self.searchController
    }
}
