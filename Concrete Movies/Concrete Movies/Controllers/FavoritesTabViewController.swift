//
//  FavoritesTabViewController.swift
//  Concrete Movies
//
//  Created by Henrique Barbosa on 31/07/19.
//  Copyright © 2019 Henrique Barbosa. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class FavoritesTabViewController: ViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var favoritesBarItem: UITabBarItem!
    @IBOutlet weak var favoritesTableView: UITableView!
    var movieFavorites: [String:Movie] = ["test" : Movie()]
    
    override func viewWillAppear(_ animated: Bool) {
        self.getFavorites()
    }
    
    override func viewDidLoad() {
        favoritesTableView.delegate = self
        favoritesTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        favoritesTableView.register(UINib(nibName: "FavoriteTableViewCell", bundle: Bundle(for: FavoriteTableViewCell.self)), forCellReuseIdentifier: "FavoriteTableViewCell")
        let cell = favoritesTableView.dequeueReusableCell(withIdentifier: "FavoriteTableViewCell") as! FavoriteTableViewCell
        
        let key = String(indexPath.item)
        if(self.movieFavorites[key] != nil) {
            cell.favoriteMovieDetails.text = self.movieFavorites[key]?.details
            cell.favoriteMovieYear.text = self.movieFavorites[key]?.date
        }
        return cell
    }
}

extension FavoritesTabViewController {
    
    func getFavorites() {
        do {
            let realm = try Realm()
            let objects = realm.objects(Movie.self)
            for(index,movie) in objects.enumerated() {
                if(movie.favorite) {
                    self.movieFavorites[String(index)] = movie
                }
            }
        } catch {
            print("realm error")
        }
        
        self.favoritesTableView.reloadData()
    }
}
