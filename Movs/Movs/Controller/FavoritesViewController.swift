//
//  FavoritesViewController.swift
//  Movs
//
//  Created by Ygor Nascimento on 05/05/19.
//  Copyright © 2019 Ygor Nascimento. All rights reserved.
//

import UIKit
import CoreData

class FavoritesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITabBarDelegate {

    //Outlets
    @IBOutlet weak var favoriteTableView: UITableView!
    
    //variables
    var stackContext = CoreDataStack(modelName: "MoviesModel").managedContext
    var moviesFromCoreData = [FavoriteMovie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        favoriteTableView.delegate = self
        favoriteTableView.dataSource = self
        
        navigationItem.searchController = UISearchController(searchResultsController: nil)
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetchAndReloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesFromCoreData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as? FavoritesTableViewCell {
            
            let movie = moviesFromCoreData[indexPath.row]
            cell.favoriteCellTitle.text = movie.title
            cell.favoriteCellReleaseDate.text = movie.release_date?.maxLength(length: 4)
            cell.favoriteCellOverview.text = movie.overview
            cell.favoriteCellImage.image = movie.poster as? UIImage
            
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Unfavorite"
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let movie = moviesFromCoreData[indexPath.row]
        if editingStyle == .delete {
            moviesFromCoreData.remove(at: indexPath.row)
        }
        stackContext.delete(movie)
        do {
            try stackContext.save()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } catch let error as NSError {
            print("Saving error: \(error), description: \(error.userInfo)")
        }
    }
    
    private func fetchAndReloadData() {
        let movieFetch: NSFetchRequest<FavoriteMovie> = FavoriteMovie.fetchRequest()
        
        do {
            let results = try stackContext.fetch(movieFetch)
            moviesFromCoreData = results
            self.favoriteTableView.reloadData()
        } catch let error as NSError{
            print("Fetch error:\(error) description:\(error.userInfo)")
        }
    }
}

extension String {
    func maxLength(length: Int) -> String {
        var str = self
        let nsString = str as NSString
        if nsString.length >= length {
            str = nsString.substring(with:
                NSRange(
                    location: 0,
                    length: nsString.length > length ? length : nsString.length)
            )
        }
        return  str
}
}
