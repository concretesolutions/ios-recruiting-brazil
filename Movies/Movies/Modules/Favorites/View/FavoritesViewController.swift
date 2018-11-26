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
    private var emptyView: UIView!
    private var favoritesTop: NSLayoutConstraint!
    private var favoritesTopToRemoveFiltersButton: NSLayoutConstraint!
    
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
        self.setUpFavorites()

        self.navigationItem.title = "Favorites"
        self.showActivityIndicator()
        self.setUpEmptyView()
        
        self.favoritesTop = self.favorites.topAnchor.constraint(equalTo: self.searchBar.bottomAnchor)
        self.favoritesTop.isActive = true
        
        self.presenter.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.presenter.viewDidAppear()
    }
    
    // MARK: - FavoritesView protocol functions
    
    func present(movies: [Movie]) {
        DispatchQueue.main.async {
            self.searchBar.isUserInteractionEnabled = true
            self.emptyView.isHidden = true
            self.favorites.isHidden = false
            self.hideActivityIndicator()
            self.dataSource.update(movies: movies)
        }
    }
    
    func showRemoveFilterButton() {
        DispatchQueue.main.async {
            self.removeFilterButton.isHidden = false
            self.favoritesTop.isActive = false
            self.favoritesTop = self.favorites.topAnchor.constraint(equalTo: self.searchBar.bottomAnchor)
            self.favoritesTopToRemoveFiltersButton.isActive = true
            self.favorites.updateConstraints()
        }
    }
    
    func hideRemoveFilterButton() {
        DispatchQueue.main.async {
            self.removeFilterButton.isHidden = true
            self.favoritesTop.isActive = true
            self.favoritesTopToRemoveFiltersButton.isActive = false
            self.favoritesTopToRemoveFiltersButton = self.favorites.topAnchor.constraint(equalTo: self.removeFilterButton.bottomAnchor, constant: 8)
            self.favorites.updateConstraints()
        }
    }
    
    func delete(movieAt index: Int) {
        DispatchQueue.main.async {
            self.dataSource.delete(movieAt: index)
            self.favorites.deleteRows(at: [IndexPath(row: index, section: 0)], with: .left)
        }
    }
    
    func presentEmptyView() {
        DispatchQueue.main.async {
            self.hideActivityIndicator()
            if let searchText = self.searchBar.text {
                if searchText.isEmpty {
                    self.searchBar.isUserInteractionEnabled = false
                }
            } else {
                self.searchBar.isUserInteractionEnabled = false
            }
            self.favorites.isHidden = true
            self.emptyView.isHidden = false
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
        self.removeFilterButton = UIButton(frame: .zero)
        self.removeFilterButton.setTitle("Remove filters", for: .normal)
        self.removeFilterButton.addTarget(self, action: #selector(self.didTapHideFilterButton), for: .touchUpInside)
        self.removeFilterButton.layer.borderWidth = 3
        self.removeFilterButton.layer.cornerRadius = 8
        self.removeFilterButton.layer.borderColor = UIColor(displayP3Red: 247/256, green: 206/256, blue: 91/256, alpha: 1).cgColor
        self.removeFilterButton.titleLabel?.textColor = UIColor(displayP3Red: 247/256, green: 206/256, blue: 91/256, alpha: 1)
        self.removeFilterButton.backgroundColor = .white
        self.removeFilterButton.setTitleColor(UIColor(displayP3Red: 247/256, green: 206/256, blue: 91/256, alpha: 1), for: .normal)
        
        self.removeFilterButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.removeFilterButton)
        self.removeFilterButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 8).isActive = true
        self.removeFilterButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -8).isActive = true
        self.removeFilterButton.topAnchor.constraint(equalTo: self.searchBar.bottomAnchor, constant: 8).isActive = true
        self.removeFilterButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        self.removeFilterButton.isHidden = true
    }
    
    private func setUpFavorites() {
        self.favoritesTopToRemoveFiltersButton = self.favorites.topAnchor.constraint(equalTo: self.removeFilterButton.bottomAnchor, constant: 8)
    }
    
    private func setUpEmptyView() {
        self.emptyView = UIView(frame: .zero)
        self.emptyView.translatesAutoresizingMaskIntoConstraints = false
        let messageLabel = UILabel(frame: .zero)
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.text = "No registers found."
        messageLabel.textAlignment = .center
        messageLabel.numberOfLines = 0
        self.emptyView.addSubview(messageLabel)
        messageLabel.leftAnchor.constraint(equalTo: self.emptyView.leftAnchor, constant: 8).isActive = true
        messageLabel.rightAnchor.constraint(equalTo: self.emptyView.rightAnchor, constant: -8).isActive = true
        messageLabel.centerYAnchor.constraint(equalTo: self.emptyView.centerYAnchor).isActive = true
        self.view.addSubview(self.emptyView)
        self.emptyView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.emptyView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        self.emptyView.topAnchor.constraint(equalTo: self.searchBar.bottomAnchor).isActive = true
        self.emptyView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        self.emptyView.isHidden = true
    }

}
