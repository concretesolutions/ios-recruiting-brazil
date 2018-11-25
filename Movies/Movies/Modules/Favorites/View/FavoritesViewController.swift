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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.presenter.viewDidAppear()
    }
    
    // MARK: - FavoritesView protocol functions
    
    func present(movies: [Movie]) {
        DispatchQueue.main.async {
            self.hideActivityIndicator()
            self.dataSource.update(movies: movies)
        }
    }
    
    func showRemoveFilterButton() {
        
    }
    
    func hideRemoveFilterButton() {
        
    }
    
    func delete(movieAt index: Int) {
        DispatchQueue.main.async {
            self.dataSource.delete(movieAt: index)
            self.favorites.deleteRows(at: [IndexPath(row: index, section: 0)], with: .left)
        }
    }
    
    // MARK: - Actions
    
    @objc func didTapFilterButton() {
        self.presenter.didTapFilterButton()
    }
    
    @objc func didTapHideFilterButton() {
        self.presenter.didTapRemoveFilterButton()
    }
    
    // MARK: - Aux functions
    
    private func setUpFilterButton() {
        let filterButton = UIBarButtonItem(image: UIImage(named: "FilterIcon"), style: .plain, target: self, action: #selector(self.didTapFilterButton))
        self.navigationItem.rightBarButtonItem = filterButton
    }
    
    private func setUpRemoveFilterButton() {
        self.removeFilterButton = UIButton(type: .system)
        self.removeFilterButton.setTitle("remove filters", for: .normal)
        self.removeFilterButton.addTarget(self, action: #selector(self.didTapHideFilterButton), for: .touchUpInside)
    }
    

}
