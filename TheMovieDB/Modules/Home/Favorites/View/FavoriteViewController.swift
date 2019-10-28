//
//  FavoriteViewController.swift
//  TheMovieDB
//
//  Created by Ranieri Aguiar on 24/10/19.
//  Copyright © 2019 Ranieri Aguiar. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController {
    
    // MARK: - Constants
    let reuseIdentifier = "FavoriteTableViewCell"
    
    // MARK: - IBOutlets
    @IBOutlet weak var favoriteTableVIew: UITableView!
    @IBOutlet weak var removeFilterButton: UIButton!
    @IBOutlet weak var removeFilterHeightConstraint: NSLayoutConstraint!
    
    // MARK: - Variables
    var moviesList: [MovieResponse]!
    var viewModel: FavoriteViewControllerViewModel!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = FavoriteViewControllerViewModel(delegate: self)
        configView()
        configFavoriteTableVIew()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        moviesList = viewModel.selectFavoritedMovies()
        favoriteTableVIew.reloadData()
    }
    
    private func configView() {
        navigationItem.searchController?.searchResultsUpdater = self
        
        let button = UIButton()
        button.setImage(UIImage(named: "FilterIcon"), for: .normal)
        button.addTarget(self, action: #selector(didTapFilter), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 53, height: 31)
        let barButton = UIBarButtonItem(customView: button)
        navigationItem.rightBarButtonItem = barButton
        
        removeFilterButton.setTitle("removeFilter".localized, for: .normal)
        removeFilterButton.backgroundColor = Colors.primary
        removeFilterButton.setTitleColor(Colors.accent, for: .normal)
    }
    
    private func configFavoriteTableVIew() {
        let cellNib = UINib(nibName: reuseIdentifier, bundle: nil)
        favoriteTableVIew.register(cellNib, forCellReuseIdentifier: reuseIdentifier)
        favoriteTableVIew.delegate = self
        favoriteTableVIew.dataSource = self
    }
}

// MARK: - SearchController
extension FavoriteViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
    }
}

// MARK: - FavoriteViewControllerProtocol
extension FavoriteViewController: FavoriteViewControllerProtocol {
    
}

// MARK: - FavoriteTableVIew
extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as! FavoriteTableViewCell
        let movie = moviesList![indexPath.row]
        cell.configureCell(with: movie)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let view = DetailsViewController()
        view.configure(with: moviesList[indexPath.row])
        navigationController?.pushViewController(view, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            viewModel.deleteFavoriteMovie(movie: moviesList[indexPath.row])
            moviesList.remove(at: indexPath.row)
            favoriteTableVIew.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "unfavorite".localized
    }
}

// MARK: - User Action
extension FavoriteViewController {
    @objc func didTapFilter() {
        let view = FilterViewController()
        navigationController?.pushViewController(view, animated: true)
    }
    
    @IBAction func didTapRemoveFilter(_ sender: UIButton) {
    }
}
