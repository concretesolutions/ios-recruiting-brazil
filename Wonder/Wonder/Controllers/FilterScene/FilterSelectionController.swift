//
//  FilterSelectionController.swift
//  Wonder
//
//  Created by Marcelo on 09/11/18.
//  Copyright © 2018 Marcelo. All rights reserved.
//

import UIKit
import CoreData

class FilterSelectionController: UITableViewController {

    // MARK: - Public Properties
    public var moc : NSManagedObjectContext? {
        didSet {
            if let moc = moc {
                coreDataService = CoreDataService(moc: moc)
            }
        }
    }
    public var movies = [FavoriteMovies]()
    public var filterSelectedRow : Int = -1
    
    // MARK: - Private Properties
    private var years = [String]()
    private var genres = [String]()
    private var coreDataService : CoreDataService?
    
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    // MARK: - App Setup
    private func setup() {
        if filterSelectedRow == 0 {
            navigationItem.title = "Filter by Date"
            loadYears()
        }else{
            navigationItem.title = "Filter by Genre"
            loadGenres()
        }
    }
    
    
    // MARK: App Data Source
    private func loadYears() {
        let distinctYears = self.coreDataService?.getDisitinctYear() ?? [NSDictionary]()
        for dic in distinctYears {
            for (_, value) in dic {
                let year = value as! String
                years.append(year)
            }
        }
    }
    private func loadGenres() {
        genres = AppSettings.standard.getDistinctGenres(FavoriteMovies: (self.coreDataService?.getAllFavorites())!)
    }
    
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if filterSelectedRow == 0 {
            // date
            return self.years.count
        }else{
            // genre
            return self.movies.count
        }
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FilterSelectionCell", for: indexPath) as! FilterSelectionCell
        let movie = self.movies[indexPath.row]
        if filterSelectedRow == 0 {
            // Date
            cell.filterSelectionOption.text = years[indexPath.row]
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
