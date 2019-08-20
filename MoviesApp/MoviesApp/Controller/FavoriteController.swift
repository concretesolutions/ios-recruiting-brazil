//
//  FavoriteController.swift
//  MoviesApp
//
//  Created by Eric Winston on 8/15/19.
//  Copyright © 2019 Eric Winston. All rights reserved.
//

import UIKit
import SwipeCellKit

// Protocol to get the data from the filters
protocol ReturnFilter: class{
    func getFiltersData(filters: [String])
}


class FavoriteController: UIViewController{
    let screen = FavoriteView()
    let viewModel: FavoriteViewModel
    
    init(crud: FavoriteCRUDInterface) {
        viewModel = FavoriteViewModel(crud: crud)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        self.view = screen
        screen.table.dataSource = self
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Favorites"
        
        screen.search.delegate = self
        navigationItem.titleView = screen.search
        
        let filterButton = UIBarButtonItem(image: UIImage(named: "FilterIcon"), style: .plain, target: self, action: #selector(goToFilters))
        navigationItem.rightBarButtonItem = filterButton
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if !viewModel.isFiltering{
            viewModel.loadFavorites()
            screen.table.reloadData()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        viewModel.isFiltering = false
    }
}


//MARK: - The data flux to the filter screen
extension FavoriteController: ReturnFilter{
    
    //Calls the filter screen
    @objc func goToFilters(){
        let filterVC = FilterController()
        viewModel.loadFavorites()
        filterVC.viewModel.delegate = self
        navigationController?.pushViewController(filterVC, animated: true)
    }
    
    //Returns from the filter screen
    func getFiltersData(filters: [String]) {
        viewModel.filterFavorites(filters: filters)
        screen.table.reloadData()
    }
}


//MARK: - TableView Datasorce methods
extension FavoriteController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.reuseIdentifier, for: indexPath) as! FavoriteCell
        cell.delegate = self
        cell.configure(withViewModel: viewModel.favorites[indexPath.row], image: viewModel.images[indexPath.row])
        return cell
    }
}


//MARK: - TableView swipe methods
extension FavoriteController: SwipeTableViewCellDelegate{
    // Used to simplify the deletion process
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") {[weak self](action, indexPath) in
            if let deleteMovie = self?.viewModel.favorites[indexPath.row] {
                self?.viewModel.deleteFavorite(movie: deleteMovie, at: indexPath.row)
            }
        }
    
        return [deleteAction]
    }
    
    // Configure the action of deletion in the cell
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeTableOptions()
        options.expansionStyle = .destructive
        return options
    }
}


//MARK: - Search Bar Extension
extension FavoriteController: UISearchBarDelegate{
    
    // Search by a string input
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.searchFavorites(search: searchBar.text)
        screen.table.reloadData()
    }
    
    // Return the value for the array after the search
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            DispatchQueue.main.async { [weak self] in
                self?.viewModel.loadFavorites()
                searchBar.resignFirstResponder()
                self?.screen.table.reloadData()
            }
        }
    }
}
