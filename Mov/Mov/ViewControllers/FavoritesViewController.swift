//
//  FavoritesViewController.swift
//  Mov
//
//  Created by Allan on 03/10/18.
//  Copyright © 2018 Allan Pacheco. All rights reserved.
//

import UIKit

final class FavoritesViewController: BaseViewController {

    //MARK: - Outlets
    @IBOutlet weak private var tableView: UITableView!
    
    //MARK: - Actions
    @IBAction private func ShowFilters(_ sender: UIBarButtonItem) {
        
        let availableGenres = Set(FavoriteController.shared.favorites.compactMap({$0.genres}).reduce([], +))
        let availableYears = Set(FavoriteController.shared.favorites.compactMap({$0.releaseDate.year}))
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "filterVC") as! FiltersViewController
        vc.availableYears = availableYears
        vc.availableGenres = availableGenres
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: - Variables
    private let searchController = UISearchController(searchResultsController: nil)
    private var filteredFavs = [Movie]()
    
    private var isSearching: Bool{
        let searchBarIsEmpty = searchController.searchBar.text?.isEmpty ?? false
        return searchController.isActive && !searchBarIsEmpty
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(reloadFavs(_:)), name: Notification.Name(rawValue: "favoritesChanged"), object: nil)
    }
    
    override func setupInterface() {
        super.setupInterface()
        currentTitle = "Favorites"
        tableView.register(UINib(nibName: "FavoriteTableViewCell", bundle: nil), forCellReuseIdentifier: "FavoriteTableViewCell")
        tableView.tableFooterView = UIView(frame: .zero)
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.backgroundColor = Constants.Colors.yellow
        searchController.searchBar.barTintColor = Constants.Colors.darkyellow
        searchController.searchBar.tintColor = UIColor.black
        searchController.hidesNavigationBarDuringPresentation = false
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    //MARK: - Methods
    
    @objc private func reloadFavs(_ notification: Notification){
        self.tableView.reloadData()
    }
    
    func filterFavsForSearchText(_ searchText: String) {
        filteredFavs = FavoriteController.shared.favorites.filter({( movie : Movie) -> Bool in
            return movie.title.lowercased().contains(searchText.lowercased())
        })
        
        tableView.reloadData()
    }

}

//MARK: - TableView DataSource, Delegate

extension FavoritesViewController: UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearching ? filteredFavs.count : FavoriteController.shared.favorites.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 117.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteTableViewCell", for: indexPath) as! FavoriteTableViewCell
        let fav = isSearching ? filteredFavs[indexPath.row] : FavoriteController.shared.favorites[indexPath.row]
        cell.setup(with: fav)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let fav = isSearching ? filteredFavs[indexPath.row] : FavoriteController.shared.favorites[indexPath.row]
        self.showDetail(of: fav)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return UITableViewCell.EditingStyle.delete
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return !isSearching
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Unfavorite"
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        print("Removing favorite...")
        FavoriteController.shared.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
}

// MARK: - UISearchResultsUpdating Delegate
extension FavoritesViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        filterFavsForSearchText(searchController.searchBar.text!)
    }
}
