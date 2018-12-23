//
//  FavoriteMoviesTableViewController.swift
//  ConcreteApplication
//
//  Created by Bruno Cruz on 23/12/18.
//  Copyright © 2018 Bruno Cruz. All rights reserved.
//

import UIKit
import Reusable
import RealmSwift

class FavoriteMoviesTableViewController: UITableViewController {

    var favoritedMovies:[Movie] = []
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    override func viewWillAppear(_ animated: Bool) {
        getFavoriteMovies()
        self.tableView.reloadData()
    }
    
    
    func getFavoriteMovies(){
        //FIXME:- improve forEach
        self.favoritedMovies = []
        let favoriteMoviesRealm = RealmManager.shared.getAll(objectsOf: MovieRealm.self)
        favoriteMoviesRealm.forEach { (movieRealm) in
            self.favoritedMovies.append(Movie(realmObject: movieRealm))
        }
    }
    
    
    func setupTableView(){
        self.tableView.separatorStyle = .singleLine
        self.tableView.separatorColor = Design.Colors.white
        self.tableView.allowsSelection = false
        self.tableView.register(cellType: FavoriteMovieTableViewCell.self)
    }
    
}

//MARK:- dataSource
extension FavoriteMoviesTableViewController{
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.favoritedMovies.count
    }

}

//MARK:- delegate
extension FavoriteMoviesTableViewController{
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let favoriteMovieCell = tableView.dequeueReusableCell(for: indexPath, cellType: FavoriteMovieTableViewCell.self)
        favoriteMovieCell.setup(movie: favoritedMovies[indexPath.row])
        return favoriteMovieCell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height * 0.18
    }
}
