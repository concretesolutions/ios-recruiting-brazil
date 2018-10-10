//
//  FavoritesController.swift
//  ios_recruit_challenge
//
//  Created by Lucas de Brito on 09/10/2018.
//  Copyright © 2018 Lucas de Brito. All rights reserved.
//

import UIKit

class FavoritesController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var favoritesView = FavoritesView()
    let cellId = "cellId"
    var favoriteMovieIndexList:[Int] = []
    var favoriteMovieArray:[FavoriteMovie] = []
    
    override func viewDidLoad() {
        self.view.backgroundColor = .red
        setupView()
        setupUserData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupUserData()
        favoritesView.tableView.reloadData()
    }
    
    func setupView(){
        favoritesView = FavoritesView(frame: self.view.frame)
        favoritesView.tableView.delegate = self
        favoritesView.tableView.dataSource = self
        favoritesView.tableView.register(FavoritesTableViewCell.self, forCellReuseIdentifier: cellId)
        self.view.addSubview(favoritesView)
    }
    
    func setupUserData(){
        if UserDefaultsManager.shared.isThereAnyFavoriteMovie{
            favoriteMovieArray = UserDefaultsManager.shared.favoriteMoviesArray
            favoriteMovieIndexList = UserDefaultsManager.shared.favoriteMoviesIndexArray
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteMovieArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as! FavoritesTableViewCell
        cell.nameLabel.text = favoriteMovieArray[indexPath.row].movieTitle!
        cell.photoView.loadImage(urlString: "https://image.tmdb.org/t/p/w200/" + favoriteMovieArray[indexPath.row].moviePosterUrl!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
}
