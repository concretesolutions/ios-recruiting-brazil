//
//  FilterController.swift
//  Wonder
//
//  Created by Marcelo on 09/11/18.
//  Copyright © 2018 Marcelo. All rights reserved.
//

import UIKit
import CoreData

class FilterController: UIViewController, UITableViewDataSource, UITableViewDelegate, FilterSelectionProtocol {

    // MARK: - Public Properties
    public var moc : NSManagedObjectContext? {
        didSet {
            if let moc = moc {
                coreDataService = CoreDataService(moc: moc)
            }
        }
    }
    public var movies = [FavoriteMovies]()  // Core Data Model
    
    
    //MARK: - Private Properties
    private var source = [String]()
    private var selectedIndexPath = IndexPath()
    private var coreDataService : CoreDataService?
    private var selections: (String, String, Int)!
    private var eraseSelections = false
    private var filterSelection = FilterSelection()
    
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet var commandView: UIView!
    @IBOutlet weak var commandButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // setUp
        setUp()
        
    }
    
    // MARK: - App SetUp
    private func setUp() {
        // navigation bar title
        navigationItem.title = "Filter"
        
        // selections
        selections = (" "," ", -1)
        
        // filter options
        source.append("Date")
        source.append("Genres")
    }
    
    
    
    // MARK: - TableView Data Source & Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.source.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FilterCell") as! FilterCell
        cell.filterTitle.text = source[indexPath.row]
        if (indexPath.row == 0 && !filterSelection.year.isEmpty) || eraseSelections  {
            if eraseSelections {
                cell.fiterDescription.text = ""
            }else{
                cell.fiterDescription.text = filterSelection.year
            }
        }else if (indexPath.row == 1 && !filterSelection.genre.isEmpty) || eraseSelections {
            if eraseSelections {
                cell.fiterDescription.text = ""
                eraseSelections = false
            }else{
                cell.fiterDescription.text = filterSelection.genre
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectedIndexPath = indexPath
        eraseSelections = false
        performSegue(withIdentifier: "showFilterSelection", sender: self)
        
    }
    
    
    // MARK: - UI Actions
    @IBAction func eraseFilter(_ sender: Any) {
        filterSelection = FilterSelection()
        eraseSelections = true
        self.tableView.reloadData()
        view.hideCommandView(view: self.view)
    }
    
    // MARK: - Command Manager
    @IBAction func commandAction(_ sender: Any) {
        print("*** APPLY FILTER")
    }
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showFilterSelection" {
            let controller = segue.destination as! FilterSelectionController
            controller.filterSelectedRow = selectedIndexPath.row
            controller.movies = movies
            controller.moc = moc
            controller.delegate = self
        }
    }
    
    // MARK: - Filter Selection Delegate
    func didUpdateOption(filterSelection: FilterSelection) {
        self.filterSelection = filterSelection
        self.tableView.reloadData()
        if (!filterSelection.genre.isEmpty && filterSelection.genre != "") || (!filterSelection.year.isEmpty && filterSelection.year != "") {
            view.showCommandView(commandView: commandView)
        }
    }

    
    
    
}
