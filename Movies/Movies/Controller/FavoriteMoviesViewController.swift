//
//  FavoriteMoviesViewController.swift
//  Movies
//
//  Created by Jonathan Martins on 18/09/18.
//  Copyright © 2018 Jonathan Martins. All rights reserved.
//

import UIKit

class FavoriteMoviesViewController: BaseViewController {
    
    /// The list of favorited movies
    //private var movies:[Movie] = []

    private unowned var favoriteMoviesView: FavoriteMoviesView{ return self.view as! FavoriteMoviesView }
    private unowned var tableView:UITableView { return favoriteMoviesView.tableView }
    
    override func loadView() {
        self.view = FavoriteMoviesView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSearchController(navBarTitle: "Favorite Movies")
        setFilterButton()
        setupBarsTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateList()
    }
    
    /// Updates the state of the list
    private func updateList(){
        tableView.reloadData()
        if User.current.favorites.isEmpty{
            self.showFeedback(message: "Your favorite list is empty")
        }
        else{
            self.showFeedback()
        }
    }
    /// Adds the filter button to the Controller
    private func setFilterButton(){
        let filter = UIBarButtonItem(image: UIImage(named: "icon_filter"), style: .plain, target: self, action: #selector(openFilterController))
        self.navigationItem.rightBarButtonItem = filter
    }
    
    /// Sets up the collectionView
    private func setupBarsTableView(){
        tableView.delegate   = self
        tableView.dataSource = self
    }
    
    /// Opens the FilterController
    @objc private func openFilterController(){
        let navigationController = UINavigationController(rootViewController: FilterViewController())
        self.present(navigationController, animated: true, completion: nil)
    }
    
    override func updateSearchResults(for searchController: UISearchController) {
        
    }
}

extension FavoriteMoviesViewController: UITableViewDelegate, UITableViewDataSource  {
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let movie         = User.current.favorites[indexPath.row]
        let unfavoriteAct = UIContextualAction(style: .destructive, title: "Unfavorite", handler: { (action, view, handler) in
            User.current.favorite(movie: movie, false)
            self.updateList()
        })
        
        return UISwipeActionsConfiguration(actions: [unfavoriteAct])
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return User.current.favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.identifier, for: indexPath) as? FavoriteCell else{
            return UITableViewCell()
        }
        cell.setupCell(movie: User.current.favorites[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailController   = DetailMovieViewController()
        detailController.movie = User.current.favorites[indexPath.row]
        self.navigationController?.pushViewController(detailController, animated: true)
    }
}
