//
//  FavoritesViewController.swift
//  DesafioConcrete
//
//  Created by Luiz Otavio Processo on 30/11/19.
//  Copyright © 2019 Luiz Otavio Processo. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    var favoriteView:FavoriteView?
    var favoriteMovies:[FavModel] = []
    var searchController = UISearchController()
    let searchFavMovie = SearchFavMovie()
    let dataStorage = DataStorage()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        favoriteView = FavoriteView(frame: self.view.frame)
        self.view = favoriteView
        setTableView()
        setSearchBar()
        
    }
    
    //gets data from coreData to fill the tableView
    override func viewWillAppear(_ animated: Bool) {
        favoriteMovies = dataStorage.fetchData()
        favoriteView!.table.reloadData()
    }
    
    func setTableView(){
        favoriteView?.table.delegate = self
        favoriteView!.table.dataSource = self
        favoriteView!.table.register(FavoritesTableViewCell.self, forCellReuseIdentifier: FavoritesTableViewCell.identifier)
    }
    
    func setSearchBar(){
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        navigationItem.largeTitleDisplayMode = .automatic
        self.navigationItem.searchController = searchController
    }
}

extension FavoritesViewController: UISearchBarDelegate{
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        favoriteMovies = dataStorage.fetchData()
        favoriteView!.table.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        if(!searchText.isEmpty){
            favoriteMovies = searchFavMovie.search(text: searchText, favoriteMovies: favoriteMovies)
            favoriteView!.table.reloadData()
        }else{
            favoriteMovies = dataStorage.fetchData()
            favoriteView!.table.reloadData()
        }
    }
}

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoritesTableViewCell.identifier, for: indexPath) as! FavoritesTableViewCell
        
        cell.moviePoster.image =  UIImage(data: favoriteMovies[indexPath.row].moviePoster!)
        cell.movieName.text = favoriteMovies[indexPath.row].movieName
        cell.movieDescription.text = favoriteMovies[indexPath.row].movieDescription
        
        let releaseDate = favoriteMovies[indexPath.row].movieYear?.split(separator: "-")
        cell.movieYear.text = String(releaseDate![0])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {

        if favoriteMovies.count > 0 {
            let deleteButton = UITableViewRowAction(style: .normal, title: "unfavorite") { (action, indexPath) in
                tableView.dataSource?.tableView!(tableView, commit: .delete, forRowAt: indexPath)
                return
            }
            self.favoriteMovies.remove(at: indexPath.row)
            deleteButton.backgroundColor = UIColor.red
            deleteButton.backgroundEffect = UIBlurEffect(style: .light)

            return [deleteButton]
        }
        return nil
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

        if editingStyle == .delete{
            self.dataStorage.deleteData(fav: favoriteMovies)
            self.favoriteView?.table.reloadData()

        }
    }
}


