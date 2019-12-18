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
        view.backgroundColor = #colorLiteral(red: 0.08962006122, green: 0.1053769067, blue: 0.1344628036, alpha: 1)
        self.view = view
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.1757613122, green: 0.1862640679, blue: 0.2774662971, alpha: 1)
       
        
    }
    override func viewWillAppear(_ animated: Bool) {
       self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.8823153377, green: 0.7413565516, blue: 0.3461299241, alpha: 1)
       self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "FilterIcon"), style: .done, target: nil, action: nil)
        self.navigationItem.title = "Movies"

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        makeTableViewController()
        makeSearchController()
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
