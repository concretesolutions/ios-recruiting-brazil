//
//  FavoriteMoviesViewController.swift
//  Movies
//
//  Created by Jonathan Martins on 18/09/18.
//  Copyright © 2018 Jonathan Martins. All rights reserved.
//

import UIKit
import JonAlert

class FavoriteMoviesViewController: BaseViewController {
    
    private unowned var favoriteMoviesView:FavoriteMoviesView { return self.view as! FavoriteMoviesView }
    
    private unowned var tableView:UITableView        { return favoriteMoviesView.tableView }
    private unowned var buttonRemoveFilter:UIButton  { return favoriteMoviesView.buttonRemoveFilter }
    
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
        checkHasFilters()
    }
    
    /// Checks if there is any filter to be applied
    private func checkHasFilters(){
        filteredMovies = User.current.favorites
        if Filter.current.hasFilters{
            showFilterButton(show: true)
            
            /// Filters by genre
            if let genre = Filter.current.genre{
                filteredMovies = filteredMovies.filter({
                    $0.genres!.contains(where: {
                        $0.id == genre.id
                    })
                })
            }
            
            if let date = Filter.current.date{
                filteredMovies = filteredMovies.filter({
                    $0.releaseDate.formatDate(fromPattern: "yyyy-mm-dd", toPattern: "yyyy").elementsEqual(date)
                })
            }
        }
        else{
            showFilterButton(show: false)
        }
        updateList()
    }
    
    /// Shows or hides the "Remove Filter" button
    func showFilterButton(show:Bool){
        if show{
            favoriteMoviesView.removeFilterButtonHeight.constant = 45
            buttonRemoveFilter.isHidden = false
            buttonRemoveFilter.layoutIfNeeded()
        }
        else{
            favoriteMoviesView.removeFilterButtonHeight.constant = 0
            buttonRemoveFilter.isHidden = true
            buttonRemoveFilter.layoutIfNeeded()
        }
    }
    
    /// Sets up the collectionView
    private func setupBarsTableView(){
        tableView.delegate   = self
        tableView.dataSource = self
        buttonRemoveFilter.addTarget(self, action: #selector(hideFilterButton), for: .touchUpInside)
    }
    
    /// Updates the state of the list
    private func updateList(){
        tableView.reloadData()
        if User.current.favorites.isEmpty{
            self.showFeedback(message: "Your favorite list is empty.")
        }
        else if filteredMovies.isEmpty{
            self.showFeedback(message: "There is no movies with the filters or search term you typed.")
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
    
    /// Hides the "Remove Filter" button
    @objc private func hideFilterButton(){
        showFilterButton(show: false)
        Filter.current.resetAll()
        filteredMovies = User.current.favorites
        updateList()
    }
    
    /// Opens the FilterController
    @objc private func openFilterController(){
        let navigationController = UINavigationController(rootViewController: FilterViewController())
        self.present(navigationController, animated: true, completion: nil)
    }
    
    override func updateSearchResults(for searchController: UISearchController) {
        triggerRequestForText(searchController.searchBar.text)
    }

    /// Triggers the timer to execute the filtering
    private func triggerRequestForText(_ term:String?){
        timer?.invalidate()
        if let text = term, !text.isEmpty {
            timer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { _ in
                print("Filtering movie with name: \(text)...")
                self.filteredMovies = User.current.favorites.filter({$0.title!.range(of: text, options: [.diacriticInsensitive, .caseInsensitive]) != nil })
                self.updateList()
            }
        }
        else{
            checkHasFilters()
        }
    }
}

extension FavoriteMoviesViewController: UITableViewDelegate, UITableViewDataSource  {
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let movie         = filteredMovies[indexPath.row]
        let unfavoriteAct = UIContextualAction(style: .destructive, title: "Unfavorite", handler: { (action, view, handler) in
            JonAlert.showSuccess(message: "Movie removed")
            User.current.favorite(movie: movie, false)
            self.checkHasFilters()
        })
        
        return UISwipeActionsConfiguration(actions: [unfavoriteAct])
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.identifier, for: indexPath) as? FavoriteCell else{
            return UITableViewCell()
        }
        cell.setupCell(movie: filteredMovies[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailController   = DetailMovieViewController()
        detailController.movie = filteredMovies[indexPath.row]
        self.navigationController?.pushViewController(detailController, animated: true)
    }
}
