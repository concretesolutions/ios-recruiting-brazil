//
//  FavoritesViewController.swift
//  AppMovie
//
//  Created by Renan Alves on 24/10/18.
//  Copyright © 2018 Renan Alves. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {

    var dataSource = TableViewDataSource()
    @IBOutlet weak var tableView: UITableView!
    let searchController: UISearchController = {
        let search = UISearchController(searchResultsController: nil)
        return search
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        self.setupNavigation()
    }

    override func viewWillAppear(_ animated: Bool) {
        self.dataSource.datas = ManagerMovies.shared.moviesFavorites
        self.tableView.reloadData()
    }
    
    func setupNavigation() {
        self.setupSearchController()
        self.navigationItem.title = "Favorites"
        self.navigationController?.navigationBar.barTintColor = Colors.navigationController.value
    }
    
    private func setupTableView() {
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableView.automaticDimension
        tableView.dataSource = dataSource
        tableView.delegate = self
        dataSource.identifierCell = "favoriteMoveCell"
        dataSource.datas = ManagerMovies.shared.moviesFavorites
    }
    
    private func setupSearchController() {
        searchController.searchBar.placeholder = "Pesquisa"
        navigationItem.searchController = searchController
        navigationController?.navigationBar.barTintColor = Colors.navigationController.value
        navigationItem.searchController?.searchResultsUpdater = self
        navigationItem.searchController?.hidesNavigationBarDuringPresentation = false
        navigationItem.searchController?.dimsBackgroundDuringPresentation = false
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }
    
}

//MARK: - Delegates
extension FavoritesViewController: FavoriteDelegate {
    func setFavorite(movie: Movie) {
        ManagerMovies.shared.moviesFavorites.append(movie)
        
        let index = Index.getIndexInArray(movie: movie, at: ManagerMovies.shared.movies)
        ManagerMovies.shared.movies[index].updateFavorite()
        self.dataSource.datas = ManagerMovies.shared.movies
        self.tableView.reloadData()
    }
    
    func removeFavorite(movie: Movie) {
        let index = Index.getIndexInArray(movie: movie, at: ManagerMovies.shared.moviesFavorites)
        if  index != -1 {
            ManagerMovies.shared.moviesFavorites.remove(at: index)
        }
    }
    
}

extension FavoritesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = deleteAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [delete])
    }
    func deleteAction(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: "Unfavorite") { (action, view, completion) in
            let index = Index.getIndexInArray(movie: ManagerMovies.shared.moviesFavorites[indexPath.row], at: ManagerMovies.shared.movies)
            ManagerMovies.shared.moviesFavorites.remove(at: indexPath.row)
            self.dataSource.datas = ManagerMovies.shared.moviesFavorites
            ManagerMovies.shared.movies[index].updateFavorite()
            self.tableView.reloadData()
        }
        return action
    }
}

extension FavoritesViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text {
            let resultSearch = ManagerMovies.shared.moviesFavorites.filter({$0.originalTitle.prefix(text.count) ==  text })
            let viewNotFoundMovie = WarningScreens.notFoundMovies(message: "coudn`t not find movies to:\(text)", image: UIImageView(image: UIImage(named: "search_icon")))
            viewNotFoundMovie.tag = 998
            
            if !text.isEmpty {
                if !resultSearch.isEmpty {
                    self.dataSource.datas = resultSearch
                    self.tableView.reloadData()
                }else{
                    if self.view.viewWithTag(998) == nil {
                        self.view.addSubview(viewNotFoundMovie)
                    }
                }
            }else {
                self.view.viewWithTag(998)?.removeFromSuperview()
                self.dataSource.datas = ManagerMovies.shared.moviesFavorites
                self.tableView.reloadData()
            }
            
        }
    }
}
