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
    func didUpdateOption(filterSelection: FilterSelection)
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
    public var filterSelection = FilterSelection()
    
    weak var delegate: FilterSelectionProtocol?
    
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
        genres = AppSettings.standard.getDistinctGenres(favoriteMovies: (self.coreDataService?.getAllFavorites(filterSelection: FilterSelection()))!)
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
            cell.filterSelectionOption.text = years[indexPath.row]
        }else{
            cell.filterSelectionOption.text = genres[indexPath.row]
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if filterSelectedRow == 0 {
            // Date
            filterSelection.year = years[indexPath.row]
            filterSelection.yearIndexPath = indexPath
        }else{
            // Genres
            filterSelection.genre = genres[indexPath.row]
            filterSelection.genreIndexPath = indexPath
        }
        // return selections to the caller
        delegate?.didUpdateOption(filterSelection: filterSelection)
        navigationController?.popViewController(animated: true)
    }
    
}
