//
//  FavoriteMoviesController.swift
//  DesafioConcrete
//
//  Created by Kacio Henrique Couto Batista on 05/12/19.
//  Copyright © 2019 Kacio Henrique Couto Batista. All rights reserved.
//

import UIKit
import SnapKit
class FavoriteMoviesController: UIViewController ,UISearchResultsUpdating{
    
    var favoriteMovies:[Movie] = getFavoritesMovies() {
        didSet{
            tableViewController.movies = self.favoriteMovies
        }
    }
    var tableViewController = FavoritesTableViewController()
    override func loadView() {
        let view = UIView(frame: UIScreen.main.bounds)
        view.backgroundColor = .blue
        self.view = view
        self.title = "Movies"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "FilterIcon"), style: .done, target: nil, action: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        makeSearchController()
        makeTableViewController()
    }
    override func viewDidAppear(_ animated: Bool) {
        self.favoriteMovies = getFavoritesMovies()
        
    }
    func makeTableViewController(){
        self.addChild(tableViewController)
        self.view.addSubview(tableViewController.view)
    }
    func makeSearchController(){
        let searchController = UISearchController(nibName: nil, bundle: nil)
        self.navigationItem.searchController = searchController
        self.definesPresentationContext = true
        searchController.searchResultsUpdater = self
    }
    //MARK: - protocol function SearchBarController Updating
    func updateSearchResults(for searchController: UISearchController) {
        if searchController.searchBar.text == ""{
            tableViewController.movies = favoriteMovies
        }
        else {
            tableViewController.movies = favoriteMovies.filter({ movie in
                return movie.title.lowercased().contains(searchController.searchBar.text!.lowercased())
            })
        }
        self.tableViewController.tableView.reloadData()
    }
}
