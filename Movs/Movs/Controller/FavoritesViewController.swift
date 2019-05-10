//
//  FavoritesViewController.swift
//  Movs
//
//  Created by Ygor Nascimento on 05/05/19.
//  Copyright © 2019 Ygor Nascimento. All rights reserved.
//

import UIKit
import CoreData

class FavoritesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //Outlets
    @IBOutlet weak var favoriteTableView: UITableView!
    
    
    //variables
    var stackContext = CoreDataStack(modelName: "MoviesModel").managedContext
    var movieFromCoreData = [FavoriteMovie]()
    var rows: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        favoriteTableView.delegate = self
        favoriteTableView.dataSource = self
        
        navigationItem.searchController = UISearchController(searchResultsController: nil)
        navigationItem.hidesSearchBarWhenScrolling = false
        
        let movieFetch: NSFetchRequest<FavoriteMovie> = FavoriteMovie.fetchRequest()
        
        do {
            let results = try stackContext.fetch(movieFetch)
            movieFromCoreData = results
        } catch let error as NSError{
            print("Fetch error:\(error) description:\(error.userInfo)")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieFromCoreData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as? FavoritesTableViewCell {
            let movie = movieFromCoreData[indexPath.row]
            
            cell.favoriteCellTitle.text = movie.title
            cell.favoriteCellReleaseDate.text = movie.release_date
            cell.favoriteCellOverview.text = movie.overview
            cell.favoriteCellImage.image = movie.poster as? UIImage
            
            return cell
        }
        return UITableViewCell()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
