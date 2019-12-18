//
//  FavoritesTableViewController.swift
//  DesafioIos
//
//  Created by Kacio Henrique Couto Batista on 06/12/19.
//  Copyright © 2019 Kacio Henrique Couto Batista. All rights reserved.
//

import UIKit

final class FavoritesTableViewController: UITableViewController {
    private let cellId = "myCell"
    var movies :[Movie] = [] {
        didSet{
            self.tableView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(FavoriteMovieCellView.self, forCellReuseIdentifier: cellId)

    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let heightScreen = UIScreen.main.bounds.height
        return heightScreen * 0.2
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! FavoriteMovieCellView
        cell.movie = movies[indexPath.row]
        return cell
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
         if editingStyle == .delete {
             
             // remove the item from CoreData
             removeNSManagedObjectById(id: movies[indexPath.row].id)
             
            //get update Favorite Movies
            self.movies = self.movies.filter({ (movie) -> Bool in
                return movie.id != movies[indexPath.row].id
            })
            tableView.reloadData()            
         }
     }
}

