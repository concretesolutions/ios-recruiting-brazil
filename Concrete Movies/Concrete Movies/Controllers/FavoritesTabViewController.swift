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
    var year: [String] = []
    var details: [String] = []
    var favorite: [Bool] = []
    
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
        if(details.first != nil) {
            cell.favoriteMovieDetails.text = details[indexPath.item]
        }
        if(year.first != nil) {
            cell.favoriteMovieYear.text = year[indexPath.item]
        }
        return cell
    }
}

extension FavoritesTabViewController: CollectionViewCellDelegate {
    
    func getFavorites() {
        let realm = try! Realm()
        let objects = realm.objects(Movie.self)
        objects.forEach { (movie) in
            if(movie.favorite) {
                self.year.append(movie.date)
                self.details.append(movie.details)
            }
        }
        self.favoritesTableView.reloadData()
    }
    
    func reloadView() {
        getFavorites()
        DispatchQueue.main.async {
            self.favoritesTableView.reloadData()
        }
    }
}
