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

class FavoritesTabViewController: ViewController {
    @IBOutlet weak var favoritesBarItem: UITabBarItem!
    @IBOutlet weak var favoritesTableView: UITableView!
    var movieFavorites: [String:Movie] = ["test" : Movie()]
    var movieIndex: [Int:Int] = [0:0]
    
    override func viewWillAppear(_ animated: Bool) {
        self.getFavorites()
    }
    
    override func viewDidLoad() {
        favoritesTableView.delegate = self
        favoritesTableView.dataSource = self
        favoritesTableView.separatorStyle = .none
    }
}

extension FavoritesTabViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieFavorites.count - 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        favoritesTableView.register(UINib(nibName: "FavoriteTableViewCell", bundle: Bundle(for: FavoriteTableViewCell.self)), forCellReuseIdentifier: "FavoriteTableViewCell")
        let cell = favoritesTableView.dequeueReusableCell(withIdentifier: "FavoriteTableViewCell") as! FavoriteTableViewCell
        
        let key = String(indexPath.item)
        if(self.movieFavorites[key] != nil && self.movieFavorites[key]!.favorite) {
            cell.favoriteMovieDetails.text = self.movieFavorites[key]?.details
            cell.favoriteMovieYear.text = self.movieFavorites[key]?.date
            cell.favoriteMovieImage.image = UIImage(data: self.movieFavorites[key]!.image!)
        } else {
            cell.favoriteMovieDetails.text = ""
            cell.favoriteMovieYear.text = ""
            cell.favoriteMovieImage.image = UIImage()
            //self.removeFavorites(self.movieFavorites[key]!)
            self.movieFavorites.removeValue(forKey: key)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.left)
            tableView.reloadData()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let action = UITableViewRowAction(style: UITableViewRowAction.Style.default, title: "Delete") { (action, indexPath) in
            tableView.beginUpdates()
            self.removeFavorites(self.movieFavorites[String(indexPath.item)]!)
            self.movieFavorites.removeValue(forKey: String(indexPath.item))
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.left)
            tableView.endUpdates()
        }
        return [action]
    }
}

extension FavoritesTabViewController {
    
    func removeFavorites(_ movie: Movie) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(movie, update: .modified)
            }
        } catch {
            print("error removing item")
        }
    }
    
    func getFavorites() {
        do {
            var index = 0
            let realm = try Realm()
            let objects = realm.objects(Movie.self)
            objects.forEach({ (movie) in
                if(movie.favorite) {
                    self.movieFavorites[String(index)] = movie
                    self.movieIndex[movie.id] = index
                    index += 1
                }
            })
        } catch {
            print("realm error")
        }
        self.favoritesTableView.reloadData()
    }
}

extension FavoritesTabViewController: FavoriteCellDelegate {
    func removeFavoriteCell(_ movieID: Int) {
       // self.movieFavorites
    }
}
