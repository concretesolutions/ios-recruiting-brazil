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
    @IBOutlet private var btnFilters: UIBarButtonItem!
    
    //MARK: - Actions
    @IBAction private func ShowFilters(_ sender: UIBarButtonItem) {
        
        let availableGenres = Set(FavoriteController.shared.favorites.compactMap({$0.genres}).reduce([], +))
        let availableYears = Set(FavoriteController.shared.favorites.compactMap({$0.releaseDate.year}))
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "filterVC") as! FiltersViewController
        if appliedFilters.isEmpty{
            vc.availableYears = availableYears
            vc.availableGenres = availableGenres
        }
        else{
            vc.items = appliedFilters
        }
        
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: - Variables
    private let searchController = UISearchController(searchResultsController: nil)
    private var filteredFavs = [Movie]()
    private var appliedFilters = [Filter]()
    
    private var isSearching: Bool{
        let searchBarIsEmpty = searchController.searchBar.text?.isEmpty ?? false
        return (searchController.isActive && !searchBarIsEmpty) || isFiltering
    }
    
    private var isFiltering: Bool{
        return !self.appliedFilters.isEmpty
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
        tableView.register(UINib(nibName: "RemoveFilterTableViewCell", bundle: nil), forCellReuseIdentifier: "RemoveFilterTableViewCell")
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
    
    private func filterFavsForSearchText(_ searchText: String) {
        filteredFavs = FavoriteController.shared.favorites.filter({( movie : Movie) -> Bool in
            return movie.title.lowercased().contains(searchText.lowercased())
        })
        
        tableView.reloadData()
    }
    
    private func applyFilters(_ filters: [Filter]){
        filteredFavs = FavoriteController.shared.favorites.filter({( movie : Movie) -> Bool in
            var result = true
            for filter in filters{
                guard !filter.selectedValues.isEmpty else { continue }
                if filter.property == "Dates", let year = movie.releaseDate.year{
                    result = filter.selectedValues.contains(year)
                }
                else if filter.property == "Genres"{
                    result = result && !Set(filter.selectedValues).intersection(Set(movie.genres)).isEmpty
                }
            }
            return result
        })
        self.appliedFilters = filters
        navigationItem.searchController = nil
        tableView.reloadData()
    }
    
    @objc private func removeFilters(){
        self.appliedFilters.removeAll()
        navigationItem.searchController = searchController
        tableView.reloadData()
    }
    
    private func setEmpty(){
        let hasData = isSearching ? !filteredFavs.isEmpty : !FavoriteController.shared.favorites.isEmpty
        let type = isSearching ? UITableView.EmptyListType.search : UITableView.EmptyListType.favorite
        tableView.setEmpty(for: type, hasData: hasData)
        
        let hasFavs = !FavoriteController.shared.favorites.isEmpty
        navigationItem.rightBarButtonItem = hasFavs ? btnFilters : nil
    }
    
}

//MARK: - FiltersViewControllerDelegate
extension FavoritesViewController: FiltersViewControllerDelegate{
    func didApplyFilters(filters: [Filter]) {
        self.applyFilters(filters)
    }
}

//MARK: - TableView DataSource, Delegate

extension FavoritesViewController: UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.setEmpty()
        return isSearching ? filteredFavs.count : FavoriteController.shared.favorites.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return isFiltering ? 55.0 : UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if isFiltering{
            let header = tableView.dequeueReusableCell(withIdentifier: "RemoveFilterTableViewCell") as! RemoveFilterTableViewCell
            header.btnRemove.addTarget(self, action: #selector(removeFilters), for: .touchUpInside)
            return header
        }
        return nil
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
