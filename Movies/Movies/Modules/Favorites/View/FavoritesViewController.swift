//
//  FavoritesViewController.swift
//  Movies
//
//  Created by Renan Germano on 23/11/2018.
//  Copyright © 2018 Renan Germano. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController, FavoritesView {
    
    // MARK: - Outlets
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var favorites: FavoritesTableView!
    
    // MARK: - Properties
    
    var presenter: FavoritesPresentation!
    private var removeFilterButton: UIButton!
    private var delegate: FavoritesTVDelegate!
    private var dataSource: FavoritesTVDataSource!
    private var searchDelegate: FavoritesSearchBarDelegate!
    
    // MARK: - Life cicle functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = FavoritesTVDelegate(presenter: self.presenter)
        self.favorites.delegate = self.delegate
        
        self.dataSource = FavoritesTVDataSource(tableView: self.favorites, presenter: self.presenter)
        self.favorites.dataSource = self.dataSource
        
        self.searchDelegate = FavoritesSearchBarDelegate(presenter: self.presenter, viewController: self)
        self.searchBar.delegate = self.searchDelegate
        
        self.setUpFilterButton()
        self.setUpRemoveFilterButton()

        self.navigationItem.title = "Favorites"
        self.showActivityIndicator()
        
        self.presenter.viewDidLoad()
    }
    
    // MARK: - FavoritesView protocol functions
    
    func present(movies: [Movie]) {
        DispatchQueue.main.async {
            self.hideRemoveFilterButton()
            self.dataSource.update(movies: movies)
        }
    }
    
    func showRemoveFilterButton() {
        
    }
    
    func hideRemoveFilterButton() {
        
    }
    
    // MARK: - Actions
    
    @objc func didTapFilterButton() {
        
    }
    
    @objc func didTapHideFilterButton() {
        
    }
    
    // MARK: - Aux functions
    
    private func setUpFilterButton() {
        let filterButton = UIBarButtonItem(image: UIImage(named: "FilterIcon"), style: .plain, target: self, action: #selector(self.didTapFilterButton))
        self.navigationController?.navigationItem.rightBarButtonItem = filterButton
    }
    
    private func setUpRemoveFilterButton() {
        self.removeFilterButton = UIButton(type: .system)
        self.removeFilterButton.setTitle("remove filters", for: .normal)
        self.removeFilterButton.addTarget(self, action: #selector(self.didTapHideFilterButton), for: .touchUpInside)
    }
    

}
