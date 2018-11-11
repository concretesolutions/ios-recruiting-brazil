//
//  FilterSelectionController.swift
//  Wonder
//
//  Created by Marcelo on 09/11/18.
//  Copyright © 2018 Marcelo. All rights reserved.
//

import UIKit
import CoreData

protocol FilterSelectionProtocol: class {
    func didUpdateOption(tuple: (String, String))
}

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
    
    weak var delegate: FilterSelectionProtocol?
    
    // MARK: - Private Properties
    private var years = [String]()
    private var genres = [String]()
    private var coreDataService : CoreDataService?
    private var appSettings = AppSettings()
    
    
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
        tableView.reloadData()
    }
    
    
    // MARK: - App Data Source
    private func loadYears() {
        let distinctYears = self.coreDataService?.getDistinctYear() ?? [NSDictionary]()
        for dic in distinctYears {
            for (_, value) in dic {
                let year = value as! String
                self.years.append(year)
            }
        }
    }
    private func loadGenres() {
        genres = appSettings.getDistinctGenres(favoriteMovies: (self.coreDataService?.getAllFavorites())!)
        print(genres)
    }
    
    // MARK: - Table View Datasource & Dlegate
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if filterSelectedRow == 0 {
            // date
            return self.years.count
        }else{
            // genre
            return self.genres.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FilterSelectionCell", for: indexPath) as! FilterSelectionCell
        if filterSelectedRow == 0 {
            // Date
            cell.filterSelectionOption.text = years[indexPath.row]
        }else{
            // Genres
            cell.filterSelectionOption.text = genres[indexPath.row]
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        var selections : (String, String)!
        if filterSelectedRow == 0 {
            // Date
            selections = (years[indexPath.row], String())
        }else{
            // Genres
            selections = (String(), genres[indexPath.row])
        }
        // return selections to the caller
        delegate?.didUpdateOption(tuple: selections)
        navigationController?.popViewController(animated: true)
    }
 

}
