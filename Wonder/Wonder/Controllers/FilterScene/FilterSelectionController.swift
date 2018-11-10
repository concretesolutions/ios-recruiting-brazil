//
//  FilterSelectionController.swift
//  Wonder
//
//  Created by Marcelo on 09/11/18.
//  Copyright © 2018 Marcelo. All rights reserved.
//

import UIKit

class FilterSelectionController: UITableViewController {

    // MARK: - Public Properties
    public var movies = [FavoriteMovies]()
    public var filterSelectedRow : Int = -1
    
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        

    }

    // MARK: - App Setup
    private func setup() {
        if filterSelectedRow == 0 {
            navigationItem.title = "Filter by Date"
        }else{
            navigationItem.title = "Filter by Genre"
        }
    }
    
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movies.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FilterSelectionCell", for: indexPath) as! FilterSelectionCell
        let movie = self.movies[indexPath.row]
        if filterSelectedRow == 0 {
            // Date
            cell.filterSelectionOption.text = movie.year
        }else{
            // Genres
            cell.filterSelectionOption.text = movie.genre
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
 

}
